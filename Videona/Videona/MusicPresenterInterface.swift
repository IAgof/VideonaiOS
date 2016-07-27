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
    func didSelectMusicAtIndexPath(indexPath:NSIndexPath)
    func cancelDetailButtonPushed()
    func acceptDetailButtonPushed()
}

protocol MusicPresenterDelegate {
    func setTextList(titleList:[String])
    func setMusicImageList(imageList:[UIImage])
    
    func animateToShowDetail(title:String,
                             author:String,
                             image:UIImage)
    func animateToShowTable()
}