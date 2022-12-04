//
//  NavigationBarManager.swift
//  RickAndMorty
//
//  Created by Daniel Personal on 29/11/22.
//

import UIKit

protocol NavigationBarManagerDelegate: AnyObject {
    func navigationBarLeftButtonItemPressed(buttonItem: NavigationBarButtonItem)
    func navigationBarRightButtonItemPressed(buttonItem: NavigationBarButtonItem)
}

class NavigationBarManager {
    
    weak var viewController: UIViewController?
    weak var delegate: NavigationBarManagerDelegate?
    
    var navigationController: UINavigationController? {
        return self.viewController?.navigationController
    }
    var navigationItem: UINavigationItem? {
        return self.viewController?.navigationItem
    }
    var title: String? {
        get {
            return self.viewController?.title
        }
        set {
            self.viewController?.title = newValue
        }
    }
    
    private var arrayRightButtons: [NavigationBarButtonItem]?
    private var arrayLeftButtons: [NavigationBarButtonItem]?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        self.delegate = viewController as? NavigationBarManagerDelegate
    }
    
    func setNavigationBar(backgroundImage: UIImage? = nil, backgroundColor: UIColor? = nil) {
        let navBar = self.navigationController?.navigationBar
        navBar?.setBackgroundImage(backgroundImage, for: UIBarMetrics.default)
        navBar?.shadowImage = UIImage()
        navBar?.titleTextAttributes = [NSAttributedString.Key.font: CustomFont(fontType: .system, size: .extraLarge, style: .regular).uiFont, NSAttributedString.Key.foregroundColor: CustomColor.textLight.color]

        navBar?.barTintColor = backgroundColor
        navBar?.isTranslucent = false
    }
    
    func setNavigationBarTitleView(view: UIView?) {
        let navBar = self.navigationController?.navigationBar
        navBar?.topItem?.titleView = view
    }
    
    func setNavigationBarLeftButtonItems(arrayLeftButtons: [NavigationBarButtonItem]) {
        
        self.arrayLeftButtons = arrayLeftButtons
        
        self.navigationItem?.leftBarButtonItems = NavigationBarButtonItem.transformNavigationItemsToUI(
            arrayNavigationBarButtonItems: arrayLeftButtons,
            handler: self.navigationBarLeftButtonItemPressed(_:))
    }
    
    func setNavigationBarRightButtonItems(arrayRightButtons: [NavigationBarButtonItem]) {
        
        self.arrayRightButtons = arrayRightButtons
        self.navigationItem?.rightBarButtonItems = NavigationBarButtonItem.transformNavigationItemsToUI(
            arrayNavigationBarButtonItems: arrayRightButtons,
            handler: self.navigationBarRightButtonItemPressed(_:))
    }
    
    func setNavigationBarBackButton(backButton: NavigationBarButtonItem) {
        let navBar = self.navigationController?.navigationBar
        navBar?.backIndicatorImage = backButton.image
        navBar?.backIndicatorTransitionMaskImage = backButton.image
        self.navigationItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setTransparent(isTransparent: Bool) {
        
        if isTransparent {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.isTranslucent = true
        }
    }
    
    func configureNavigationBar(model: NavigationBarModel) {
        
        if let backButton = model.backButton { self.setNavigationBarBackButton(backButton: backButton) }
        if let arrayLeftButtons = model.arrayLeftButtons { self.setNavigationBarLeftButtonItems(arrayLeftButtons: arrayLeftButtons) }
        if let arrayRightButtons = model.arrayRightButtons { self.setNavigationBarRightButtonItems(arrayRightButtons: arrayRightButtons) }
        if let titleView = model.titleView { self.setNavigationBarTitleView(view: titleView) }
        self.setNavigationBar(backgroundImage: model.backgroundImage ?? UIImage(named: "default"), backgroundColor: model.backGroundColor)
        if model.isTransparent { self.setTransparent(isTransparent: model.isTransparent) }
        if let title = model.title { self.title = title }

    }
    
    func navigationBarLeftButtonItemPressed(_ buttonItem: NavigationBarButtonItem) {
        self.delegate?.navigationBarLeftButtonItemPressed(buttonItem: buttonItem)
    }
    
    func navigationBarRightButtonItemPressed(_ buttonItem: NavigationBarButtonItem) {
        self.delegate?.navigationBarRightButtonItemPressed(buttonItem: buttonItem)
    }
}
