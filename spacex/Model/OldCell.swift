//
//  OldCell.swift
//  spacex
//
//  Created by Martin on 06/07/2021.
//

import UIKit
import SDWebImage

class OldCell: UICollectionViewCell, ImgDownloaderDelegate {

    @IBOutlet private weak var dateCell: UILabel!
    @IBOutlet private weak var nameCell: UILabel!
    @IBOutlet private weak var imageCell: UIImageView!
    
    static let identifier = "OldCell"
    
    static var nib: UINib {
        UINib(nibName: String(describing: self), bundle: nil)
    }
    
    var launch: Launch?
    
    lazy var imgDownloader: ImgDownloader = {
        let imgDownloader = ImgDownloader()
        imgDownloader.delegate = self
        return imgDownloader
    }()
    
    func configure(with item: Launch) {
        
        let time = Double(item.dateUnix)
        let date = Date(timeIntervalSince1970: time)
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd MMMM yyyy"
        
        imageCell.layer.cornerRadius = 5
        
        self.launch = item
        
        nameCell.text = item.name
        //imageCell.image = #imageLiteral(resourceName: "OldImg")
        
        if dateFormater.string(from: date) != nil {
            dateCell.text = dateFormater.string(from: date).uppercased()
        } else {
            dateCell.text = "UNAVAILABLE"
        }
        //imgDownloader.getImage(launch: item)
        if let link = launch?.links?.flickr?.original?.first {
            imageCell
                .sd_setImage(with: URL(string: link), placeholderImage: #imageLiteral(resourceName: "OldImg"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func downloadFinished(data: Data?, launch: Launch) {
        guard let data = data,
              self.launch?.name == launch.name
              else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.imageCell.image = UIImage(data: data)
        }
    }
    
    func downloadImagesFinished(data: [Data]?, launch: Launch) {
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageCell.image = nil
    }
}
