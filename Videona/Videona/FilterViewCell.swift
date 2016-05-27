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
    
    var isSelectedCell = false
    
    func toggleSelected ()
    {
        if (isSelectedCell){
            backgroundColor = UIColor.redColor()
        }else {
            backgroundColor = UIColor.clearColor()
        }
    }
}