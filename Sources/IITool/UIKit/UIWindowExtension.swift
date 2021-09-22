//
//  File.swift
//  
//
//  Created by ice on 2021/9/17.
//

import UIKit

// MARK: - Properties
public extension UIWindow {
    /// IITool: return the top ViewController
    var topMostViewController: UIViewController? {
        var top = UIWindow.key?.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        
        return top
    }
    
    /// IITool: return the key windows
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
