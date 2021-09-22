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
    
    /// IITool: get Top Most ViewController.
    var topMostViewController: UIViewController {
        return UIWindow.key?.topMostViewController ?? self
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
    
    /// IITool: Present ViewController anyway (on top most view controller).
    ///
    /// - Parameters:
    ///   - viewControllerToPresent: ViewController will present.
    ///   - flag: animated flag.
    ///   - completion: completion action.
    func presentAnyway(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        topMostViewController.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    /// IITool: show standard loading view.
    ///
    /// - Parameters:
    ///   - maskScreen: black background view.
    func showLoading(_ maskScreen: Bool = false) {
        if let _ = view.subviews.first(where: { $0.tag == -10001 }) {
            return
        }

        view.isUserInteractionEnabled = false
        let loadingView = UIView(frame: .zero)
        loadingView.layer.cornerRadius = 10
        loadingView.tag = -10001
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.backgroundColor = UIColor(white: 0, alpha: 0.5)

        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(indicator)
        indicator.startAnimating()

        let width = maskScreen ? view.bounds.width : 60
        let height = maskScreen ? view.bounds.height : 60
        
        view.addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.widthAnchor.constraint(equalToConstant: width),
            loadingView.heightAnchor.constraint(equalToConstant: height),
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            indicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
        ])
    }
    
    /// IITool: hide standard loading view.
    final func hideLoading() {
        view.isUserInteractionEnabled = true

        if let loadingView = view.subviews.first(where: { $0.tag == -10001 }) {
            loadingView.removeFromSuperview()
        }
    }
}

#endif
