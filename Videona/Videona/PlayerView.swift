//
//  PlayerView.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 13/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

class PlayerView: UIView,PlayerInterface {
    
    var eventHandler: PlayerPresenterInterface?
    
    var transitioningBackgroundView : UIView = UIView()
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "PlayerView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
}