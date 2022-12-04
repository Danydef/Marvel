//
//  BasePresenter.swift
//  RickAndMorty
//
//  Created by Daniel Jimenez on 29/11/22.
//

import UIKit

class BasePresenter {
    
    weak var baseView: BaseViewProtocol?
    var baseRouter: BaseRouterProtocol?
    var baseInteractor: BaseInteractorInputProtocol?
    
    required init() {}
        
    static func logout() {
        BaseInteractor.removeDataForLogout()
        BaseRouter.logout()
    }
    
    func showAlert(error: CustomErrorModel) {
        baseView?.showAlertWith(title: NSLocalizedString("Error", comment: ""), message: error.presentationMessage, actions: nil)
    }
    
    func showNetworkErrorAlert() {
        baseView?.showAlertWith(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("Network_error", comment: ""), actions: nil)
    }
    
    func invalidCredentialsError() {
        
        let action = CustomAlertAction(title: NSLocalizedString("Aceptar", comment: "")) { _ in
            BasePresenter.logout()
        }
        
        baseView?.showAlertWith(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("Logout", comment: ""), actions: [action])
    }
}

// MARK: BasePresenterProtocol
extension BasePresenter {
    
    func showError(error: CustomErrorModel) {
        self.showAlert(error: error)
    }
}

// MARK: BaseInteractorOutputProtocol
extension BasePresenter {
    
    func genericErrorHappened(error: CustomErrorModel) {
         showError(error: error)
     }
    
    func asyncTaskStarted() {
        baseView?.showLoading(fullScreen: true)
    }
    
    func asyncTaskFinished() {
        baseView?.hideLoading()
    }
    
    func networkErrorHappened() {
        showNetworkErrorAlert()
    }
}

// MARK: - BaseRouterDelegate
extension BasePresenter: BaseRouterDelegate {

    func navigationDone() {
        // Do something every time a navigation is done
        // If you cannot, for example, an invalid credentials error is displayed
        //            BasePresenter.invalidCredentialsError()
    }
}
