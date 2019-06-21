//
//  NewsDetailV.swift
//  NewsApp
//
//  Created by Pramod Kumar on 14/06/19.
//  Copyright © 2019 Pramod Kumar. All rights reserved.
//

import SwiftUI

struct NewsDetailV : View {
    
    let article: Article
    
    private let imageWidth: CGFloat = (UIDevice.screenWidth-30.0)
    
    var body: some View {
            VStack(alignment: .center) {
                Image("ic_news_placeholder")
                    .frame(width: imageWidth, height: imageWidth * 0.5, alignment: Alignment.center)
                    .scaledToFill()
                
                Text(verbatim: article.title)
                    .lineLimit(nil)
                    .font(.headline)
                
                HStack {
                    Image(uiImage: #imageLiteral(resourceName: "ic_publish"))
                        .frame(width: 20.0, height: 20.0, alignment: Alignment.center)
                    Text(article.publishDate?.toString(dateFormat: "d MMM, yyyy") ?? defaultText)
                        .font(.system(size: 12.0))
                    
                    Spacer()
                    
                    Image(uiImage: #imageLiteral(resourceName: "ic_author"))
                        .frame(width: 20.0, height: 20.0, alignment: Alignment.center)
                    Text(article.sourceName)
                        .font(.system(size: 12.0))
                }
                .padding(EdgeInsets(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
                
                Text(article.description)
                    .lineLimit(nil)
                    .font(.subheadline)
                    .padding(.top, 16.0)
            }
            .padding(EdgeInsets(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
                .offset(x: 0, y: -180)
                .padding(.bottom, -180)
    }
}

#if DEBUG
struct NewsDetailV_Previews : PreviewProvider {
    static var previews: some View {
        NewsDetailV(article: Article.getDefault())
    }
}
#endif
