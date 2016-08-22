//
//  DuplicatePresenterInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 4/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

protocol DuplicatePresenterInterface {
    func viewDidLoad()
    func viewWillDissappear()
    func pushCancelHandler()
    func pushAcceptHandler()
    func pushBack()
    
    func pushLessClips()
    func pushPlusClips()
    func expandPlayer()
    func updatePlayerLayer()
}

protocol DuplicatePresenterDelegate {
    func setNumberDuplicates(text:String)
    func setCloneYourClipText(text:String)
    func setThumbnails(image:UIImage)
}