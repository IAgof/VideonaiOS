//
//  MusicPresenterInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 27/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

protocol MusicPresenterInterface {
    func viewDidLoad()
    func viewWillDisappear()
    func viewWillAppear()
    func viewDidAppear()
    func didSelectMusicAtIndexPath(indexPath:NSIndexPath)
    func cancelDetailButtonPushed()
    func acceptDetailButtonPushed()
    func removeDetailButtonPushed()
    
    func setMusicDetailInterface(eventHandler:MusicDetailInterface)
    
    func expandPlayer()
    func updatePlayerLayer()
}

protocol MusicPresenterDelegate {
    func setTextList(titleList:[String])
    func setMusicImageList(imageList:[UIImage])
    
    func animateToShowDetail(title:String,
                             author:String,
                             image:UIImage)
    func animateToShowTable()
}