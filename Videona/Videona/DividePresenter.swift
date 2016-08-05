//
//  SplitPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 4/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class SplitPresenter: NSObject,SplitPresenterInterface,SplitInteractorDelegate {
    //MARK: - Variables VIPER
    var controller: SplitViewInterface?
    var delegate:SplitPresenterDelegate?
    var interactor: SplitInteractorInterface?
    var wireframe: SplitWireframe?
    
    var playerPresenter: PlayerPresenterInterface?
    var playerWireframe: PlayerWireframe?
    
    //MARK: - Variables
    var videoSelectedIndex:Int!{
        didSet{
            interactor?.setVideoPosition(videoSelectedIndex)
        }
    }
    
    var splitValue:Float!{
        didSet{
            if splitValue != nil {
                delegate?.setSplitValueText(String.init(format: "%.02f", splitValue))
                if maximumValue != nil && !(playerPresenter?.isPlayingVideo())!{
                    playerPresenter?.seekToTime(splitValue/maximumValue)
                }
//                if upperValue != nil{
//                    updateVideoParams()
//                    updateRangeVal()
//                }
            }
        }
    }
    
    var maximumValue:Float!

    //MARK: - Interface
    func viewDidLoad() {
        
        wireframe?.presentPlayerInterface()
        interactor?.getVideoParams()
        
        controller?.configureRangeSlider(splitValue,
                                         maximumValue: maximumValue)
        interactor?.setUpComposition({composition in
                                        self.playerPresenter?.createVideoPlayer(composition)
        })
    }
    
    func viewWillDissappear() {
        playerPresenter?.onVideoStops()
    }
    
    func pushAcceptHandler() {
//        interactor?.setSplitVideosOnProject()
        wireframe?.goPrevController()
    }
    
    func pushCancelHandler() {
        wireframe?.goPrevController()
    }
    func pushBack() {
        wireframe?.goPrevController()
    }
    
    func setSplitValue(value:Float) {
        self.splitValue = value
    }
    
    //MARK: Interactor Delegate
    func settSplitValue(value: Float) {
        splitValue = value
    }
    
    func setMaximumValue(value: Float) {
        maximumValue = value
    }
}