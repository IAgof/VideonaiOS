//
//  Social.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 13/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

class SocialNetwork:NSObject{
    var iconId:String?
    var title:String?
    
    init(iconId:String, title: String) {
        self.iconId = iconId
        self.title = title
    }
    
    func getIconId()->String{
        return iconId!
    }
    func getTitle()->String{
        return title!
    }
}