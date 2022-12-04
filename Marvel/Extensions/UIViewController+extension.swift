//
//  UIViewController+extension.swift
//  RickAndMorty
//
//  Created by Daniel Personal on 3/12/22.
//

import UIKit

extension UIViewController {
    public class func loadFromNib<T: UIViewController>(bundle: Bundle? = nil) -> T {
        T(nibName: String(describing: self), bundle: bundle)
    }
    
    static func topViewController(withRoot root: UIViewController?) -> UIViewController? {
        if let newRoot = (root as? UITabBarController)?.selectedViewController {
            return topViewController(withRoot: newRoot)
        }
        
        if let newRoot = (root as? UINavigationController)?.visibleViewController {
            return topViewController(withRoot: newRoot)
        }
        
        if let newRoot = root?.presentedViewController {
            return topViewController(withRoot: newRoot)
        }
        
        return root
    }
}
