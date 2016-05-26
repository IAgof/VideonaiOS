//
//  ShaderEffect.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 12/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class ShaderEffect: Effect {
    
    var resourceId:String?
    
    init(identifier:String ,name:String ,iconPath:String ,resourceId:String,
                       type:String) {
        super.init(identifier: identifier, name: name, iconPath: iconPath, type: type)

        self.resourceId = resourceId
    }
    
    init(identifier:String ,name:String ,iconId:String ,resourceId:String,
                      type:String) {
        super.init(identifier: identifier, name: name, iconId: iconId, type: type)

        self.resourceId = resourceId
    }
    
    func getResourceId() ->String{
        if let resource = resourceId{
            return resource
        }else{
            return ""
        }
    }
}
