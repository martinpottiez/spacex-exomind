//
//  OldCell.swift
//  spacex
//
//  Created by Martin on 06/07/2021.
//

import UIKit
import SDWebImage

class OldCell: UICollectionViewCell {

    @IBOutlet private weak var dateCell: UILabel!
    @IBOutlet private weak var nameCell: UILabel!
    @IBOutlet private weak var overlayCell: UIView!
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
        
        overlayCell.layer.cornerRadius = 5
        imageCell.layer.cornerRadius = 5
        
        self.launch = item
        
        nameCell.text = item.name
        //imageCell.image = #imageLiteral(resourceName: "OldImg")
        
        if dateFormater.string(from: date) != "" {
            dateCell.text = dateFormater.string(from: date).uppercased()
        } else {
            dateCell.text = "UNAVAILABLE"
        }
        //imgDownloader.getImage(launch: item)
        if let link = launch?.links?.flickr?.original?.first {
            imageCell
                .sd_setImage(with: URL(string: link), placeholderImage: #imageLiteral(resourceName: "OldImg"))
        } else {
            imageCell.image = #imageLiteral(resourceName: "OldImg")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageCell.image = nil
    }
}
