//
//  CustomTableView.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import UIKit

struct CustomTableView {
    
    var type: TableType
    var tableView: UITableView
    
    init(type: TableType = .unspecified, tableView: UITableView) {
        self.type = type
        self.tableView = tableView
    }
}
