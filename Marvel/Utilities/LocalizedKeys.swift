//
//  LocalizedKeys.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import Foundation

struct LocalizedKeys {
    struct List {
        static let mainTitle = NSLocalizedString("title_app", comment: "")
        static let reloadButtonTitle = NSLocalizedString("list_view_reload_button_title", comment: "")
    }
    
    struct Detail {
        static let comicsNumberLabel = NSLocalizedString("detail_view_comics_number", comment: "")
        static let seriesNumberLabel = NSLocalizedString("detail_view_series_number", comment: "")
    }
    
    struct CharacterViewModel {
        static let noDescription = NSLocalizedString("character_no_description", comment: "")
    }
}
