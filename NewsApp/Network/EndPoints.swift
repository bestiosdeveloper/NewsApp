//
//  EndPoints.swift
//
//  Created by Pramod Kumar on 07/06/19.
//  Copyright © 2019 Pramod Kumar. All rights reserved.
//


import Foundation

enum EndPoint : String {
    
    //MARK: - Base URLs
    
    case BASE_URL               =       "https://newsapi.org/v2/"

    //MARK: - Account URLs -
    case everything                  =       "everything"
}

//MARK: - endpoint extension for url -
extension EndPoint {
    
    var url: String {
        
        switch self {
        case .BASE_URL:
            return self.rawValue
        default:
            let tmpString = "\(EndPoint.BASE_URL.rawValue)\(self.rawValue)"
            return tmpString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        }
    }
}
