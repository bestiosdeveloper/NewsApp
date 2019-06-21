//
//  ArrayExtention.swift
//
//  Created by Pramod Kumar on 19/09/17.
//  Copyright © 2017 Pramod Kumar. All rights reserved.
//


import Foundation
extension Array where Element : Equatable {
    
    /// MARK:- Removes the first given object
    mutating func removeFirst(_ element: Element) {
        guard let index = self.index(of: element) else { return }
        self.remove(at: index)
    }
    
    ///Removes a given object from array if present. otherwise does nothing
    mutating func removeObject(_ object : Iterator.Element) {
        if let index = self.index(of: object) {
            self.remove(at: index)
        }
    }
    
    ///Removes an array of objects
    mutating func removeObjects(array: [Element]) {
        for object in array {
            self.removeObject(object)
        }
    }
    
    ///Removes all null values present in an Array
    mutating func removeNullValues(){
        self = self.compactMap{ $0 }
    }
    
    ///Returns a sub array within the range
    subscript(range: Range<Int>) -> Array {
        
        var array = Array<Element>()

        let min = range.lowerBound
        let max = range.upperBound
        
        for i in min..<max {
            array = array+[self[i]]
        }
        return array
    }
}
extension Array where Element: Copying {
    func clone() -> Array {
        var copiedArray = Array<Element>()
        for element in self {
            copiedArray.append(element.copy())
        }
        return copiedArray
    }
}
//MARK: Copying Protocol
protocol Copying {
    init(original: Self)
}

extension Copying {
    func copy() -> Self {
        return Self.init(original: self)
    }
}



extension Array where Element: Equatable {
    mutating func isContainDuplicates() -> Bool {
        for value in self {
            if self.contains(value) {
               return true
            }
        }
        return false
    }

}

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

extension Array {
    func toJson() -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
}

extension Array where Element: Equatable {
    func contains(array: [Element]) -> Bool {
        if array.isEmpty { return true }
        for item in array {
            if !self.contains(item) { return false }
        }
        return true
    }
    
    func containsArray(array: [Element]) -> Bool {
        return !array.contains { !self.contains($0) }
    }
}

extension Array where Element: Equatable {
    mutating func remove(object: Element) {
        if let index = self.index(of: object) {
            self.remove(at: index)
        }
    }
}

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}

extension Array {
    public func joined(separator: String = "") -> String {
        return self.reduce("") { $0 + ("\($0)".isEmpty ? "\($1)" : "\(separator)\($1)") }
    }
}
