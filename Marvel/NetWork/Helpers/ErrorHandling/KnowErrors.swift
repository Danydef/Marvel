//
//  KnowErrors.swift
//  RickAndMorty
//
//  Created by Daniel Personal on 3/12/22.
//

import Foundation

struct HTTPClientError: Error {
    
    var type: ErrorType = .unknownError
    
    enum ErrorType: Int {
        case internalServerError = 500
        case conflictError = 409
        case invalidCredentials = 401
        case unknownError
    }
    
    init(code: Int) {
        type = .unknownError
        switch code {
        case -1:
            type = .invalidCredentials
        case 401..<414:
             type = .invalidCredentials
        case 409:
             type = .conflictError
        default:
             type = .unknownError
        }
    }
}

struct BackendError: Error {
    var type: ErrorType = .limitGreater
    var code: String = ""
    var serverMessage = ""
    var errorText = ""
    
    enum ErrorType: String {
        case limitGreater = "409"
        case invalidCredentials = "InvalidCredentials"
        case unknownError = ""
    }
    
    init(code: String, serverMessage: String) {
        type = ErrorType(rawValue: code) ?? .unknownError
        errorText = BackendError.getErrorTextFrom(type)
        self.serverMessage = serverMessage
    }
    
    static func getErrorTextFrom(_ type: ErrorType) -> String {
        switch type {
        case .limitGreater:
            return NSLocalizedString("login_error_blocked_user", comment: "")
        case .invalidCredentials:
            return NSLocalizedString("invalid_credentials_error", comment: "")
        default:
            return NSLocalizedString("error_generic", comment: "")
        }
    }
}

