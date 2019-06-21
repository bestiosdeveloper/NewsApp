//
//  APICaller+Apartments.swift
//
//  Created by Pramod Kumar on 07/06/19.
//  Copyright © 2019 Pramod Kumar. All rights reserved.
//

import Foundation

extension APICaller {

    ///Getting list of coTenant form backend server with pagination
    func callGetAllNewsAPI(param: JsonDictionary,
                              callBack: @escaping(_ success: Bool, _ message: String, _ list:[Article])->()) {
        
        self.helperJSON.callAPI(url: EndPoint.everything.url, params: param, method: .GET, requestType: .Raw) { (responseAny, error, headerResponse) in
            
            
            self.handleResponse(responseAny, err: error, header: headerResponse) { (success, jsonData, message) in
                
                var list: [Article] = []
                if success, let json = jsonData, let articals = json["articles"] as? [JsonDictionary] {
                    list = Article.getModels(json: articals)
                }
                callBack(success, error?.localizedDescription ?? "", list)
            }
        }
    }
}
