//
//  BaseProviderParamsDTO.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import Foundation

protocol BaseProviderParamsDTO: Codable {
    
}

extension BaseProviderParamsDTO {
    
    func encode() -> [String: Any] {
        
        guard let jsonData = try? JSONEncoder().encode(self),
            let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
            else { return [String: Any]() }

        return json
    }
    
}

extension Array where Element: BaseProviderParamsDTO {
    
    func encode() -> [[String: Any]] {
        
        guard let jsonData = try? JSONEncoder().encode(self),
            let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]]
            else { return [[String: Any]]() }

        return json
    }
    
}
