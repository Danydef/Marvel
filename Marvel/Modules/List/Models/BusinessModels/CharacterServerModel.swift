//
//  CharacterServerModel.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import Foundation

// MARK: - CharactersServerModel
struct CharactersServerModel: BaseServerModel {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: BaseServerModel {
    let offset, limit, total, count: Int?
    let results: [CharacterServerModel]?
}

// MARK: - Result
struct CharacterServerModel: BaseServerModel {
    let id: Int?
    let name, resultDescription: String?
    let thumbnail: Thumbnail?
    let resourceURI: String?
    let comics, series: Comics?
    let stories: Stories?
    let events: Comics?
    let urls: [URLElement]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case thumbnail, resourceURI, comics, series, stories, events, urls
    }
}

// MARK: - Comics
struct Comics: BaseServerModel {
    let available: Int?
    let collectionURI: String?
    let items: [ComicsItem]?
    let returned: Int?
}

// MARK: - ComicsItem
struct ComicsItem: BaseServerModel {
    let resourceURI: String?
    let name: String?
}

// MARK: - Stories
struct Stories: BaseServerModel {
    let available: Int?
    let collectionURI: String?
    let items: [StoriesItem]?
    let returned: Int?
}

// MARK: - StoriesItem
struct StoriesItem: BaseServerModel {
    let resourceURI: String?
    let name: String?
    let type: String?
}

// MARK: - Thumbnail
struct Thumbnail: BaseServerModel {
    let path: String?
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct URLElement: BaseServerModel {
    let type: URLType?
    let url: String?
}

enum URLType: String, Codable {
    case comiclink
    case detail
    case wiki
}
