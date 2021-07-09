//
//  UpcomingController.swift
//  spacex
//
//  Created by Martin on 07/07/2021.
//

import UIKit

class UpcomingController: UIViewController, ImgDownloaderDelegate {

    @IBOutlet private weak var logoLaunch: UIImageView!
    @IBOutlet private weak var nameLaunch: UILabel!
    @IBOutlet private weak var dateLaunch: UILabel!
    
    var launch: Launch!
    
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
        dateFormater.dateFormat = "MMMM yyyy"
        
        if dateFormater.string(from: date) != "" {
            dateLaunch.text = dateFormater.string(from: date).uppercased()
        } else {
            dateLaunch.text = "UNAVAILABLE"
        }
        
        nameLaunch.text = launch.name
        imgDownloader.getImage(launch: launch)
    }
    
    func downloadFinished(data: Data?, launch: Launch) {
        guard let data = data,
              self.launch?.name == launch.name
              else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.logoLaunch.image = UIImage(data: data)
        }
    }
    
    func downloadImagesFinished(data: [Data]?, launch: Launch) {
        print("ok")
    }
}
