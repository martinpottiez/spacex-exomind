//
//  OldController.swift
//  spacex
//
//  Created by Martin on 08/07/2021.
//

import UIKit
import Foundation

class OldController: UIViewController, ImgDownloaderDelegate {
    
    
    @IBOutlet private weak var dateLaunch: UILabel!
    @IBOutlet private weak var titleLaunch: UILabel!
    @IBOutlet private weak var successLaunch: UILabel!
    @IBOutlet private weak var recoveredLaunch: UILabel!
    @IBOutlet private weak var reusedLaunch: UILabel!
    @IBOutlet private weak var flightNumberLaunch: UILabel!
    @IBOutlet private var images: [UIImageView]!
    
    var launch: Launch!
    var imagesDownloaded: [UIImage] = []
    
    lazy var imgDownloader: ImgDownloader = {
        let imgDownloader = ImgDownloader()
        imgDownloader.delegate = self
        return imgDownloader
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
       
        let time = Double(launch.dateUnix)
        let date = Date(timeIntervalSince1970: time)
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd MMMM yyyy"
        
        if dateFormater.string(from: date) != nil {
            dateLaunch.text = dateFormater.string(from: date).uppercased()
        } else {
            dateLaunch.text = "UNAVAILABLE"
        }
        
        flightNumberLaunch.text = String(launch.flightNumber)
        titleLaunch.text = launch.name?.uppercased()
        if launch.success ?? false {
            successLaunch.text = "Valid"
        } else {
            successLaunch.text = "Fail"
        }
        
        if (launch.fairings?.recovered) != nil {
            recoveredLaunch.text = "Valid"
        } else {
            recoveredLaunch.text = "Fail"
        }
        
        if (launch.fairings?.reused) != nil {
            reusedLaunch.text = "Yes"
        } else {
            reusedLaunch.text = "No"
        }
        imgDownloader.getImages(launch: launch)
    }
    
    func downloadImagesFinished(data: [Data]?, launch: Launch) {
        guard let data = data,
              self.launch?.name == launch.name
              else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            for (increment, eachData) in data.enumerated() {
                
                self?.images[increment].image = UIImage(data: eachData)
            }//self?.imagesDownloaded.append( UIImage(data: data) ?? UIImage())
        }
    }
    
    func downloadFinished(data: Data?, launch: Launch) {
    }
}
