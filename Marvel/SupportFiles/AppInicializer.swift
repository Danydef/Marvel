//
//  AppInicializer.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import Foundation

class AppInitializer: NSObject {
    func installRootViewController() {
        BaseRouter.setRoot(navigationController: ListAssembly.listNavigationView())
    }
}
