//
//  EditorPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 21/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

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
    
    let NO_SELECTED_CELL = -1
    
    //MARK: - Interface
    func viewDidLoad() {
        self.reloadPositionNumberAfterMovement()
        
        //Auto select first item on first load
        self.didSelectItemAtIndexPath(selectedCellIndexPath)
        
        controller?.setUpGestureRecognizer()
        
        wireframe?.presentPlayerInterface()
        
        self.setVideoDataToView()
    }
    
    func setVideoDataToView(){
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.controller?.reloadCollectionViewData()
        })
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
    func pushDuplicateHandler() {
        if checkIfSelectedCellExits(){
            wireframe?.presentDuplicateController(selectedCellIndexPath.item)
        }
    }
    
    func pushTrimHandler() {
        if checkIfSelectedCellExits(){
            wireframe?.presentTrimController(selectedCellIndexPath.item)
        }
    }
    
    func pushSplitHandler() {
        if checkIfSelectedCellExits(){
            wireframe?.presentSplitController(selectedCellIndexPath.item)
        }
    }

    func checkIfSelectedCellExits()->Bool{
        let numberOfCells = controller?.numberOfCellsInCollectionView()
        
        if numberOfCells >= selectedCellIndexPath.item {
            return true
        }else{
            return false
        }
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
        interactor?.getListData()
        
        playerPresenter?.createVideoPlayer(GetActualProjectAVCompositionUseCase.sharedInstance.getComposition())
    }
    
    func removeVideoClip(position: Int) {
        Utils().debugLog("remove button pushed in position \(position)")
        
        RemoveVideoFromProjectUseCase.sharedInstance.remove(position)
        
        self.reloadPositionNumberAfterMovement()
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
}