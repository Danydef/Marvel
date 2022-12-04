//
//  CharacterViewModel.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import Foundation

final class CharacterViewModel: BaseViewModel {
    var id: Int?
    var name: String?
    var characterDescription: String?
    var thumbnailImage: String?
    
    required init(businessModel: BaseBusinessModel?) {
        super.init(businessModel: businessModel)
        
        guard let businessModel = businessModel as? CharacterBusinessModel else { return }
        
        id = businessModel.id
        name = businessModel.name
        characterDescription = (businessModel.resultDescription?.count ?? 0 > 0) ? businessModel.resultDescription : LocalizedKeys.CharacterViewModel.noDescription
        thumbnailImage = businessModel.smallImageUrl
    }
}
