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
    
    var launch: Launch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.editButtonItem.title = ""
        
        nameLaunch.text = launch.name
    }
}
