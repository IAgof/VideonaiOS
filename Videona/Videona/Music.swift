//
//  Music.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 27/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class Music: Audio {
    
    private var musicTitle:String!
    private var author:String!
    private var iconResourceId:String!
    private var musicResourceId:String!
    
    init(title:String,
                  author:String,
                  iconResourceId:String,
                  musicResourceId:String){
        
        super.init(title: title, mediaPath: musicResourceId)
        
        self.author = author
        self.musicTitle = title
        self.iconResourceId = iconResourceId
        self.musicResourceId = musicResourceId
    }
    
    func getMusicTitle()->String{
        return self.musicTitle
    }
    
    func setMusicTitle(title:String){
        self.musicTitle = title
    }
    
    func getAuthor()->String{
        return self.author
    }
    
    func setAuthor(author:String){
        self.author = author
    }
    
    func getIconResourceId()->String{
        return self.iconResourceId
    }
    
    func setIconResourceId(icon:String){
        self.iconResourceId = icon
    }
    
    func getMusicResourceId()->String{
        return self.musicResourceId
    }
    
    func setMusicResourceId(musicResource:String){
        self.musicResourceId = musicResource
    }
}