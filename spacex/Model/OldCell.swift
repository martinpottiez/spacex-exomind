//
//  OldCell.swift
//  spacex
//
//  Created by Martin on 06/07/2021.
//

import UIKit

class OldCell: UICollectionViewCell {

    @IBOutlet private weak var dateCell: UILabel!
    @IBOutlet private weak var nameCell: UILabel!
    @IBOutlet private weak var imageCell: UIImageView!
    
    static let identifier = "OldCell"
    
    static var nib: UINib {
        UINib(nibName: String(describing: self), bundle: nil)
    }
    
    var launch: Launch?
    
    func configure(with item: Launch) {
        let time = Double(item.dateUnix)
        let date = Date(timeIntervalSince1970: time)
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd MMMM yyyy"
        imageCell.layer.cornerRadius = 5
        self.launch = item
        nameCell.text = item.name
        imageCell.image = #imageLiteral(resourceName: "OldImg")
        if dateFormater.string(from: date) != nil {
            dateCell.text = dateFormater.string(from: date).uppercased()
        } else {
            dateCell.text = "UNAVAILABLE"
        }
        //imgDownloader.getImage(launch: item)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
