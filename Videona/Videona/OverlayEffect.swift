//
//  OverlayEffect.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 12/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class OverlayEffect : Effect {
    
    var resourcePath:String?
    var resourceId:Int?
    
    init (identifier:String ,name:String ,iconPath:String ,resourcePath:String,
    type:String) {
        super.init(identifier: identifier, name: name, iconPath: iconPath, type: type)
        
        self.resourcePath = resourcePath
        self.resourceId = -1
    }
    
    init (identifier:String ,name:String ,iconPath:String ,resourceId:Int,
    type:String) {
        super.init(identifier: identifier, name: name, iconPath: iconPath, type: type)

        self.resourcePath = nil
        self.resourceId = resourceId
    }
    
    init(identifier:String ,name:String ,iconId:String ,resourceId:Int,
    type:String) {
        super.init(identifier: identifier, name: name, iconId: iconId, type: type)

        self.resourcePath = nil
        self.resourceId = resourceId
    }
    
    func getResourcePath() ->String{
        if let resource = resourcePath{
            return resource
        }else{
            return ""
        }
    }
    
    func getResourceId() ->Int{
        if let resource = resourceId{
            return resource
        }else{
            return 0
        }
    }
    
//    public Bitmap getImage() {
//        File image = new File(resourcePath) 
//        BitmapFactory.Options bmOptions = new BitmapFactory.Options() 
//        Bitmap bitmap = BitmapFactory.decodeFile(image.getAbsolutePath(),bmOptions) 
//        
//        return bitmap
//    }
}