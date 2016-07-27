//
//  MusicInteractor.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 27/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

class MusicInteractor: MusicInteractorInterface {
    
    //MARK: - VIPER Variables
    var delegate:MusicInteractorDelegate?
    
    //MARK: - Variables
    var musicList:[Music] = []
    
    //MARK: - Interface
    func getMusicList(){
        musicList = MusicProvider.sharedInstance.retrieveLocalMusic()
        
        delegate?.setTextList(getTitleList(musicList))
        delegate?.setImageList(getMusicBackgroundImageList(musicList))
    }
    
    func getTitleFromIndexPath(index: Int) -> String {
        
        return musicList[index].getMusicTitle()
    }
    
    func getAuthorFromIndexPath(index: Int) -> String {
        return musicList[index].getAuthor()

    }
    
    func getImageFromIndexPath(index: Int) -> UIImage {
        if let image = UIImage(named: musicList[index].getIconResourceId()){
            return image
        }else{
            return UIImage()
        }
    }
    
    //MARK: - Inner functions
    func getTitleList(list:[Music]) -> [String] {
        var titleList:[String] = []
        
        for music in list{
            titleList.append(music.getMusicTitle())
        }
        
        return titleList
    }
    
    func getMusicBackgroundImageList(list:[Music]) -> [UIImage] {
        var imageList:[UIImage] = []
        
        for music in list{
            let image = UIImage(named: music.getIconResourceId())
            imageList.append(image!)
        }
        
        return imageList
    }
}