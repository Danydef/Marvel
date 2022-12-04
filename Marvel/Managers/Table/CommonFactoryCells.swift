//
//  CommonFactoryCells.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import UIKit

class CommonFactoryCells: NSObject {
    
    class func view(for object: Any?, tableView: UITableView, delegate: Any? = nil) -> UIView {
        return self.cell(for: object, tableView: tableView, delegate: delegate).contentView
    }
    
    class func cell(for object: Any?, tableView: UITableView, delegate: Any? = nil) -> UITableViewCell {
        switch object {
        case let model as CharacterViewModel:
            return CharacterCellDrawer.cell(model: model, tableView: tableView, presenter: delegate)
        default:
            return UITableViewCell()
        }
    }
}
