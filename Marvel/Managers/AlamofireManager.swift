//
//  AlamofireManager.swift
//  RickAndMorty
//
//  Created by Daniel Jimenez on 29/11/22.
//

import Foundation
import Alamofire

struct CustomGetEncoding: ParameterEncoding {

    var params: [String: Any]?
    var arrayParams: [[String: Any]]?
    var encrypted: Bool

    init(encrypted: Bool) {
        self.encrypted = encrypted
    }

    init(params: [String: Any]?,
         encrypted: Bool) {

        self.params = params
        self.encrypted = encrypted
    }

    init(arrayParams: [[String: Any]]?,
         encrypted: Bool) {

        self.arrayParams = arrayParams
        self.encrypted = encrypted
    }

    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {

        var request = try URLEncoding().encode(urlRequest, with: parameters)

        if let params = self.params, let httpBody = try? JSONSerialization.data(withJSONObject: params) {

            request.httpBody = self.getHTTPBody(data: httpBody, encrypted: encrypted)
        }

        if let arrayParams = self.arrayParams, let httpBody = try? JSONSerialization.data(withJSONObject: arrayParams) {

            request.httpBody = self.getHTTPBody(data: httpBody, encrypted: encrypted)
        }

        request.url = URL(string: request.url!.absoluteString.replacingOccurrences(of: "%5B%5D=", with: "="))
        return request
    }

    func getHTTPBody(data: Data, encrypted: Bool) -> Data? {
        if encrypted {
            // Encriptar
            Utils.print("PARAMETERS ENCRYPTED: ")
            Utils.print(String(data: Data(), encoding: .utf8) ?? "")
            return Data()
        } else {
            return data
        }
    }
}

class AlamofireManager: RequestManager {
    // swiftlint:disable multiple_closures_with_trailing_closure
    
    private var manager: Alamofire.SessionManager!
    weak var delegate: BaseProviderDelegate?
    var task: URLSessionTask?
    
    func getEncodingType(dto: ProviderDTO, encrypted: Bool) -> ParameterEncoding {

        switch dto.method {
        case .get, .delete:

            return CustomGetEncoding(encrypted: encrypted)

        case .post, .put, .patch:

            if encrypted && dto.params != nil {

                return CustomGetEncoding(params: dto.params, encrypted: encrypted)
            }

            if !encrypted && dto.params != nil {

                return JSONEncoding.default
            }

            if dto.arrayParams != nil {
                return CustomGetEncoding(arrayParams: dto.arrayParams, encrypted: encrypted)
            }

        default:
            return JSONEncoding.default
        }

        return JSONEncoding.default
    }
        
    private func createManager(timeout: TimeInterval) -> Alamofire.SessionManager {

        // Creamos el manager personalizado.
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeout
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData

        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "app-pre..": .pinCertificates(
                certificates: ServerTrustPolicy.certificates(),
                validateCertificateChain: true,
                validateHost: true
            ),
            "app-pro..": .pinCertificates(
                certificates: ServerTrustPolicy.certificates(),
                validateCertificateChain: true,
                validateHost: true
            )
        ]

        let manager = Alamofire.SessionManager(
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )

        return manager
    }
    
    internal func request(dto: ProviderDTO,
                          timeout: TimeInterval = 15,
                          printLog: Bool = true,
                          encrypted: Bool = false,
                          additionalHeader: [ String: String] = [:],
                          success: @escaping(Data?) -> Void,
                          failure: @escaping(CustomErrorModel) -> Void) -> URLSessionTask? {

        if !NetworkManager.shared.checkNetwork() {
            self.delegate?.networkNotReachable()
            return nil
        }
        
        let endpoint = URLEndpoint.buildURL(urlContext: dto.urlContext, endpoint: dto.endpoint)

        var headers: [String: String] = [Constants.contentTypeHeader: Constants.jsonMIMEtype]
        let parameters: [String: Any]? = dto.params

        if !additionalHeader.isEmpty {
            for item in additionalHeader {
                headers[item.key] = item.value
            }
        }

        if self.manager == nil ||
            self.manager.session.configuration.timeoutIntervalForRequest != timeout {

            self.manager = self.createManager(timeout: timeout)
        }
        let request = self.manager.request(endpoint,
                                           method: Alamofire.HTTPMethod(rawValue: dto.method.rawValue)!,
                                           parameters: parameters,
                                           encoding: self.getEncodingType(dto: dto, encrypted: encrypted),
                                           headers: headers)
        
        BaseProviderUtils.printRequest(dto: dto, endpoint: endpoint, headers: headers, printData: printLog)

        self.delegate?.requestDone()
        
        request.responseJSON { response in
            if let httpResponse = response.response {
                self.delegate?.responseGet()
                
                BaseProviderUtils.manageResponse(endpoint: endpoint, response: httpResponse, data: response.data, delegate: self.delegate, encrypted: encrypted, printLog: printLog, success: { (data) in
                    success(data)
                }) { (error) in
                    self.delegate?.responseGet()
                    failure(error)
                }
            } else {
                self.delegate?.responseGet()
                failure(CustomErrorModel(httpClientError: .unknownError, backendError: .unknownError))
            }
        }

        return request.task
    }
}
