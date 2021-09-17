//
//  UIViewControllerExtension.swift
//  
//
//  Created by ice on 2021/9/3.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Properties
public extension UIViewController {
    /// IITool: Check if ViewController is onscreen and not hidden.
    var isVisible: Bool {
        // http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
        return isViewLoaded && view.window != nil
    }
    
    /// IITool: Check if ViewController is present or push.
    var isModal: Bool {
        let index = navigationController?.viewControllers.firstIndex(of: self)
        
        let presentingIsNavigationFirst = (index ?? 0) == 0
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController

        return presentingIsNavigationFirst && ( presentingIsModal || presentingIsNavigation || presentingIsTabBar )
    }
}

// MARK: - Methods
public extension UIViewController {
    /// IITool: Instantiate UIViewController from storyboard.
    ///
    /// - Parameters:
    ///   - storyboard: Name of the storyboard where the UIViewController is located.
    ///   - bundle: Bundle in which storyboard is located.
    ///   - identifier: UIViewController's storyboard identifier.
    /// - Returns: Custom UIViewController instantiated from storyboard.
    class func instantiate(from storyboard: String? = nil, bundle: Bundle? = nil, identifier: String? = nil) -> Self {
        let storyboardName = storyboard ?? String(describing: self)
        let viewControllerIdentifier = identifier ?? String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        guard let viewController = storyboard
            .instantiateViewController(withIdentifier: viewControllerIdentifier) as? Self else {
            preconditionFailure(
                "Unable to instantiate view controller with identifier \(viewControllerIdentifier) as type \(type(of: self))")
        }
        return viewController
    }
    
    func presentAnyway(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if !isViewLoaded || (view.window == nil) {
            guard let window = UIApplication.shared.keyWindow else {
                return
            }
            
            window.topViewController?.present(viewControllerToPresent, animated: true)
        } else {
            present(viewControllerToPresent, animated: true)
        }
    }
}

#endif
