//
//  EditorClipsCell.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 21/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import UIKit

class EditorClipsCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var positionNumberLabel: UILabel!
    @IBOutlet weak var removeClipButton: UIButton!
    
    var isClipSelected: Bool = false{
        didSet {            
            self.layer.borderWidth = (isClipSelected ? 3 : 0)
            self.layer.borderColor = (isClipSelected ? UIColor.greenColor().CGColor : UIColor.clearColor().CGColor)
            
            self.removeClipButton.backgroundColor = (isClipSelected ? UIColor.greenColor() : UIColor.clearColor())
        }
    }
        
}
