//
//  EditorPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 21/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class EditorPresenter: NSObject,EditorPresenterInterface,EditorInteractorDelegate {
    //MARK: - Variables VIPER
    var controller: EditorViewInterface?
    var interactor: EditorInteractorInterface?
    
    var wireframe: EditorWireframe?
    var playerPresenter: PlayerPresenterInterface?
    var playerWireframe: PlayerWireframe?
    var fullScreenPlayerWireframe: FullScreenPlayerWireframe?

    //MARK: - Variables
    var selectedCellIndexPath = NSIndexPath(forRow: 0, inSection: 0)
    var videoToRemove = -1
    let NO_SELECTED_CELL = -1
    var stopList:[Double] = []
    var isGoingToExpandPlayer = false
    
    //MARK: - Interface
    func viewDidLoad() {
        controller?.configurePickerController()
        
        self.reloadPositionNumberAfterMovement()
        
        //Auto select first item on first load
        self.didSelectItemAtIndexPath(selectedCellIndexPath)
        
        controller?.setUpGestureRecognizer()
        
        wireframe?.presentPlayerInterface()
        controller?.bringToFrontExpandPlayerButton()

        self.setVideoDataToView()
    }
    
    func setVideoDataToView(){
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.controller?.reloadCollectionViewData()
        })
    }
    
    func viewWillAppear() {
        if !isGoingToExpandPlayer{
            self.viewDidLoad()
            
            playerPresenter?.onVideoStops()
        }else{
            isGoingToExpandPlayer = false
        }
    }
    
    func viewWillDisappear() {
        if !isGoingToExpandPlayer{
            playerPresenter?.onVideoStops()
        }
    }
    
    func didSelectItemAtIndexPath(indexPath: NSIndexPath) {
        updateSelectedCellUI(indexPath)
        
        self.seekToSelectedItem(indexPath.item)
    }
    
    func seekToSelectedItem(videoPosition:Int){
        interactor?.seekToSelectedItemHandler(videoPosition)
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
        
        
        let project = Project.sharedInstance
        controller?.getTrackerObject().trackClipsReordered(project)
    }
    func pushDuplicateHandler() {
        if checkIfSelectedCellExits() && canGoToAnyEditorAction(){
            wireframe?.presentDuplicateController(selectedCellIndexPath.item)
        }
    }
    
    func pushTrimHandler() {
        if checkIfSelectedCellExits() && canGoToAnyEditorAction(){
            wireframe?.presentTrimController(selectedCellIndexPath.item)
        }
    }
    
    func pushSplitHandler() {
        if checkIfSelectedCellExits() && canGoToAnyEditorAction(){
            wireframe?.presentSplitController(selectedCellIndexPath.item)
        }
    }
    
    func canGoToAnyEditorAction() -> Bool {
        let nClips = Project.sharedInstance.numberOfClips()
        
        if nClips != 0 {
            return true
        }else{
            return false
        }
    }
    
    func pushAddVideoHandler() {        
        controller?.presentPickerController()
    }
    
    func expandPlayer() {
        isGoingToExpandPlayer = true
        
        wireframe?.presentExpandPlayer()
    }
    
    func updatePlayerLayer() {
        playerPresenter!.layoutSubViews()
    }
    
    func checkIfSelectedCellExits()->Bool{
        let numberOfCells = controller?.numberOfCellsInCollectionView()
        
        if numberOfCells >= selectedCellIndexPath.item {
            return true
        }else{
            return false
        }
    }
    
    func seekBarUpdateHandler(value: Float) {
        let seekBarValue = Double(value) * getCompositionDuration()
        var cellPosition = 0
        
        for time in stopList{
            if (seekBarValue < time){
                if cellPosition == selectedCellIndexPath.item {
                    return
                }else{
                    updateSelectedCellUI(NSIndexPath(forItem: cellPosition, inSection: 0))
                    
                    return
                }
            }
            cellPosition += 1
        }
    }
    

    
    func saveVideoToDocuments(url: NSURL) {
        interactor?.saveVideoToDocuments(url)
    }
    
    func removeVideoClip(position: Int) {
        videoToRemove = position
        
        controller?.showAlertRemove(Utils().getStringByKeyFromEditor(EditorTextConstants.REMOVE_CLIP_ALERT_TITLE),
                                    message: Utils().getStringByKeyFromEditor(EditorTextConstants.REMOVE_CLIP_ALERT_MESSAGE),
                                    yesString: Utils().getStringByKeyFromEditor(EditorTextConstants.YES_ACTION))
    }
    
    func removeVideoClipAfterConfirmation() {
        RemoveVideoFromProjectUseCase.sharedInstance.remove(videoToRemove)
        
        self.reloadPositionNumberAfterMovement()
    }
    
    func pickerControllerDidCancel() {
        controller?.dissmissAlertController()
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
        
        selectedCellIndexPath = NSIndexPath(forRow: 0, inSection: 0)
    }
    
    func loadVideoListFromProject() {
        interactor?.getListData()
        
        playerPresenter?.createVideoPlayer(GetActualProjectAVCompositionUseCase.sharedInstance.getComposition())
    }
    
    func getCompositionDuration()->Double{
        
        return stopList.last!
    }
    
    func updateSelectedCellUI(indexPath:NSIndexPath){
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.controller?.deselectCell(self.selectedCellIndexPath)
            self.controller?.selectCell(indexPath)
            self.selectedCellIndexPath = indexPath
        })
    }
    
    //MARK: - Interactor delegate
    func setPositionList(list: [Int]) {
        controller?.setPositionList(list)
        self.setVideoDataToView()
    }
    
    func setVideoImagesList(list: [UIImage]) {
        self.controller?.setVideoImagesList(list)
        self.setVideoDataToView()
    }
    
    func setStopTimeList(list: [Double]) {
        self.stopList = list
    }
    
    func updateViewList() {
        controller?.dissmissAlertController()
        
        self.loadVideoListFromProject()
    }
    
    func seekToTimeOfVideoSelectedReceiver(time:Float){
        playerPresenter?.seekToTime(time)
    }
}