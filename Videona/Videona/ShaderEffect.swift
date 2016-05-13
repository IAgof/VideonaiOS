//
//  ShaderEffect.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 12/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class ShaderEffect: Effect {
    
    var resourceId:Int?
    
    init(identifier:String ,name:String ,iconPath:String ,resourceId:Int,
                       type:String) {
        super.init(identifier: identifier, name: name, iconPath: iconPath, type: type)

        self.resourceId = resourceId
    }
    
    init(identifier:String ,name:String ,iconId:String ,resourceId:Int,
                      type:String) {
        super.init(identifier: identifier, name: name, iconId: iconId, type: type)

        self.resourceId = resourceId
    }
    
    func getResourceId() ->Int{
        if let resource = resourceId{
            return resource
        }else{
            return 0
        }
    }
}
