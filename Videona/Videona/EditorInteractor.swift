//
//  EditorInteractor.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 9/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import AssetsLibrary

class EditorInteractor: NSObject,EditorInteractorInterface {
    
    //MARK: - Variables VIPER
    var delegate:EditorInteractorDelegate?

    var videosList = Project.sharedInstance.getVideoList()

    
    func getListData(){
        videosList = Project.sharedInstance.getVideoList()
        
        self.getPositionList()
        self.getImageList()
        self.getStopTimeList()
    }
    
    func getPositionList(){
        var positionList:[Int] = []
        
        for video in videosList{
            positionList.append(video.getPosition())
        }
        
        delegate?.setPositionList(positionList)
    }
    
    
    func getStopTimeList(){
        var stopTimeList:[Double] = []
        
        var stopTimeAcumulator = 0.0
        for video in videosList{
            stopTimeAcumulator += (video.getStopTime() - video.getStartTime())
            stopTimeList.append(stopTimeAcumulator)
        }
        
        delegate?.setStopTimeList(stopTimeList)
    }
    
    func getImageList(){
        var imageList:[UIImage] = []
        
        for video in self.videosList{
            ThumbnailListInteractor(videoPath: video.getMediaPath(),
                diameter: Utils.sharedInstance.thumbnailEditorListDiameter).getThumbnailImage({
                    thumb in
                    imageList.append(thumb)
                })
        }
        delegate?.setVideoImagesList(imageList)
    }
    
    func saveVideoToDocuments(url:NSURL) {
        
        let videoData = NSData(contentsOfURL: url)
        let title = getNewTitle()
        let path = getNewClipPath(title)
        
        videoData?.writeToFile(path, atomically: false)
        
        AddVideoToProjectUseCase.sharedInstance.add(path,
                                                    title: title)
        
        self.updateNewVideoValues()
    }
    
    func updateNewVideoValues(){
        let videoList = Project.sharedInstance.getVideoList()
        videoList.last?.mediaRecordedFinished()
    }
    func getNewTitle() -> String {
        return "\(Utils().giveMeTimeNow())videonaClip.m4v"
    }
    
    func getNewClipPath(title:String)->String{
        var path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        path =  path + "/\(title)"
        return path
    }
}