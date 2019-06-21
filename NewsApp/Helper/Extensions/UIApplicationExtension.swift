//
//  UIApplicationExtension.swift
//
//  Created by Pramod Kumar on 19/09/17.
//  Copyright © 2017 Pramod Kumar. All rights reserved.
//


import Foundation
import UIKit
import SafariServices

extension UIApplication {
    
    ///Opens Settings app
    @nonobjc class var openSettingsApp:Void{
        
        if #available(iOS 10.0, *) {
            self.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        } else {
            // Fallback on earlier versions
            self.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
        }
    }
    
    ///Disables the ideal timer of the application
    @nonobjc class var disableApplicationIdleTimer:Void {
        self.shared.isIdleTimerDisabled = true
    }
    
    ///Enables the ideal timer of the application
    @nonobjc class var enableApplicationIdleTimer:Void {
        self.shared.isIdleTimerDisabled = false
    }
    
    ///Can get & set application icon badge number
    @nonobjc class var appIconBadgeNumber:Int{
        get{
          return UIApplication.shared.applicationIconBadgeNumber
        }
        set{
            UIApplication.shared.applicationIconBadgeNumber = newValue
        }
    }
    
    ///A unique string that can be used for giving the name for any file
    var uniqueID: String {
        return UUID().uuidString
    }
    
    ///Can get application status bar background view
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            
            let moreNavigationController = tab.moreNavigationController
            
            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return topViewController(base: top)
            } else if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
    
    class func openSafariViewController(forUrlPath urlPath: String, delegate: SFSafariViewControllerDelegate?, completion: (() -> Void)?) {
        if let url = urlPath.toUrl {
            UIApplication.openSafariViewController(forUrl: url, delegate: delegate, completion: completion)
        }
    }
    
    class func openSafariViewController(forUrl url: URL, delegate: SFSafariViewControllerDelegate?, completion: (() -> Void)?) {
        let safariVC = SFSafariViewController(url: url)
        UIApplication.topViewController()?.present(safariVC, animated: true, completion: completion)
        safariVC.delegate = delegate
    }
    
    func makeStatusBatBlur() {
//        let blurEffect = UIBlurEffect(style: .regular)
//        let blurredStatusBar = UIVisualEffectView(effect: blurEffect)
//        blurredStatusBar.translatesAutoresizingMaskIntoConstraints = false
        
        let view = UIView()
        view.frame = self.statusBarView?.bounds ?? CGRect(x: 0.0, y: 0.0, width: UIDevice.screenWidth, height: 20.0)
        view.backgroundColor = .red
        self.statusBarView?.insertSubview(view, at: 0)
    }
}
