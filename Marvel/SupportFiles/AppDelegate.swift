//
//  AppDelegate.swift
//  RickAndMorty
//
//  Created by Daniel Jimenez on 29/11/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appInitializer = AppInitializer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        if window != nil {
            self.appInitializer.installRootViewController()
        }
        
        return true
    }
}
