//
//  SearchBarV.swift
//  NewsApp
//
//  Created by Pramod Kumar on 14/06/19.
//  Copyright © 2019 Pramod Kumar. All rights reserved.
//
import SwiftUI

struct SearchBarV : View {
    
    @State var text: Binding<String>
    var placeholder: Text? = nil
    var onEditingChanged: (Bool) -> Void = { _ in }
    var onCommit: () -> Void = { }

    var body: some View {
        TextField(text, placeholder: placeholder, onEditingChanged: onEditingChanged, onCommit: onCommit)
            .background(Color.gray.opacity(0.3))
            .padding(EdgeInsets(top: 0.0, leading: 16.0, bottom: 0, trailing: 16.0))
    }
}
