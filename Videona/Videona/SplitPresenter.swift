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
    
    var isMovingByPlayer = false
    var isGoingToExpandPlayer = false
    var isFirstLoad = true
    
    var splitValue:Float!{
        didSet{
            if splitValue != nil {
                let text = Utils.sharedInstance.hourToString(Double(splitValue))
                delegate?.setSplitValueText(text)
                
                if maximumValue != nil{
                    setValuesOnFirstLoad()
                    
                    if isMovingByPlayer{
                        controller?.setSliderValue(splitValue)
                    }else {
                        self.playerPresenter?.seekToTime(splitValue/maximumValue)
                        self.isMovingByPlayer = false
                    }
                }
            }
        }
    }
    
    func setValuesOnFirstLoad() {
        if isFirstLoad {
            Utils.sharedInstance.delay(0.3, closure: {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.controller?.setSliderValue(self.splitValue)
                    self.playerPresenter?.seekToTime(self.splitValue/self.maximumValue)
                })
            })
            isFirstLoad = false
        }
    }
    
    var maximumValue:Float!

    //MARK: - Interface
    func viewDidLoad() {
        
        wireframe?.presentPlayerInterface()
        controller?.bringToFrontExpandPlayerButton()
        
        interactor?.getVideoParams()
        
        controller?.configureRangeSlider(splitValue,
                                         maximumValue: maximumValue)
       
        self.playerPresenter?.seekToTime(splitValue/maximumValue)
        controller?.setSliderValue(splitValue)

        interactor?.setUpComposition({composition in
                                        self.playerPresenter?.createVideoPlayer(composition)
        })
    }
    
    func viewWillDissappear() {
        if !isGoingToExpandPlayer{
            playerPresenter?.onVideoStops()
        }
        isFirstLoad = true
    }
    
    func pushAcceptHandler() {
        interactor?.setSplitVideosToProject(Double(splitValue))
        wireframe?.goPrevController()
        
        let project = Project.sharedInstance
        controller?.getTrackerObject().trackClipSplitted(project)
    }
    
    func pushCancelHandler() {
        wireframe?.goPrevController()
    }
    func pushBack() {
        wireframe?.goPrevController()
    }
    
    func setSplitValue(value:Float) {
        isMovingByPlayer = false
        self.splitValue = value
    }
    
    func updateSplitValueByPlayer(value: Float) {
        isMovingByPlayer = true
        self.splitValue = value * maximumValue
    }
    
    func expandPlayer() {
        wireframe?.presentExpandPlayer()
        
        isGoingToExpandPlayer = true
    }
    
    func updatePlayerLayer() {
        playerPresenter!.layoutSubViews()
    }
    
    //MARK: Interactor Delegate
    func settSplitValue(value: Float) {
        splitValue = value
    }
    
    func setMaximumValue(value: Float) {
        maximumValue = value
    }
}