//
//  UpcomingCell.swift
//  spacex
//
//  Created by Martin on 06/07/2021.
//

import UIKit
import Foundation



class UpcomingCell: UICollectionViewCell, ImgDownloaderDelegate {

    @IBOutlet private weak var dateCell: UILabel!
    @IBOutlet private weak var nameCell: UILabel!
    @IBOutlet private weak var imageCell: UIImageView!
    
    static let identifier = "UpcomingCell"
    
    static var nib: UINib {
        UINib(nibName: String(describing: self), bundle: nil)
    }
    
    lazy var imgDownloader: ImgDownloader = {
        let imgDownloader = ImgDownloader()
        imgDownloader.delegate = self
        return imgDownloader
    }()
    
    var launch: Launch?
    
    func configure(with item: Launch) {
        let time = Double(item.dateUnix)
        let date = Date(timeIntervalSince1970: time)
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMMM yyyy"
        
        imageCell.layer.cornerRadius = 5
        self.launch = item
        nameCell.text = item.name
        imageCell.image = #imageLiteral(resourceName: "UpcomingImg")
        if dateFormater.string(from: date) != "" {
            dateCell.text = dateFormater.string(from: date).uppercased()
        } else {
            dateCell.text = "UNAVAILABLE"
        }
        //imgDownloader.getImage(launch: item)
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
