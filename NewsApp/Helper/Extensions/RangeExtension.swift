//
//  RangeExtension.swift
//
//  Created by Pramod Kumar on 14/06/19.
//  Copyright © 2019 Pramod Kumar. All rights reserved.
//

import Foundation

extension Range where Bound == String.Index {
    func asNSRange(inString: String) -> NSRange {
        let location = self.lowerBound.utf16Offset(in: inString)
        let length = self.upperBound.utf16Offset(in: inString) - location
        return NSRange(location: location, length: length)
    }
}
