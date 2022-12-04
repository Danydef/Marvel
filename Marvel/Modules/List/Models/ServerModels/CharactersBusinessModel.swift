//
//  CharactersBusinessModel.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import Foundation

final class CharactersBusinessModel: BaseBusinessModel {
    var characters: [CharacterBusinessModel]?
    
    required init(serverModel: BaseServerModel?) {
        super.init(serverModel: serverModel)

        guard let serverModel = serverModel as? CharactersServerModel else {
            return
        }
        
        if let charactersServerModel = serverModel.data?.results {
            characters = charactersServerModel.map { CharacterBusinessModel(serverModel: $0) }
        }
    }
}

final class CharacterBusinessModel: BaseBusinessModel {
    var id: Int?
    var name: String?
    var resultDescription: String?
    var smallImageUrl: String?
    var largeImageUrl: String?
    var comics: Comics?
    var series: Comics?

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case thumbnail, comics, series
    }
    
    required init(serverModel: BaseServerModel?) {
        super.init(serverModel: serverModel)
        
        guard let serverModel = serverModel as? CharacterServerModel else {
            return
        }
        
        id = serverModel.id
        name = serverModel.name
        resultDescription = serverModel.resultDescription
        if let path = serverModel.thumbnail?.path?.securePath(), let thumbnailExtension = serverModel.thumbnail?.thumbnailExtension {
            smallImageUrl = path + "/portrait_small." + thumbnailExtension
        }
        if let path = serverModel.thumbnail?.path?.securePath(), let thumbnailExtension = serverModel.thumbnail?.thumbnailExtension {
            largeImageUrl = path + "/portrait_incredible." + thumbnailExtension
        }
        comics = serverModel.comics
        series = serverModel.series
    }
}

