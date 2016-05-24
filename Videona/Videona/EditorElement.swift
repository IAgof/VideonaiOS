//
//  EditorElement.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class EditorElement {
    
    /**
     * Unique identifier for the element in the current project.
     */
    var identifier:String
    
    /**
     * Path to icon. Cannot be null.
     */
    var iconPath:String
    
    /**
     * Path to icon selected. If null use iconPath
     */
    var selectedIconPath:String
    
    // amm
    var iconResourceId:Int
    
    /**
     * Constructor of minimum number of parameters.
     *
     * @param identifier - Unique identifier of element in the current project.
     * @param iconPath   - Path to a resource that allows represent the element in the view.
     */
    init( identifier:String,iconPath:String) {
        self.identifier = identifier
        self.iconPath = iconPath
        self.selectedIconPath = ""
        self.iconResourceId = 0
    }
    
    /**
     * Parametrized constructor. Use all attributes from EditorElement object.
     *
     * @param identifier       - Unique identifier of element in the current project.
     * @param iconPath         - path to a resource to allow represent the element in the view.
     * @param selectedIconPath - if not null used as icon when something interact with the element.
     *                         If null it will be used the iconPath as default.
     */
    init(identifier:String, iconPath:String,selectedIconPath:String) {
        self.iconPath = iconPath
        self.selectedIconPath = selectedIconPath
        self.identifier = identifier
        self.iconResourceId = 0
    }
    
    
    
    init() {
        self.iconPath = ""
        self.selectedIconPath = ""
        self.identifier = ""
        self.iconResourceId = 0
    }
    
    func getIconResourceId() ->Int{
        return iconResourceId
    }
    
    func getIconPath() ->String{
        return iconPath
    }
    
    func setIconPath(iconPath:String) {
        self.iconPath = iconPath
    }
    
    func getSelectedIconPath()->String {
        return selectedIconPath
    }
    
    func setSelectedIconPath(selectedIconPath:String) {
        self.selectedIconPath = selectedIconPath
    }
}