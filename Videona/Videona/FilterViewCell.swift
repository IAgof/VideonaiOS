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
                backgroundColor = UIColor.init(red: 0.7843, green: 0.8588, blue: 0.2039, alpha: 1.0)
            }else{
                backgroundColor = UIColor.clearColor()
            }
        }
    }
}