//
//  ChoiceCellCollectionViewCell.swift
//  Test
//
//  Created by Гурген on 14.01.2021.
//

import UIKit

class ChoiceCellCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var checkStatus: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkStatus.isHidden = true
    }

    func configure (screen : Screen, indexPath : IndexPath) {
        self.headerLabel.text = screen.cellItem[indexPath.row].title
        self.descriptionLabel.text = screen.cellItem[indexPath.row].listDescription
        self.priceLabel.text = screen.cellItem[indexPath.row].price
        self.imageIcon.image = screen.cellItem[indexPath.row].icon.image
    }

}
