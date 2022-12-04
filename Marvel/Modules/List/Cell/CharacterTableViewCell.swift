//
//  CharacterTableViewCell.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import UIKit
import Kingfisher

class CharacterTableViewCell: BaseTableViewCell<CharacterViewModel> {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.subtitleLabel.sizeToFit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.thumbnailImageView.image = nil
    }
    
    override func configure(cellModel: CharacterViewModel) {
        super.configure(cellModel: cellModel)
        
        titleLabel.text = self.cellModel?.name
        subtitleLabel.text = self.cellModel?.characterDescription
        if let thumbnailImage = self.cellModel?.thumbnailImage {
            thumbnailImageView.kf.setImage(with: URL(string: thumbnailImage))
        }
    }
}
