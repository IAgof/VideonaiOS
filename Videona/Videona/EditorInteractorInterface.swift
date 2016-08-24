//
//  EditorInteractorInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 9/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import AVFoundation

protocol EditorInteractorInterface {
    func getListData()
    func saveVideoToDocuments(url:NSURL)
    func seekToSelectedItemHandler(videoPosition:Int)
}

protocol EditorInteractorDelegate {
    func setPositionList(list:[Int])
    func setVideoImagesList(list:[UIImage])
    func setStopTimeList(list:[Double])
    func updateViewList()
    func seekToTimeOfVideoSelectedReceiver(time:Float)
}