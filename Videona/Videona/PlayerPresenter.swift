//
//  PlayerPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 13/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class PlayerPresenter:NSObject,PlayerPresenterInterface{
    
    //MARK: - VIPER
    var playerInteractor: PlayerInteractorInterface?
    var controller: PlayerInterface?
    var playerDelegate: PlayerDelegate?
    
    var wireframe: PlayerWireframe?
    var recordWireframe: RecordWireframe?

    //MARK: - Variables
    var isPlaying = false
    
    //MARK: - Init
    func createVideoPlayer(composition:AVMutableComposition) {
        controller?.setPlayerMovieComposition(composition)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.controller?.createVideoPlayer()
            })
        }
    }
    
    func layoutSubViews(){
        if let view = self.controller?.getView(){
            self.controller?.updateLayers()
        }
    }
    //MARK: - Handler
    func onVideoStops() {
        isPlaying = false
        
        controller?.setUpVideoFinished()
    }
    
    func pauseVideo() {
        if isPlaying {
            isPlaying = false
            controller?.pauseVideoPlayer()
        }
    }
    
    func pushPlayButton() {
        if(isPlaying){
            controller?.pauseVideoPlayer()
            isPlaying = false
        }else{
            playPlayer()
        }
    }
    
    func videoPlayerViewTapped() {
        if(isPlaying){
            controller?.pauseVideoPlayer()
            isPlaying = false
        }else{
            playPlayer()
        }
    }
    
    func playPlayer() {
        controller?.playVideoPlayer()
        isPlaying = true
    }
    
    func updateSeekBar() {
        controller!.updateSeekBarOnUI()
    }
    
    func seekToTime(time:Float){
        controller?.seekToTime(time)
    }
    
    func isPlayingVideo() -> Bool {
        return self.isPlaying
    }
}