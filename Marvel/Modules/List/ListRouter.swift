//
//  ListRouter.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import Foundation

protocol ListRouterProtocol: BaseRouterProtocol {
    func navigateToDetail(id: Int)
}

final class ListRouter: BaseRouter {
    weak var view: ListViewController? {
        return super.baseView as? ListViewController
    }
}

extension ListRouter: ListRouterProtocol {
    func navigateToDetail(id: Int) {
        pushViewController(DetailAssembly.detailView(detailAssemblyDTO: DetailAssemblyDTO(id: id)), animated: true)
    }
}
