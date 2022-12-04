//
//  BaseTableViewCell.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import UIKit

class BaseTableViewCell<CellModel: Any>: UITableViewCell {
    
    var cellModel: CellModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        clear()
    }
    
    func setup() {
        selectionStyle = .none
    }
    
    func clear() {}
    
    func configure(cellModel: CellModel) {
        self.cellModel = cellModel
    }
}

extension BaseTableViewCell {
    
    static func createCell<T: UITableViewCell>(tableView: UITableView, cell: T.Type, cellName: String) -> T? {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellName) as? T
        if cell == nil {
            tableView.register(UINib(nibName: cellName, bundle: .main), forCellReuseIdentifier: cellName)
            cell = tableView.dequeueReusableCell(withIdentifier: cellName) as? T
        }
        
        return cell
    }
    
    static func createBaseCell<CellModel: Any, CellClass: BaseTableViewCell<CellModel>>(tableView: UITableView, cell: CellClass.Type, cellName: String, model: CellModel) -> CellClass? {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellName) as? CellClass
        if cell == nil {
            tableView.register(UINib(nibName: cellName, bundle: .main), forCellReuseIdentifier: cellName)
            cell = tableView.dequeueReusableCell(withIdentifier: cellName) as? CellClass
        }
        
        cell?.configure(cellModel: model)
        
        return cell
    }
}
