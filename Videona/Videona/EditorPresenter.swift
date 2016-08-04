//
//  EditorPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 21/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

class EditorPresenter: NSObject,EditorPresenterInterface {
    //MARK: - Variables VIPER
    var controller: EditorViewInterface?
//    var interactor: EditorInteractorInterface?
    
    var wireframe: EditorWireframe?
    var playerPresenter: PlayerPresenterInterface?
    var playerWireframe: PlayerWireframe?
    var fullScreenPlayerWireframe: FullScreenPlayerWireframe?

    //MARK: - Variables
    var videosList = Project.sharedInstance.getVideoList()
    var selectedCellIndexPath = NSIndexPath(forRow: 0, inSection: 0)
    
    //MARK: - Interface
    func viewDidLoad() {
        //Auto select first item on first load
        self.didSelectItemAtIndexPath(selectedCellIndexPath)
        
        controller?.setUpGestureRecognizer()
        
        wireframe?.presentPlayerInterface()

        loadVideoListFromProject()
        
//        self.setTestVideoData()
        
        self.setVideoDataToView()
        self.reloadPositionNumberAfterMovement()
    }
    
    func setTestVideoData()  {
        for _ in 1...20 {
            AddVideoToProjectUseCase.sharedInstance.add("", title: "")
        }
        
        self.loadVideoListFromProject()
    }
    
    func setVideoDataToView(){
        controller?.setPositionList(self.getPositionList())

        self.controller?.setVideoImagesList(self.getImageList())
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.controller?.reloadCollectionViewData()
        })
    }
    
    func getPositionList() -> [Int] {
        var positionList:[Int] = []
        
        for video in videosList{
            positionList.append(video.getPosition())
        }
        
        return positionList
    }
    
    func getImageList() -> [UIImage] {
        var imageList:[UIImage] = []
        
        for video in self.videosList{
            ThumbnailListInteractor(videoPath: video.getMediaPath(),
                diameter: Utils.sharedInstance.thumbnailEditorListDiameter).getThumbnailImage({
                    thumb in
                    imageList.append(thumb)
                })
        }
        return imageList
    }
    
    func viewWillAppear() {
        self.viewDidLoad()
    }
    
    func viewWillDisappear() {
        playerPresenter?.pauseVideo()
    }
    
    func didSelectItemAtIndexPath(indexPath: NSIndexPath) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.controller?.deselectCell(self.selectedCellIndexPath)
                self.controller?.selectCell(indexPath)
                self.selectedCellIndexPath = indexPath
        })
    }
    
    func cellForItemAtIndexPath(indexPath: NSIndexPath) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            if indexPath == self.selectedCellIndexPath {
                self.controller?.selectCell(indexPath)
            }else{
                self.controller?.deselectCell(indexPath)
            }
        })

    }
    
    func moveItemAtIndexPath(sourceIndexPath: NSIndexPath,
                                                 toIndexPath destinationIndexPath: NSIndexPath) {
        self.moveClipToPosition(sourceIndexPath.item,
                                       destionationPosition: destinationIndexPath.item)
       
        if selectedCellIndexPath == sourceIndexPath {
            selectedCellIndexPath = destinationIndexPath
        }
        
        reloadPositionNumberAfterMovement()
    }
    
    func pushTrimHandler() {
        wireframe?.presentTrimController(selectedCellIndexPath.item)
    }
    
    func pushDivideHandler() {
        
    }
    
    func pushDuplicateHandler() {
        wireframe?.presentDuplicateController(selectedCellIndexPath.item)
    }
    
    //MARK: - Inner functions
    func moveClipToPosition(sourcePosition:Int,
                            destionationPosition:Int){
        MoveVideoUseCase.sharedInstance.moveClipToPosition(sourcePosition,
                                                           destionationPosition: destionationPosition)
    }
    
    func reloadPositionNumberAfterMovement() {
        ReloadPositionVideosProjectUseCase.sharedInstance.reloadPositionNumberAfterMovement()

        loadVideoListFromProject()
        
        self.setVideoDataToView()
    }
    
    func loadVideoListFromProject() {
        self.videosList = Project.sharedInstance.getVideoList()
        
        playerPresenter?.createVideoPlayer(GetActualProjectAVCompositionUseCase.sharedInstance.getComposition())
    }
    
    func removeVideoClip(position: Int) {
        Utils().debugLog("remove button pushed in position \(position)")
        
        RemoveVideoFromProjectUseCase.sharedInstance.remove(position)
        
        self.reloadPositionNumberAfterMovement()
        
        self.loadVideoListFromProject()
        
        self.setVideoDataToView()
    }
}