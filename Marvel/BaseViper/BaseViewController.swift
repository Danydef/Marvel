//
//  BaseViewController.swift
//  RickAndMorty
//
//  Created by Daniel Jimenez on 29/11/22.
//

import UIKit
import JGProgressHUD

class BaseViewController: UIViewController, NavigationBarManagerDelegate {
    
    internal var basePresenter: BasePresenterProtocol?
    var navigationBarManager: NavigationBarManager?
    
    var isFirstPresentation: Bool = true
    
    let hud = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeUI()
        navigationBarManager = NavigationBarManager(viewController: self)
        navigationBarManager?.delegate = self
        navigationBarManager?.configureNavigationBar(model: NavigationBarModel(backButton: .backArrow, backGroundColor: CustomColor.viewPrimary.color))
        
        basePresenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        basePresenter?.viewWillAppear(isFirstPresentation: isFirstPresentation)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isFirstPresentation = false
        
        basePresenter?.viewDidAppear(isFirstPresentation: isFirstPresentation)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func initializeUI() {}
    
     // MARK: NavigationBar
     func navigationBarLeftButtonItemPressed(buttonItem: NavigationBarButtonItem) {}
     
     func navigationBarRightButtonItemPressed(buttonItem: NavigationBarButtonItem) {}
    
     // MARK: Loader
     func showLoading(fullScreen: Bool) {
        hud.textLabel.text = "Loading"
        hud.show(in: view)
     }
     
     func hideLoading() {
        hud.dismiss()
     }

}

// MARK: BaseViewControllerProtocol
extension BaseViewController {
    
    func showAlertWith(title: String?, message: String?, actions: [CustomAlertAction]?) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let actions = actions {
            for action in actions {
                alert.addAction(UIAlertAction(title: action.title, style: .default, handler: { _ in
                    action.handler?(action)
                }))
            }
        } else {
            alert.addAction(UIAlertAction(title: NSLocalizedString("logout_inactivity_alert_accept_button", comment: ""), style: .default, handler: nil))
        }
        
        present(alert, animated: true, completion: nil)
    }
}
