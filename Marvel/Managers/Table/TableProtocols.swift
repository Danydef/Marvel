//
//  TableProtocols.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

// Protocol used to the View can communicate with Presenter

import Foundation

protocol TablePresenterProtocol: AnyObject {
    var tablePresenterDelegate: TablePresenterDelegate? { get set }
    
    func numberOfCells(_ tableType: TableType, section: Int) -> Int
    func object(_ tableType: TableType, indexPath: IndexPath) -> Any
    func didTapRow(_ tableType: TableType, indexPath: IndexPath)
    func heightForRow(_ tableType: TableType, indexPath: IndexPath) -> Int
    func willDisplay(_ tableType: TableType, indexPath: IndexPath, isLast: Bool)
}

extension TablePresenterProtocol {
    func didTapRow(_ tableType: TableType, indexPath: IndexPath) {}
    func heightForRow(_ tableType: TableType, indexPath: IndexPath) -> Int { return 44 }
    func willDisplay(_ tableType: TableType, indexPath: IndexPath, isLast: Bool) {}
}

protocol TablePresenterDelegate: AnyObject {
    func dataSourceUpdated(_ tableType: TableType)
}
