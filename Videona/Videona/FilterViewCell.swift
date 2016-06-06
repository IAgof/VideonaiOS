//
//  FilterViewCell.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 12/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

class FilterViewCell: UICollectionViewCell {
    
    @IBOutlet weak var filterImage: UIImageView!
    @IBOutlet weak var filterTitle: UILabel!
    
    var isSelectedCell: Bool = false{
        didSet {
            if isSelectedCell {
                backgroundColor = UIColor.init(red: 0.7411, green: 0.854, blue: 0.074, alpha: 0.8)
            }else{
                backgroundColor = UIColor.clearColor()
            }
        }
    }
}