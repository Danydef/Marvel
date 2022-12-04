//
//  ListAssembly.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import UIKit

final class ListAssembly: BaseAssembly {
    
    static func listNavigationView(listAssemblyDTO: ListAssemblyDTO? = nil) -> UINavigationController {
        UINavigationController(rootViewController: listView(listAssemblyDTO: listAssemblyDTO))
    }
    
    static func listView(listAssemblyDTO: ListAssemblyDTO? = nil) -> ListViewController {
        let view = ListViewController(nibName: Utils.getXib(xibFile: .listView), bundle: nil)
        
        let viper =  BaseAssembly.assembly(baseView: view,
                                           presenter: ListPresenter.self,
                                           router: ListRouter.self,
                                           interactor: ListInteractor.self)
        
        viper.interactor.listAssemblyDTO = listAssemblyDTO
        viper.interactor.provider = DataAssembly.characterProvider(interactor: viper.interactor)
        
        return view
    }
}

struct ListAssemblyDTO {
    
}
