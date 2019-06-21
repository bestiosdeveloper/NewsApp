//
//  NewsImageV.swift
//  NewsApp
//
//  Created by Pramod Kumar on 14/06/19.
//  Copyright © 2019 Pramod Kumar. All rights reserved.
//

import SwiftUI

struct NewsImageV : View {
    var image: Image
    
    var body: some View {
        image
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 1))
            .shadow(radius: 10)
    }
}

#if DEBUG
struct NewsImageV_Previews : PreviewProvider {
    static var previews: some View {
        NewsImageV(image: Image(systemName: "photo"))
    }
}
#endif
