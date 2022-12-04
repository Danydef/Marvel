//
//  CharacterCellDrawer.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import UIKit

class CharacterCellDrawer {
    
    static func cell(model: CharacterViewModel, tableView: UITableView, presenter: Any?) -> UITableViewCell {
        guard let cell = BaseTableViewCell<Any>.createBaseCell(tableView: tableView, cell: CharacterTableViewCell.self, cellName: "CharacterTableViewCell", model: model) else {
            return UITableViewCell()
        }
        
        return cell
    }
}
