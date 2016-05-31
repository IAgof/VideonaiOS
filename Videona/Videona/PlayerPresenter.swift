//
//  PlayerPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 13/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

class PlayerPresenter:NSObject,PlayerPresenterInterface{
    
    var wireframe: PlayerWireframe?
    var controller: PlayerInterface?
    var playerDelegate: PlayerDelegate?
    var recordWireframe: RecordWireframe?
    var playerInteractor: PlayerInteractorInterface?
        
    func configureUserInterfaceForPresentation(addViewUserInterface: PlayerInterface) {
        
    }
    
    func createVideoPlayer(videoPath:String) {
        controller?.setPlayerMovieURL(NSURL.init(fileURLWithPath: videoPath))
        controller?.createVideoPlayer()
    }
    
    func layoutSubViews(){
        if let view = self.controller?.getView(){
            self.controller?.updateLayers(CGRectMake(0, 0, view.frame.width, view.frame.height))
        }else{
            self.controller?.updateLayers(CGRectMake(0, 0, 320,180))
        }
    }
}