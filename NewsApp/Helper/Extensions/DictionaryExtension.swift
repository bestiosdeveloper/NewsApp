//
//  DictionaryExtension.swift
//
//  Created by Pramod Kumar on 02/01/19.
//  Copyright © 2019 Pramod Kumar. All rights reserved.
//

import Foundation

extension Dictionary where Value: Equatable {
    func someKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}
