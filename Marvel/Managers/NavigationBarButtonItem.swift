//
//  NavigationBarButtonItem.swift
//  RickAndMorty
//
//  Created by Daniel Personal on 29/11/22.
//

import UIKit

struct NavigationBarModel {
    
    var title: String?
    var backButton: NavigationBarButtonItem?
    var arrayLeftButtons: [NavigationBarButtonItem]?
    var arrayRightButtons: [NavigationBarButtonItem]?
    var titleView: UIView?
    var backgroundImage: UIImage?
    var backGroundColor: UIColor?
    var isTransparent = false
    
    init(title: String? = nil,
         backButton: NavigationBarButtonItem? = nil,
         arrayLeftButtons: [NavigationBarButtonItem]? = nil,
         arrayRightButtons: [NavigationBarButtonItem]? = nil,
         titleView: UIView? = nil,
         backgroundImage: UIImage? = nil,
         backGroundColor: UIColor? = nil,
         isTransparent: Bool = false) {
        
        self.title = title
        self.backButton = backButton
        self.arrayLeftButtons = arrayLeftButtons
        self.arrayRightButtons = arrayRightButtons
        self.titleView = titleView
        self.backgroundImage = backgroundImage
        self.backGroundColor = backGroundColor
        self.isTransparent = isTransparent
    }
}

class NavigationBarButtonItem {
    
    private var icon: UIImage
    var isEnabled = true
    var type: NavigationButtonType
    
    var uiBarButtonItem: UIBarButtonItem?
    var handler: ((NavigationBarButtonItem) -> Void)?
    
    enum NavigationButtonType {
        case logo
        case back
    }
    
    init(type: NavigationButtonType, icon: UIImage, isEnabled: Bool = true) {
        self.type = type
        self.icon = icon
        self.isEnabled = isEnabled
    }
    
    var image: UIImage? {
        icon.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
    }
    
    @objc func navigationBarButtonItemPressed(sender: UIBarButtonItem) {
        handler?(self)
    }
    
    func initUIButtonItem() {
        
        uiBarButtonItem = UIBarButtonItem(
            image: self.image,
            style: .plain,
            target: self,
            action: #selector(navigationBarButtonItemPressed(sender:)))
        
        uiBarButtonItem?.isEnabled = isEnabled
    }
    
    static func transformNavigationItemsToUI(arrayNavigationBarButtonItems: [NavigationBarButtonItem],
                                             handler: @escaping (NavigationBarButtonItem) -> Void) -> [UIBarButtonItem] {
        
        arrayNavigationBarButtonItems.map { rightButtonItem -> UIBarButtonItem? in
            
            rightButtonItem.handler = handler
            rightButtonItem.initUIButtonItem()
            
            return rightButtonItem.uiBarButtonItem
            
        }.compactMap({ $0 })
    }
    
}

extension NavigationBarButtonItem {
    static var logo = NavigationBarButtonItem(type: .logo, icon: #imageLiteral(resourceName: "marvelTop"))
    static var backArrow = NavigationBarButtonItem(type: .back, icon: #imageLiteral(resourceName: "ico_back"), isEnabled: true)
}
