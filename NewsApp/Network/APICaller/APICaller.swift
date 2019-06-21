//
//  APICaller.swift
//
//  Created by Pramod Kumar on 07/06/19.
//  Copyright © 2019 Pramod Kumar. All rights reserved.
//

import Foundation

class APICaller {
    
    static let shared = APICaller()
    
    let helperJSON = PKNetworking()
    
    private init() {
        self.helperJSON.delegate = self
        self.helperJSON.authType = .BASIC
        self.helperJSON.BASIC_AUTH_64_STRING = ""
    }
}

extension APICaller {
    
    func handleResponse(_ response: Any?, err: Error?, header: URLResponse?, completion:@escaping (_ success: Bool, _ json: JsonDictionary?, _ internalMessage: String?)->() ) {
        
        if let err = err {
            completion(false, nil, err.localizedDescription)
            return
        } else {
            guard let responseUnwrapped = response as? JsonDictionary, let status = responseUnwrapped["status"], "\(status)".lowercased() == "ok" else {
                completion(false, nil, PKNetworkingErrors.serverError.message)
                return
            }
            
            printDebug(responseUnwrapped)
            completion(true, responseUnwrapped, nil)
        }
    }
}



//MARK: - DSNetworkingDelegate implementation -
extension APICaller: PKNetworkingDelegate {
    
    func onPreExecute(_ obj: PKNetworking, dictionaryToBePassed: [String: Any]) { }
    
    func onPostExecute(_ obj: PKNetworking, data: Data?, response: URLResponse?) { }
    
    func onRequestFail(_ obj: PKNetworking, data: Data?, response: URLResponse?) {
    }
    
    func checkReachability() -> ReachabilityStatus {
        guard let reach = Reachability.networkReachabilityForInternetConnection() else {
            return ReachabilityStatus.notReachable
        }
        return reach.currentReachabilityStatus
    }
    
    func errorNetworkNotReachable() {
        
    }
}
