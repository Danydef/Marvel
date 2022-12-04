//
//  URLEndpoint.swift
//  Marvel
//
//  Created by Daniel Personal on 29/11/22.
//

import Foundation

struct URLEndpoint {
    public enum BaseURLContext {
        case backend
    }
    
    static var characters = "characters"
}

extension URLEndpoint {
    static func buildURL(urlContext: BaseURLContext, endpoint: String) -> String {
        switch urlContext {
        case .backend:
            return MarvelApiConstants.serverURL + MarvelApiConstants.version + "/public" + "/\(endpoint)" + "?apikey=\(MarvelApiConstants.apiKey)&ts=\(MarvelApiConstants.timeStamp)&hash=\(MarvelApiConstants.hash)"
        }
    }
}
