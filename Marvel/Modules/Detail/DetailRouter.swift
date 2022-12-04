//
//  DetailRouter.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import Foundation

protocol DetailRouterProtocol: BaseRouterProtocol {
    func goBack()
}

class DetailRouter: BaseRouter {
    
}

extension DetailRouter: DetailRouterProtocol {
    func goBack() {
        popViewController(animated: true)
    }
}
