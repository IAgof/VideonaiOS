//
//  Effect.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 12/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation


class Effect:NSObject {
    
    /**
     * Identifier of the effect. Cannot be null.
     */
    var identifier:String?
    /**
     * Name of the effect. Cannot be null.
     */
    var name: String?
    /**
     * Path to icon resource. Cannot be null.
     */
    var iconPath:String?
    var iconId:String?
    var type:String?
    
    override init() {
        self.identifier = ""
        self.name = ""
        self.iconPath = ""
        self.iconId = ""
        self.type = ""
    }
    
    /**
     * Constructor.
     *
     * @param identifier          - Identifier of the effect
     * @param name                - Name of the effect
     * @param iconPath    - Path to the icon resource
     */
    init(identifier:String,name:String,iconPath:String, type:String) {
        self.identifier = identifier
        self.name = name
        self.iconPath = iconPath
        self.iconId = ""
        self.type = type
    }
    
    /**s
     * Constructor.
     *
     * @param identifier        - Identifier of the effect
     * @param name              - Name of the effect
     * @param iconId    - Path to the icon resource
     */
    init(identifier:String,  name:String, iconId:String,  type:String) {
        self.identifier = identifier
        self.name = name
        self.iconPath = nil
        self.iconId = iconId
        self.type = type
    }
    
    func getIdentifier() ->String{
        return identifier!
    }
    
    func getName() ->String{
        return name!
    }
    
    func getIconPath() ->String{
        return iconPath!
    }
    
    func getIconId() ->String{
        return iconId!
    }
    
    func getType() ->String{
        return type!
    }
}