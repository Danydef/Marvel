//
//  BaseProvider.swift
//  RickAndMorty
//
//  Created by Daniel Personal on 29/11/22.
//

import UIKit

enum AcceptResponseType {
    case json
    case pdf
    case xml
    case text
}

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

struct ProviderDTO {
    var params: [String: Any]?
    var arrayParams: [[String: Any]]?
    var method: HTTPMethod
    var urlContext: URLEndpoint.BaseURLContext
    var endpoint: String
    var acceptType = AcceptResponseType.json

    init(params: [String: Any]?,
         method: HTTPMethod,
         urlContext: URLEndpoint.BaseURLContext,
         endpoint: String,
         acceptType: AcceptResponseType = .json) {

        self.params = params
        self.method = method
        self.urlContext = urlContext
        self.endpoint = endpoint
        self.acceptType = acceptType
    }

    init(arrayParams: [[String: Any]]?,
         method: HTTPMethod,
         endpoint: String,
         urlContext: URLEndpoint.BaseURLContext,
         acceptType: AcceptResponseType = .json) {

        self.arrayParams = arrayParams
        self.method = method
        self.urlContext = urlContext
        self.endpoint = endpoint
        self.acceptType = acceptType
    }
}

class BaseProvider: NSObject {
    // swiftlint:disable multiple_closures_with_trailing_closure

    var task: URLSessionTask?
    
    weak var delegate: BaseProviderDelegate?
    
    var manager: RequestManager?
    
    internal func request(dto: ProviderDTO, timeout: TimeInterval = 15, printLog: Bool = true, encrypted: Bool = false, additionalHeader: [ String: String] = [:], success: @escaping(Data?) -> Void, failure: @escaping(CustomErrorModel) -> Void) -> URLSessionTask? {
        if !NetworkManager.shared.checkNetwork() {
            self.delegate?.networkNotReachable()
            return nil
        }
        if var manager = self.manager {
            manager.delegate = self.delegate
            let request = manager.request(dto: dto, timeout: timeout, printLog: printLog, encrypted: encrypted, additionalHeader: additionalHeader, success: { (data) in
                DispatchQueue.main.async {
                   success(data)
                }
            }) { (error) in
                DispatchQueue.main.async {
                    failure(error)
                }
            }
            self.task = request
            return request
        } else {
            let error = CustomErrorModel(httpClientError: .internalServerError, backendError: .unknownError)
            failure(error)
            return nil
        }
    }
}

protocol RequestManager {
    // swiftlint:disable function_parameter_count
    
    var delegate: BaseProviderDelegate? {get set}
    
    func request(dto: ProviderDTO, timeout: TimeInterval, printLog: Bool, encrypted: Bool, additionalHeader: [ String: String],
                 success: @escaping(Data?) -> Void,
                 failure: @escaping(CustomErrorModel) -> Void) -> URLSessionTask?
}
