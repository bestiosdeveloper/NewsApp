//
//  AppGlobals.swift
//
//  Created by Pramod Kumar on 07/06/19.
//  Copyright © 2019 Pramod Kumar. All rights reserved.
//

import UIKit

///**********************************///
///************  GLOBALS ************///

func printDebug<T>(_ obj : T) {
    print(obj)
}

typealias JsonDictionary = [String:Any]

func delay(seconds: Double, completion: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}

///************  GLOBALS ************///
///**********************************///


enum AppConstants {
    static let apiKey = "105c922b69f045d894fe423b86fbe660"
}


extension AppDelegate {
    static let shared: AppDelegate = UIApplication.shared.delegate as! AppDelegate
}

extension SceneDelegate {
    static var shared: SceneDelegate? {
        guard let scene = UIApplication.shared.connectedScenes.first else {
            fatalError("There is no scene connected to the window. Or You might not using SwiftUI")
        }
        
        return scene.delegate as? SceneDelegate
    }
}
