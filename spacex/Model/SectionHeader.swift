//
//  SectionHeader.swift
//  spacex
//
//  Created by Martin on 07/07/2021.
//

import UIKit

class SectionHeader: UICollectionViewCell {

    @IBOutlet private weak var nameCell: UILabel!
    
    static let identifier = "SectionHeader"
    
    static var nib: UINib {
        UINib(nibName: String(describing: self), bundle: nil)
    }
    
    func configure(with item: Section) {
        
        nameCell.text = item.rawValue
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
