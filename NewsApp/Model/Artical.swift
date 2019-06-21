//
//  Artical.swift
//
//  Created by Pramod Kumar on 07/06/19.
//  Copyright © 2019 Pramod Kumar. All rights reserved.
//

import Foundation

let defaultText: String = "N/A"

struct Artical: Hashable {
    
    var sourceId: String = defaultText
    var sourceName: String  = defaultText
    
    var author: String = defaultText
    var title: String = defaultText
    var description: String = defaultText
    var url: String = defaultText
    var urlToImage: String = defaultText
    var publishedAt: String = defaultText
    var content: String = defaultText
    
    var publishDate: Date? {
        //"2019-06-07T10:37:36Z"
        return self.publishedAt.toDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
    }
    
    var imageUrl: URL? {
        return URL(string: urlToImage)
    }
    
    
    init(json: JsonDictionary) {
        
        if let source = json["source"] as? JsonDictionary {
            if let obj = source["id"] {
                self.sourceId = "\(obj)"
            }
            
            if let obj = source["name"] {
                self.sourceName = "\(obj)"
            }
        }
        
        if let obj = json["author"] {
            self.author = "\(obj)"
        }
        
        if let obj = json["title"] {
            self.title = "\(obj)"
        }
        
        if let obj = json["description"] {
            self.description = "\(obj)"
        }
        
        if let obj = json["url"] {
            self.url = "\(obj)"
        }
        
        if let obj = json["urlToImage"] {
            self.urlToImage = "\(obj)"
        }
        
        if let obj = json["publishedAt"] {
            self.publishedAt = "\(obj)"
        }
        
        if let obj = json["content"] {
            self.content = "\(obj)"
        }
    }
    
    static func getModels(json: [JsonDictionary]) -> [Artical] {
        return json.map { Artical(json: $0) }
    }
    
    static func getDefault() -> Artical {
        let data: JsonDictionary = ["source": [
            "id": nil,
            "name": "Firstpost.com"
        ],
        "author": "Press Trust of India",
        "title": "RBI rate cuts unlikely to push credit demand as NBFC crisis deepens, banks look for growth capital: Report",
        "description": "Credit growth is unlikely to pick up despite the three successive rate cuts by the central bank due to the capital constraints at banks and the deepening crisis in the non-banking lenders sector, warns a report The post RBI rate cuts unlikely to push credit d…",
        "url": "https://www.firstpost.com/business/rbi-rate-cuts-unlikely-to-push-credit-demand-as-nbfc-crisis-deepens-banks-look-for-growth-capital-report-6773751.html",
        "urlToImage": "https://images.firstpost.com/wp-content/uploads/2018/06/rupee-bundles-reuters3.jpg",
        "publishedAt": "2019-06-07T10:37:36Z",
        "content": "Mumbai: Credit growth is unlikely to pick up despite the three successive rate cuts by the central bank due to the capital constraints at banks and the deepening crisis in the non-banking lenders sector, warns a report.\r\nThe Reserve Bank had cut its key polic… [+2920 chars]"
        ]
        
        return Artical(json: data)
    }
}


//"source": {
//    "id": null,
//    "name": "Firstpost.com"
//},
//"author": "Press Trust of India",
//"title": "RBI rate cuts unlikely to push credit demand as NBFC crisis deepens, banks look for growth capital: Report",
//"description": "Credit growth is unlikely to pick up despite the three successive rate cuts by the central bank due to the capital constraints at banks and the deepening crisis in the non-banking lenders sector, warns a report The post RBI rate cuts unlikely to push credit d…",
//"url": "https://www.firstpost.com/business/rbi-rate-cuts-unlikely-to-push-credit-demand-as-nbfc-crisis-deepens-banks-look-for-growth-capital-report-6773751.html",
//"urlToImage": "https://images.firstpost.com/wp-content/uploads/2018/06/rupee-bundles-reuters3.jpg",
//"publishedAt": "2019-06-07T10:37:36Z",
//"content": "Mumbai: Credit growth is unlikely to pick up despite the three successive rate cuts by the central bank due to the capital constraints at banks and the deepening crisis in the non-banking lenders sector, warns a report.\r\nThe Reserve Bank had cut its key polic… [+2920 chars]"
//}
