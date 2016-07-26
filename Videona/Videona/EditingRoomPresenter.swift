//
//  EditingRoomPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 19/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class EditingRoomPresenter: NSObject,EditingRoomPresenterInterface {
    
    //MARK: - Variables VIPER
    var controller: EditingRoomViewInterface?
    
    var wireframe: EditingRoomWireframe?
    
    //MARK: - Event handler
    func viewDidLoad(){
        wireframe?.showEditorInContainer()
    }
    
    func viewWillDisappear() {

    }
    
    func viewWillAppear() {

    }
    
    func pushBack() {
        wireframe?.goPrevController()
    }
    
    func pushMusic() {
        controller?.deselectAllButtons()
        controller?.selectMusicButton()
        
        wireframe?.showMusicInContainer()
    }
    
    func pushShare() {
        controller?.deselectAllButtons()
        controller?.selectShareButton()
        controller?.createAlertWaitToExport()
        
        let exporter = ExporterInteractor.init()
        exporter.exportVideos({
            exportPath,videoTotalTime in
            print("Export path response = \(exportPath)")
            self.controller?.dissmissAlertWaitToExport({
                
                self.wireframe?.showShareInContainer(exportPath)
            })
        })
    }
    
    func pushEditor() {
        controller?.deselectAllButtons()
        controller?.selectEditorButton()
        
        wireframe?.showEditorInContainer()
    }
    
    func pushSettings() {
        
    }
}