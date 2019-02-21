//
//  PersonCollectionViewCell.swift
//  lun
//
//  Created by Alyona Hulak on 2/19/19.
//  Copyright © 2019 Alyona Hulak. All rights reserved.
//

import UIKit
import RealmSwift

class PersonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    func displayContent(photo: UIImage, name: String, phone: String) {
        personImage.image = photo
        nameLabel.text = name
        phoneLabel.text = phone
    }
}
