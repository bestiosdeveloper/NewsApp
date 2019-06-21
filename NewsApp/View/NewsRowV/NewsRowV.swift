//
//  NewRowV.swift
//  NewsApp
//
//  Created by Pramod Kumar on 14/06/19.
//  Copyright © 2019 Pramod Kumar. All rights reserved.
//

import SwiftUI

struct NewsRowV : View {
    let article: Article
    
    var body: some View {
        
        HStack {
            Image("ic_news_placeholder")
                .frame(width: 55.0, height: 41.0, alignment: Alignment.center)
                .scaledToFit()
                .clipped()
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.headline)
                    Text(article.description)
                        .font(.subheadline)
                }
            }
    }
}

#if DEBUG
struct NewsRowV_Previews : PreviewProvider {
    static var previews: some View {
        NewsRowV(article: Article.getDefault())
    }
}
#endif
