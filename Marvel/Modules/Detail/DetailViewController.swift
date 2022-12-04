//
//  DetailViewController.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import UIKit
import Kingfisher

protocol DetailViewProtocol: BaseViewProtocol {
    func setTitile(title: String)
    func setInfo(title: String, description: String, image: String, comics: Int, series: Int)
}

class DetailViewController: BaseViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var comicsLabel: UILabel!
    @IBOutlet weak var seriesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionLabel.sizeToFit()
    }
}

extension DetailViewController: DetailViewProtocol {
    func setTitile(title: String) {
        self.title = title
    }
    
    func setInfo(title: String, description: String, image: String, comics: Int, series: Int) {
        titleLabel.text = title
        descriptionLabel.text = description
        imageView.kf.setImage(with: URL(string: image))
        comicsLabel.text = "\(LocalizedKeys.Detail.comicsNumberLabel)\(comics)"
        seriesLabel.text = "\(LocalizedKeys.Detail.seriesNumberLabel)\(series)"
    }
}
