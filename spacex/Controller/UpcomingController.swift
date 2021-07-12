//
//  UpcomingController.swift
//  spacex
//
//  Created by Martin on 07/07/2021.
//

import UIKit

class UpcomingController: UIViewController {

    @IBOutlet private weak var logoLaunch: UIImageView!
    @IBOutlet private weak var nameLaunch: UILabel!
    @IBOutlet private weak var dateLaunch: UILabel!
    @IBOutlet private weak var detailsLaunch: UILabel!
    
    var launch: Launch!
    
    var twitterUrl = URL(string: "https://twitter.com/spacex")
    var youtubeUrl = URL(string: "https://www.youtube.com/spacex")
    
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

        if launch.details == nil {
            detailsLaunch.text = "No available information for this flight."
        } else {
            detailsLaunch.text = launch.details
        }
        
        if let logoUrl = launch.links?.patch?.small {
            logoLaunch.sd_setImage(with: URL(string: logoUrl))
        }
    }
    
    @IBAction private func didTapTwitter(_ sender: Any) {
        if let url = twitterUrl {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction private func didTapYoutube(_ sender: Any) {
        if let url = youtubeUrl {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
