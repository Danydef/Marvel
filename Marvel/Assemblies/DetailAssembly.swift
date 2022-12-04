//
//  DetailAssembly.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import Foundation

final class DetailAssembly: BaseAssembly {
    
    static func detailView(detailAssemblyDTO: DetailAssemblyDTO? = nil) -> DetailViewController {
        let view = DetailViewController(nibName: Utils.getXib(xibFile: .detailView), bundle: nil)
        
        let viper =  BaseAssembly.assembly(baseView: view,
                                           presenter: DetailPresenter.self,
                                           router: DetailRouter.self,
                                           interactor: DetailInteractor.self)
        
        viper.interactor.detailAssemblyDTO = detailAssemblyDTO
        viper.interactor.provider = DataAssembly.characterProvider(interactor: viper.interactor)
        
        return view
    }
}

struct DetailAssemblyDTO {
    var id: Int?
}
