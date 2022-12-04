//
//  BaseProviderUtils.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import Foundation

class BaseProviderUtils {
    // swiftlint:disable function_parameter_count
    
    static func printRequest(dto: ProviderDTO, endpoint: String, headers: [String: Any], printData: Bool) {
        
        let data = dto.arrayParams != nil
            ? try? JSONSerialization.data(withJSONObject: (dto.arrayParams ?? [:]), options: .prettyPrinted)
            : try? JSONSerialization.data(withJSONObject: (dto.params ?? []), options: .prettyPrinted)

        Utils.print("************* REQUEST **************")
        Utils.print("Request Date: \(Date().format(format: "dd/MM/yyyy-HH:mm:ss"))")
        Utils.print("URL: \(endpoint)")
        if printData {
            Utils.print("PARAMETERS: ")
            Utils.print(String(data: data ?? Data(), encoding: .utf8) ?? "")
            Utils.print("HEADERS: \(headers)")
        }
        Utils.print("************* END *************")
    }
    
    static func printSuccessResponse(endpoint: String, data: Data, decryptedBytes: Data?, printData: Bool) {
        Utils.print("*************************** RESPONSE ***************************")
        Utils.print("Response Date: \(Date().format(format: "dd/MM/yyyy-HH:mm:ss"))")
        Utils.print("URL: \(endpoint)")
        if printData {
            Utils.print(String(data: data, encoding: .utf8) ?? "")
            Utils.print(String(data: decryptedBytes ?? Data(), encoding: .utf8) ?? "")
        }

        Utils.print("********* END ***********")
    }
    
    static func printFailureResponse(endpoint: String, data: Data?, decryptedBytes: Data?, printData: Bool) {

        Utils.print("*************************** RESPONSE ***************************")
        Utils.print("Response Date: \(Date().format(format: "dd/MM/yyyy-HH:mm:ss"))")
        Utils.print("URL: \(endpoint)")

        if printData {
            Utils.print(String(data: data ?? Data(), encoding: .utf8) ?? "")
            Utils.print(String(data: decryptedBytes ?? Data(), encoding: .utf8) ?? "")
        }
     }
    
    static func manageResponseData(data: Data?, encrypted: Bool, printLog: Bool) -> Data? {

        guard let data = data else { return nil }

        var decryptedBytes: Data?

        if encrypted {
            // Desencriptar

        } else {
            decryptedBytes = data
        }

        return decryptedBytes
    }
    
    static func apiResponseError(responseData: Data?, responseStatusCode: Int?, failure: @escaping (CustomErrorModel) -> Void) {

        let errorModel = CustomErrorModel(data: responseData, httpCode: responseStatusCode)

        Utils.print(errorModel)
        Utils.print("*************************** END ***************************")

        failure(errorModel)
    }
    
    static func parseToServerModel<Model: BaseServerModel>(parserModel: Model.Type, data: Data?) -> Model? {
        
        guard let payload = data, let model = try? JSONDecoder().decode(parserModel, from: payload) else {
            return nil
        }
        return model
    }
    
    static func parseArrayToServerModel<Model: BaseServerModel>(parserModel: [Model].Type, data: Data?) -> [Model]? {
        
        guard let payload = data, let arrayModels = try? JSONDecoder().decode(parserModel, from: payload) else {
            return nil
        }
        return arrayModels
    }
    
    static func manageResponse(endpoint: String, response: HTTPURLResponse, data: Data?, delegate: BaseProviderDelegate?, encrypted: Bool, printLog: Bool, success: (Data?) -> Void, failure: @escaping (CustomErrorModel) -> Void) {
        DispatchQueue.main.async {
            delegate?.responseGet()
        }
        
        if (200..<300).contains(response.statusCode) {

            // Gestión del caso correcto

            // Se obtiene la respuesta.
            guard let data = data else {
                // Si la respuesta no tiene datos, se devuelve un error.
                self.apiResponseError(responseData: nil,
                                      responseStatusCode: response.statusCode,
                                      failure: failure)
                return
            }

            let decryptedBytes = BaseProviderUtils.manageResponseData(data: data, encrypted: encrypted, printLog: printLog)

            printSuccessResponse(endpoint: endpoint, data: data, decryptedBytes: decryptedBytes, printData: printLog)

            success(decryptedBytes)
        } else {
            let decryptedBytes = BaseProviderUtils.manageResponseData(data: data, encrypted: encrypted, printLog: printLog)

            printFailureResponse(endpoint: endpoint, data: data, decryptedBytes: decryptedBytes, printData: printLog)

            apiResponseError(responseData: decryptedBytes,
                                  responseStatusCode: response.statusCode,
                                  failure: failure)
            return
        }
    }
    
    static func getData(name: String, withExtension: String = "json", forClass: AnyClass) -> Data? {
        let bundle = Bundle(for: forClass)
        let fileUrl = bundle.url(forResource: name, withExtension: withExtension)
        let data = try? Data(contentsOf: fileUrl!)
        return data
    }
}
