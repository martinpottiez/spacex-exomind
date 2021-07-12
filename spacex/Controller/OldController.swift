//
//  OldController.swift
//  spacex
//
//  Created by Martin on 08/07/2021.
//

import UIKit
import Foundation

class OldController: UIViewController {
    
    
    @IBOutlet private weak var dateLaunch: UILabel!
    @IBOutlet private weak var titleLaunch: UILabel!
    @IBOutlet private weak var descLaunch: UILabel!
    @IBOutlet private weak var successLaunch: UILabel!
    @IBOutlet private weak var recoveredLaunch: UILabel!
    @IBOutlet private weak var reusedLaunch: UILabel!
    @IBOutlet private weak var flightNumberLaunch: UILabel!
    @IBOutlet private var images: [UIImageView]!
    @IBOutlet private weak var secondStackView: UIStackView!
    @IBOutlet private weak var allImages: UIStackView!
    @IBOutlet private weak var table: UIStackView!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBOutlet private weak var youtubeButton: UIButton!
    @IBOutlet private weak var wikipediaButton: UIButton!
    @IBOutlet private weak var articleButton: UIButton!
    
    var launch: Launch!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
       
        scrollView.contentInset.bottom = 20
        
        let time = Double(launch.dateUnix)
        let date = Date(timeIntervalSince1970: time)
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd MMMM yyyy"
        
        if dateFormater.string(from: date) != "" {
            dateLaunch.text = dateFormater.string(from: date).uppercased()
        } else {
            dateLaunch.text = "UNAVAILABLE"
        }
        
        flightNumberLaunch.text = String(launch.flightNumber)
        titleLaunch.text = launch.name?.uppercased()
        descLaunch.text = launch.details
        
        if launch.success == true {
            successLaunch.text = "Valid"
        } else {
            successLaunch.text = "Fail"
        }
        
        if (launch.fairings?.recovered) == true {
            recoveredLaunch.text = "Valid"
        } else {
            recoveredLaunch.text = "No"
        }
        
        if (launch.fairings?.reused) == true {
            reusedLaunch.text = "Yes"
        } else {
            reusedLaunch.text = "No"
        }
        
        if launch.links?.webcast == nil {
            youtubeButton.isHidden = true
        }
        if launch.links?.wikipedia == nil {
            wikipediaButton.isHidden = true
        }
        if (launch.links?.article) == nil {
            articleButton.isHidden = true
        }
        
        if let link = launch?.links?.flickr?.original {
            for (inc, eachImage) in link.enumerated() {
                if inc > 3 {
                    return
                }
                images[inc].layer.cornerRadius = 5
                images[inc].sd_setImage(with: URL(string: eachImage))
            }
            switch link.count {
            case 0:
                allImages.isHidden = true
    
            case 2:
                secondStackView.isHidden = true
                
            default:
                break
            }
        }
    }
    
    @IBAction private func didTapYoutube(_ sender: Any) {
        
        let youtubeId = launch.links?.youtubeId
        
        if let url = URL(string: "youtube://\(String(describing: youtubeId))") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            if let url = launch.links?.webcast {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction private func didTapWikipedia(_ sender: Any) {
        if let url = launch.links?.wikipedia {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction private func didTapArticle(_ sender: Any) {
        if let url = launch.links?.article {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
