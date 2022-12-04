//
//  ListViewController.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import UIKit

protocol ListViewProtocol: BaseViewProtocol {
    func setTitle(title: String)
    func listStatus(shows: Bool)
    func blankState(shows: Bool)
}

class ListViewController: BaseViewController {

    var presenter: ListPresenterProtocol? {
        return super.basePresenter as? ListPresenterProtocol
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var reloadButton: UIButton!
    
    var tableViewManager: TableViewManager?
    
    // MARK: UIViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeUI()
        tableViewManager = TableViewManager(arrayTableViews: [CustomTableView(tableView: self.tableView)], presenter: self.presenter)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
        
    @IBAction func reloadAction() {
        presenter?.loadCharacters()
    }
    
    private func customizeUI() {
        reloadButton.setTitle(LocalizedKeys.List.reloadButtonTitle, for: .normal)
        reloadButton.layer.cornerRadius = 10
    }
}

// MARK: - ListViewProtocol
extension ListViewController: ListViewProtocol {
    func listStatus(shows: Bool) {
        tableView.isHidden = !shows
    }
    
    func blankState(shows: Bool) {
        reloadButton.isHidden = !shows
    }
    
    func setTitle(title: String) {
        self.title = title
    }
}
