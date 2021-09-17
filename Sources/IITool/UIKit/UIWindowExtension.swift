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
    var topViewController: UIViewController? {
        get {
            var top = self.rootViewController
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
    }
}
