//
//  PKNetworking.swift
//
//  Created by Pramod Kumar on 07/06/19.
//  Copyright © 2019 Pramod Kumar. All rights reserved.
//


import UIKit


enum RequestMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum RequestType {
    case urlEncoded
    case Raw
}

enum AuthType {
    /// default means no authenticatio is available
    case `default`
    case  BASIC
}

enum PKNetworkingErrors {
    case noInternet
    case errorInParsing
    case serverError
    
    var message: String {
        switch self {
        case .noInternet: return "Please check internet connection."
        case .errorInParsing: return "Got an error while parsing the json."
        case .serverError: return "Got an error from server."
            
        @unknown default: return ""
        }
    }
}

class PKNetworking {
    
    var authType: AuthType = .default //No Auth
    var authID = ""
    var authPassword = ""
    var BASIC_AUTH_64_STRING = ""
    
    var timeOut  = 30.0
    
    var tag: Int = 0
    
    var delegate: PKNetworkingDelegate?

    typealias callBack = (_ response: Any?, _ error: Error?, _ responseHeader: URLResponse?)->Void

    private var session: URLSession!
    
    init() {
        let defaultConfig = URLSessionConfiguration.default
        self.session = URLSession(configuration: defaultConfig, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    
    func callAPI(url: String, params: [String: Any], method: RequestMethod, requestType: RequestType = .Raw, header:[String: String] = [:], handler:@escaping callBack ) {
        
        guard let mURL = URL(string: url) else {
            printDebug("Invalid URL")
            return
        }
        
        var request = URLRequest(url: mURL)
        
        request.timeoutInterval = self.timeOut
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
        if let authString = self.getAuthenticationString() {
            request.setValue(authString, forHTTPHeaderField: "Authorization")
        }

        if method == .POST || method == .PUT || method ==  .DELETE {
            switch requestType {
                
            case .Raw:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = self.dataWRawRequest(params: params)
                
            case .urlEncoded:
                
                let dataToSend = self.dataWithUrlEncodedRequest(params: params)
                
                request.setValue("\(dataToSend?.count ?? 0)", forHTTPHeaderField: "Content-Length")
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                
                request.httpBody = dataToSend
            }
        } else  if method == .GET {
            guard let dataToSend = self.dataWithUrlEncodedRequest(params: params) else {
                printDebug("Invalid params")
                return
            }
            guard let strData = String(data: dataToSend, encoding: .utf8) else {
                printDebug("Invalid encoding in GET")
                return
            }
            let finalUrlString = "\(mURL)?\(strData)"
            guard let finalURL = URL (string: finalUrlString) else {
                printDebug("Invalid URL creation")
                return
            }
            request.url = finalURL
        }
        
        
        //setting header for language
        
        
        //setting header fields
        request.allHTTPHeaderFields = header
        
        if self.delegate?.checkReachability() == .notReachable {
            handler(nil, NSError(domain: PKNetworkingErrors.noInternet.message, code: 112, userInfo: nil), nil)
            self.delegate?.errorNetworkNotReachable()
            return
        }
        
        self.delegate?.onPreExecute(self, dictionaryToBePassed: params)
        
        let dataTask = self.session.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async(execute: {
                
                self.delegate?.onPostExecute(self, data: data, response: response)
                
                if let error = error {
                    self.delegate?.onRequestFail(self, data: data, response: response)
                    printDebug(error)
                    handler(nil,error, response)
                }
                
                guard let unwrappedData = data else {
                    printDebug(error)
                    handler(nil,error, response)
                    return
                }
                
                let jsonObj = try? JSONSerialization.jsonObject(with: unwrappedData, options: JSONSerialization.ReadingOptions.allowFragments)
                printDebug("response for \(method.rawValue) \(url) \(params)\n\(String(describing: jsonObj))" )
                handler(jsonObj,error, response)
            })
        }
        
        dataTask.resume()
    }
}


//MARK: - Private func -
extension PKNetworking {
    private func getAuthenticationString()-> String? {
        switch self.authType {
        case .default:
            return nil
        case .BASIC:
            if !self.BASIC_AUTH_64_STRING.isEmpty {
                return self.BASIC_AUTH_64_STRING
            } else {
                let authStr = "\(self.authID):\(self.authPassword)"
                if let authData = authStr.data(using: .utf8) {
                    let authValue = "Bearer \(authData.base64EncodedData(options: Data.Base64EncodingOptions(rawValue: 0)))"
                    return authValue
                } else {
                    return nil
                }
            }
        }
    }
    
    private func dataWithUrlEncodedRequest(params: [String : Any]?) -> Data? {
        guard let anEncoding = params?.urlEncoding().data(using: .utf8) else {
            return nil
        }
        return anEncoding
    }
    
    
    private func dataWRawRequest(params : [String : Any]?) -> Data? {
        var jsonData: Data? = nil
        if let aParams = params {
            jsonData = try? JSONSerialization.data(withJSONObject: aParams, options: .prettyPrinted)
        }
        if jsonData != nil {
            return jsonData
        } else {
            return nil
        }
    }
}

protocol PKNetworkingDelegate: class {
    
    func onPreExecute(_ obj: PKNetworking, dictionaryToBePassed: [String: Any])
    func onPostExecute(_ obj: PKNetworking, data: Data?, response: URLResponse?)
    func onRequestFail(_ obj: PKNetworking, data: Data?, response: URLResponse?)
    
    func checkReachability() -> ReachabilityStatus
    func errorNetworkNotReachable()
}

extension PKNetworkingDelegate {
    
    func onPreExecute(_ obj: PKNetworking, dictionaryToBePassed: [String: Any]) { }
    func onPostExecute(_ obj: PKNetworking, data: Data?, response: URLResponse?) { }
    func onRequestFail(_ obj: PKNetworking, data: Data?, response: URLResponse?) { }
    
    func checkReachability() -> ReachabilityStatus {
        guard let reach = Reachability.networkReachabilityForInternetConnection() else {
            return ReachabilityStatus.notReachable
        }
        return reach.currentReachabilityStatus
    }
    
    func errorNetworkNotReachable() {
        
    }
}


//MARK: - Dictionary(URLEncoded)
fileprivate extension Dictionary {
    func urlEncode(obj: Any)-> String {
        return "\(obj)"
    }
    
    func urlEncoding()-> String {
        var a:[String] = []
        for (key,value) in self {
            let part = "\(self.urlEncode(obj: key))=\(self.urlEncode(obj: value))"
            a.append(part)
        }
        let final = a.joined(separator: "&")
        return final
    }
}
