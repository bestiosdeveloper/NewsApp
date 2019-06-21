//
//  DispatchQueueExtension.swift
//
//  Created by Pramod Kumar on 19/09/17.
//  Copyright © 2017 Pramod Kumar. All rights reserved.
//


import Foundation
import UIKit

extension DispatchQueue{
    
    ///Delays the executon of 'closer' block upto a given time
    class func delay(_ delay:Double, closure:@escaping ()->()) {
        
        self.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC),
            execute: closure
        )
    }
    
    ///Returns the main queue asynchronuously
    class func mainAsync(_ closure:@escaping ()->()){
        self.main.async(execute: {
            closure()
        })
    }
    
    ///Returns the main queue synchronuously
    class func mainSync(_ closure:@escaping ()->()){
        self.main.sync(execute: {
            closure()
        })
    }
    
    ///Returns the background queue asynchronuously
    class func backgroundAsync(_ closure:@escaping ()->()){
        self.global().async(execute: {
            closure()
        })
    }
    
    ///Returns the background queue synchronuously
    class func backgroundSync(_ closure:@escaping ()->()){
        self.global().sync(execute: {
            closure()
        })
    }
}
