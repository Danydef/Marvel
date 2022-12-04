//
//  DataAssembly.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import Foundation

struct DataAssembly {
    
    // MARK: Characters Provider
    static func characterProvider(interactor: BaseInteractor) -> CharacterProviderProtocol {
        let provider = CharacterProvider()
        provider.delegate = interactor
        provider.manager = NativeManager()
        
        return provider
    }
}
