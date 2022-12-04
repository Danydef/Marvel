//
//  TableViewManager.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import UIKit

enum TableType {
    case list
    case detail
    case unspecified
}

final class TableViewManager: NSObject {
    var arrayTableViews: [CustomTableView] = []
    weak var presenter: TablePresenterProtocol?
    
    init(arrayTableViews: [CustomTableView],
         presenter: Any?) {
        super.init()
        
        self.arrayTableViews = arrayTableViews
        self.presenter = presenter as? TablePresenterProtocol
        self.presenter?.tablePresenterDelegate = self
        
        setup()
    }
    
    func setup() {
        for customTable in arrayTableViews {
            customTable.tableView.delegate = self
            customTable.tableView.dataSource = self
            customTable.tableView.clipsToBounds = true
            customTable.tableView.separatorStyle = .singleLine
            customTable.tableView.separatorColor = .white
            customTable.tableView.separatorInset = .zero
            customTable.tableView.showsVerticalScrollIndicator = false
            customTable.tableView.keyboardDismissMode = .interactive
            customTable.tableView.tableFooterView = UIView(frame: .zero)
            customTable.tableView.estimatedRowHeight = 44
            customTable.tableView.sectionHeaderHeight = UITableView.automaticDimension
            customTable.tableView.rowHeight = UITableView.automaticDimension
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TableViewManager: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let type = self.findCustomTableView(tableView, arrayCustomTables: arrayTableViews)?.type ?? .unspecified
        
        return presenter?.numberOfCells(type, section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = findCustomTableView(tableView, arrayCustomTables: arrayTableViews)?.type ?? .unspecified
        
        return CommonFactoryCells.cell(for: presenter?.object(type, indexPath: indexPath), tableView: tableView, delegate: presenter)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = findCustomTableView(tableView, arrayCustomTables: arrayTableViews)?.type ?? .unspecified
        presenter?.didTapRow(type, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let type = findCustomTableView(tableView, arrayCustomTables: arrayTableViews)?.type ?? .unspecified
        let lastElement = tableView.numberOfRows(inSection: indexPath.section) - 1
        let isLast = (indexPath.row == lastElement)
        presenter?.willDisplay(type, indexPath: indexPath, isLast: isLast)
    }
}

// MARK: - TablePresenterDelegate
extension TableViewManager: TablePresenterDelegate {
    
    func dataSourceUpdated(_ tableType: TableType) {
        findTableView(tableType, arrayCustomTables: arrayTableViews)?.reloadData()
    }
}

extension TableViewManager {
    func findCustomTableView(_ tableView: UITableView, arrayCustomTables: [CustomTableView]) -> CustomTableView? {
        arrayTableViews.filter { $0.tableView == tableView }.first
    }
    
    func findTableView(_ tableType: TableType, arrayCustomTables: [CustomTableView]) -> UITableView? {
        arrayTableViews.filter { $0.type == tableType }.first?.tableView
    }
}
