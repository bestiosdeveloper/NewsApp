//
//  MainHomeVM.swift
//  NewsApp
//
//  Created by Pramod Kumar on 14/06/19.
//  Copyright © 2019 Pramod Kumar. All rights reserved.
//

import SwiftUI
import Combine

class MainHomeVM: BindableObject {
    
    var articals: [Artical] = [] {
        didSet {
            didChange.send(self)
        }
    }
    
    var didChange = PassthroughSubject<MainHomeVM, Never>()
    
    func search(forQuery searchQuery: String) {
        var param = JsonDictionary()
        param["q"] = searchQuery
        
        let todayStr = Date().add(days: -2)?.toString(dateFormat: "yyyy-MM-dd") ?? ""
        if !todayStr.isEmpty {
            param["from"] = todayStr
        }
        param["sortBy"] = "publishedAt"
        param["apiKey"] = AppConstants.apiKey
        
        APICaller.shared.callGetAllNewsAPI(param: param) { [weak self](success, errorMsg, artcl) in
            if success {
                self?.articals = artcl
            }
            else {
                self?.articals = []
            }
        }
    }
}
