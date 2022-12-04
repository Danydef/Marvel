//
//  DetailPresenter.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import Foundation

protocol DetailPresenterProtocol: BasePresenterProtocol {
    
}

class DetailPresenter: BasePresenter {
    weak var view: DetailViewProtocol? {
        super.baseView as? DetailViewProtocol
    }
    
    var interactor: DetailInteractorInputProtocol? {
        super.baseInteractor as? DetailInteractorInputProtocol
    }
    
    var router: DetailRouterProtocol? {
        super.baseRouter as? DetailRouterProtocol
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func viewDidLoad() {
        interactor?.getCharacterDetail()
    }
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    func setCharacter(character: CharacterBusinessModel) {
        view?.setTitile(title: character.name ?? "")
        view?.setInfo(title: character.name ?? "", description: character.resultDescription ?? "", image: character.largeImageUrl ?? "", comics: character.comics?.items?.count ?? 0, series: character.series?.items?.count ?? 0)
    }
    
    func characterDetailError(error: CustomErrorModel) {
        showError(error: error)
    }
}
