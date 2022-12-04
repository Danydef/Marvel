//
//  ListPresenter.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import Foundation

protocol ListPresenterProtocol: BasePresenterProtocol {
    func loadCharacters()
}

class ListPresenter: BasePresenter {
    
    weak var view: ListViewProtocol? {
        return super.baseView as? ListViewProtocol
    }
    
    var router: ListRouterProtocol? {
        return super.baseRouter as? ListRouterProtocol
    }
    
    var interactor: ListInteractorInputProtocol? {
        return super.baseInteractor as? ListInteractorInputProtocol
    }
    
    var characterList: [CharacterViewModel] = []
    weak var tablePresenterDelegate: TablePresenterDelegate?
    
    var limit: Int = 20
    var offset: Int = 0
    
    override func showNetworkErrorAlert() {
        super.showNetworkErrorAlert()
        
        viewWithError()
    }
    
    fileprivate func viewWithError() {
        if offset == 0 {
            view?.blankState(shows: true)
            view?.listStatus(shows: false)
        }
    }
}

extension ListPresenter: ListPresenterProtocol {

    func viewDidLoad() {
        view?.setTitle(title: LocalizedKeys.List.mainTitle)
        loadCharacters()
    }
    
    func loadCharacters() {
        interactor?.getCharacters(limit: limit, offset: offset)
    }
}

extension ListPresenter: ListInteractorOutputProtocol {
    func setCharacters(characters: [CharacterBusinessModel]) {
        view?.blankState(shows: false)
        view?.listStatus(shows: true)
        
        let characters = characters.map { CharacterViewModel(businessModel: $0) }
        characterList.append(contentsOf: characters)
        tablePresenterDelegate?.dataSourceUpdated(.unspecified)
    }
    
    func showErrorCharacters(error: CustomErrorModel) {
        showError(error: error)
        viewWithError()
    }
}

extension ListPresenter: TablePresenterProtocol {
    func numberOfCells(_ tableType: TableType, section: Int) -> Int {
        characterList.count
    }
    
    func object(_ tableType: TableType, indexPath: IndexPath) -> Any {
        characterList[indexPath.row]
    }
    
    func didTapRow(_ tableType: TableType, indexPath: IndexPath) {
        let character = characterList[indexPath.row]
        if let id = character.id {
            router?.navigateToDetail(id: id)
        }
    }
      
    func willDisplay(_ tableType: TableType, indexPath: IndexPath, isLast: Bool) {
        if isLast {
            offset += limit
            interactor?.getCharacters(limit: limit, offset: offset)
        }
    }
}
