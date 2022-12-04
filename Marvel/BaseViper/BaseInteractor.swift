//
//  BaseInteractor.swift
//  RickAndMorty
//
//  Created by Daniel Jimenez on 29/11/22.
//

import UIKit

class BaseInteractor {
    weak var basePresenter: BaseInteractorOutputProtocol?
    
    required init() {}
}

// MARK: Logout
extension BaseInteractor {
    static func removeDataForLogout() {
        // Call logout service
        // Remove session data (session singleton)
        // Remove persisted data (UserDefault, KeyChain...)
    }
}

// MARK: Parser
extension BaseInteractor {
    
    static func parseToBusinessModel<Model: BaseBusinessModel, ServerModel: BaseServerModel>(parserModel: Model.Type, serverModel: ServerModel?) -> Model? {
        
        guard let serverModel = serverModel else {
            return nil
        }
        
        return Model(serverModel: serverModel)
    }
    
    static func parseArrayToBusinessModel<Model: BaseBusinessModel, ServerModel: BaseServerModel>(parserModel: [Model].Type, arrayServerModels: [ServerModel]?) -> [Model]? {
        
        guard let arrayServerModels = arrayServerModels else {
            return nil
        }
        
        return arrayServerModels.map { serverModel in
            Model(serverModel: serverModel)
        }
    }
}

// MARK: Web Service
extension BaseInteractor: BaseProviderDelegate {
    
    func requestDone() {
        self.basePresenter?.asyncTaskStarted()
    }
    
    func responseGet() {
        self.basePresenter?.asyncTaskFinished()
    }
    
    func networkNotReachable() {
        self.basePresenter?.networkErrorHappened()
    }
}
