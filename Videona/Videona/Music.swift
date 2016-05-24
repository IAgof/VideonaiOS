//
//  Music.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

/**
 * @deprecated
 */
class Music: Audio {
    
    //TODO en el futuro no será un recurso sino que se obtendrá
    var musicResourceId:Int
    var colorResourceId:Int
    //TODO refactorizar nombre
    var nameResourceId:String
    var IconResourceId:Int
   
    init(iconResourceId:Int, nameResourceId:String,musicResourceId:Int,colorResourceId:Int) {
        self.musicResourceId = musicResourceId
        self.colorResourceId = colorResourceId
        self.nameResourceId = nameResourceId
        self.IconResourceId = iconResourceId
        super.init(identifier: "", iconPath: "", mediaPath: "", fileStartTime: 0, duration: 0, authors: Array<User>(), license: License())
    }
    
    func getMusicResourceId() ->Int{
        return musicResourceId
    }
    
    func setMusicResourceId(musicResourceId:Int){
        self.musicResourceId = musicResourceId
    }
    
    func getColorResourceId()  ->Int{
        return colorResourceId
    }
    
    func setColorResourceId(colorResourceId:Int) {
        self.colorResourceId = colorResourceId
    }
    
    func setNameResourceId(name:String) {
        self.nameResourceId = name
    }
    
    func getNameResourceId() ->String {
        return nameResourceId
    }
    
    override func getIconResourceId()  ->Int{
        return IconResourceId
    }
    
    func setIconResourceId(iconResourceId:Int) {
        self.iconResourceId = iconResourceId
    }
}