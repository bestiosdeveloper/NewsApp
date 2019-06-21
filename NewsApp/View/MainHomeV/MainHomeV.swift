//
//  MainHomeV.swift
//  NewsApp
//
//  Created by Pramod Kumar on 14/06/19.
//  Copyright © 2019 Pramod Kumar. All rights reserved.
//

import SwiftUI

struct MainHomeV : View {
    @State private var searchQuery: String = "cricket"
    @EnvironmentObject var viewModel: MainHomeVM
    
    var todayStr: String {
        Date().toString(dateFormat: "EEE, dd MMM yyyy")
    }
    
    var body: some View {
        NavigationView {
            List {
                SearchBarV(text: $searchQuery, placeholder: Text("Search"), onCommit: search)
                ForEach(viewModel.articals.identified(by: \.self)) { artcl in
                    NavigationButton(
                    destination: NewsDetailV(article: artcl)) {
                        NewsRowV(article: artcl)
                    }
                }
                }.navigationBarTitle(Text(todayStr))
            }.onAppear(perform: search)
    }
    
    private func search() {
        viewModel.search(forQuery: searchQuery)
    }
}

#if DEBUG
struct MainHomeV_Previews : PreviewProvider {
    static var previews: some View {
        MainHomeV()
    }
}
#endif
