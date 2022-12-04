//
//  BaseProtocols.swift
//  RickAndMorty
//
//  Created by Daniel Jimenez on 29/11/22.
//

import Foundation

// Protocol used to the Presenter can communicate with View
protocol BaseViewProtocol: AnyObject {
    func showAlertWith(title: String?, message: String?, actions: [CustomAlertAction]?)
    func showLoading(fullScreen: Bool)
    func hideLoading()
}

// Protocol used to the View can communicate with Presenter
protocol BasePresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear(isFirstPresentation: Bool)
    func viewDidAppear(isFirstPresentation: Bool)
}

extension BasePresenterProtocol {
    func viewDidLoad() {}
    func viewWillAppear(isFirstPresentation: Bool) {}
    func viewDidAppear(isFirstPresentation: Bool) {}
}

// Protocol used to the Presenter can communicate with Interactor
protocol BaseInteractorInputProtocol: AnyObject {
}

// Protocol used to the Interactor can communicate with Presenter
protocol BaseInteractorOutputProtocol: AnyObject {
    func genericErrorHappened(error: CustomErrorModel) // Method used to notify Presenter that error has happened
    func asyncTaskStarted()
    func asyncTaskFinished()
    func networkErrorHappened()
}

extension BaseInteractorOutputProtocol {
    func genericErrorHappened(error: CustomErrorModel) {}
    func asyncTaskStarted() {}
    func asyncTaskFinished() {}
}

// Protocol used to the Presenter can communicate with Router
protocol BaseRouterProtocol: AnyObject {
    
}

// Delegate used to report that a navigation has been done. It will usually be implemented by the Presenter
protocol BaseRouterDelegate: AnyObject {
    func navigationDone()
}

// Delegate used to report actions with web services. It will usually be implemented by the Interactor
protocol BaseProviderDelegate: AnyObject {
    func requestDone()
    func responseGet()
    func networkNotReachable()
}
