//
//  NativeManager.swift
//  RickAndMorty
//
//  Created by Daniel Personal on 29/11/22.
//

import Foundation

class NativeManager: RequestManager {
    // swiftlint:disable function_parameter_count
    // swiftlint:disable multiple_closures_with_trailing_closure
    
    weak var delegate: BaseProviderDelegate?
    
    var requestHttpHeaders = RestEntity()
    var urlQueryParameters = RestEntity()
    var httpBodyParameters = RestEntity()
    
    var httpBody: Data?
    
    func request(dto: ProviderDTO, timeout: TimeInterval, printLog: Bool, encrypted: Bool, additionalHeader: [String: String], success: @escaping (Data?) -> Void, failure: @escaping (CustomErrorModel) -> Void) -> URLSessionTask? {
        
        let endpoint = URLEndpoint.buildURL(urlContext: dto.urlContext, endpoint: dto.endpoint)
        
        for currentHeader in additionalHeader {
            requestHttpHeaders.add(value: currentHeader.value, forKey: currentHeader.key)
        }
        
        if let params = dto.params {
            for param in params {
                var value = param.value as? String
                if value == nil {
                    value = "\(param.value)"
                }
                if let value = value {
                    if dto.method == .get {
                        urlQueryParameters.add(value: value, forKey: param.key)
                    } else {
                        httpBodyParameters.add(value: value, forKey: param.key)
                    }
                }
            }
        }
        
        let targetURL = addURLQueryParameters(toURL: URL(string: endpoint)!)
        let httpBody = getHttpBody()
        guard let request = prepareRequest(withURL: targetURL, httpBody: httpBody, httpMethod: dto.method) else {
            failure(CustomErrorModel(httpClientError: .unknownError, backendError: .unknownError))
            return nil
        }
        
        self.delegate?.requestDone()
        
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                BaseProviderUtils.manageResponse(endpoint: endpoint, response: httpResponse, data: data, delegate: self.delegate, encrypted: encrypted, printLog: printLog, success: { (data) in
                    self.delegate?.responseGet()
                    success(data)
                }) { (error) in
                    self.delegate?.responseGet()
                    failure(error)
                }
            } else {
                self.delegate?.responseGet()
            }
        }
        task.resume()
        return task
    }
    
    // MARK: - Private Methods
    
    private func addURLQueryParameters(toURL url: URL) -> URL {
        if urlQueryParameters.totalItems() > 0 {
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return url }
            var queryItems = [URLQueryItem]()
            
            for (key, value) in urlQueryParameters.allValues() {
                let item = URLQueryItem(name: key, value: value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
                
                queryItems.append(item)
                urlComponents.queryItems?.append(item)
            }
            for query in queryItems {
                urlComponents.queryItems?.append(query)
            }
            
            guard let updatedURL = urlComponents.url else { return url }
            return updatedURL
        }
        
        return url
    }
    
    private func getHttpBody() -> Data? {
        guard let contentType = requestHttpHeaders.value(forKey: "Content-Type") else { return nil }
        
        if contentType.contains("application/json") {
            return try? JSONSerialization.data(withJSONObject: httpBodyParameters.allValues(), options: [.prettyPrinted, .sortedKeys])
        } else if contentType.contains("application/x-www-form-urlencoded") {
            let bodyString = httpBodyParameters.allValues().map { "\($0)=\(String(describing: $1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!))" }.joined(separator: "&")
            return bodyString.data(using: .utf8)
        } else {
            return httpBody
        }
    }
    
    private func prepareRequest(withURL url: URL?, httpBody: Data?, httpMethod: HTTPMethod) -> URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        for (header, value) in requestHttpHeaders.allValues() {
            request.setValue(value, forHTTPHeaderField: header)
        }
        
        request.httpBody = httpBody
        return request
    }
    
    struct RestEntity {
        private var values: [String: String] = [:]
        
        mutating func add(value: String, forKey key: String) {
            values[key] = value
        }
        
        func value(forKey key: String) -> String? {
            return values[key]
        }
        
        func allValues() -> [String: String] {
            return values
        }
        
        func totalItems() -> Int {
            return values.count
        }
    }
}
