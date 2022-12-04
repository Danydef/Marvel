//
//  DetailInteractor.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import Foundation

protocol DetailInteractorInputProtocol: BaseInteractorInputProtocol {
    var detailAssemblyDTO: DetailAssemblyDTO? { get set }
    
    func getCharacterDetail()
}

protocol DetailInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func setCharacter(character: CharacterBusinessModel)
    func characterDetailError(error: CustomErrorModel)
}

class DetailInteractor: BaseInteractor {
    var detailAssemblyDTO: DetailAssemblyDTO?
    var provider: CharacterProviderProtocol?
    weak var presenter: DetailInteractorOutputProtocol? {
        super.basePresenter as? DetailInteractorOutputProtocol
    }
}

extension DetailInteractor: DetailInteractorInputProtocol {
    func getCharacterDetail() {
        provider?.characterList(dto: CharacterDTO(id: detailAssemblyDTO?.id), success: { [weak self] charactersServerModel in
            if let characterDetailServerModel = charactersServerModel.data?.results?.first,
               let characterBussiness = BaseInteractor.parseToBusinessModel(parserModel: CharacterBusinessModel.self, serverModel: characterDetailServerModel) {
                self?.presenter?.setCharacter(character: characterBussiness)
            }
        }, failure: { [weak self] error in
            self?.presenter?.characterDetailError(error: error)
        })
    }
}
