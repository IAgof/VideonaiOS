//
//  SettingsContent.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 17/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class SettingsContent:NSObject{
    var section:String?
    var title:String?
    var subTitle:String?
    
    init(title:String, subTitle:String,section:String) {
        self.title = title
        self.subTitle = subTitle
        self.section = section
    }
    
    init(title:String, section:String) {
        self.title = title
        self.subTitle = ""
        self.section = section
    }
    
    
    func getSettingsTitle()->String{
        return self.title!
    }
    
    func setSettingsTitle(title:String){
        self.title = title
    }
    
    func getSettingsSubtitle()->String{
        return self.subTitle!
    }
    
    func setSettingsSubtitle(subTitle:String){
        self.subTitle = subTitle
    }
    
    func getSection()->String{
        return section!
    }
}