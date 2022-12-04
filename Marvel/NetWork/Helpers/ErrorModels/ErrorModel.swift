//
//  ErrorModel.swift
//  RickAndMorty
//
//  Created by Daniel Personal on 3/12/22.
//

import Foundation

class ErrorModel: BaseBusinessModel {
    
    var code: String?
    var status: String?
    var message: String?
    
    required init(serverModel: BaseServerModel?) {
        super.init(serverModel: serverModel)
        
        guard let serverModel = serverModel as? ErrorServerModel else {
            return
        }
        
        code = serverModel.code
        status = serverModel.status
        message = serverModel.message
    }
}
