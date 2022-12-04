//
//  BaseRouter.swift
//  RickAndMorty
//
//  Created by Daniel Jimenez on 29/11/22.
//

import UIKit

class BaseRouter {
    
    // Declared weak for the ARC to destroy them.
    weak var baseView: UIViewController?
    weak var delegate: BaseRouterDelegate?
    
    required init() {}
    
    static func setRoot(navigationController: UIViewController) {
        guard let window = UIApplication.shared.delegate?.window else { return }
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    static func logout(viewController: UIViewController? = nil) {
        if let navigationController = (UIApplication.shared.windows.first?.rootViewController as? UINavigationController) {
            navigationController.popToRootViewController(animated: true)
        } else {
            if let viewController = viewController {
                viewController.dismiss(animated: true, completion: nil)
            }
            if let navigationController = (UIApplication.shared.windows.first?.rootViewController as? UINavigationController) {
                navigationController.popToRootViewController(animated: true)
            }
        }
    }
    
    func rootViewController(_ viewControllerToPresent: UIViewController, animated flag: Bool) {
        delegate?.navigationDone()
        baseView?.navigationController?.setViewControllers([viewControllerToPresent], animated: flag)
    }
    
    func pushViewController(_ viewControllerToPresent: UIViewController, animated flag: Bool) {
        delegate?.navigationDone()
        baseView?.navigationController?.pushViewController(viewControllerToPresent, animated: flag)
    }
    
    func popViewController(animated: Bool) {
        delegate?.navigationDone()
        baseView?.navigationController?.popViewController(animated: animated)
    }
    
    func popToViewController(toViewController: UIViewController, animated: Bool) {
        delegate?.navigationDone()
        baseView?.navigationController?.popToViewController(toViewController, animated: animated)
    }
    
    func popToRootViewController() {
        delegate?.navigationDone()
        baseView?.navigationController?.popToRootViewController(animated: true)
    }
    
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Swift.Void)? = nil) {
        delegate?.navigationDone()
        baseView?.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    func dismiss(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Swift.Void)? = nil) {
        delegate?.navigationDone()
        baseView?.dismiss(animated: flag, completion: completion)
    }
}
