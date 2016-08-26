//
//  TrimPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 1/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class TrimPresenter: NSObject,
    TrimPresenterInterface,
TrimInteractorDelegate {
    //MARK: - Variables VIPER
    var controller: TrimViewInterface?
    var delegate:TrimPresenterDelegate?
    var interactor: TrimInteractorInterface?
    var wireframe: TrimWireframe?
        
    var playerPresenter: PlayerPresenterInterface?
    var playerWireframe: PlayerWireframe?
    
    //MARK: - Variables
    var videoSelectedIndex:Int!{
        didSet{
            interactor?.setVideoPosition(videoSelectedIndex)
        }
    }
    var isGoingToExpandPlayer = false

    var lowerValueOld:Float! = -1.0
    var lowerValue:Float!{
        didSet{
            if lowerValue != nil {                
                let text = Utils.sharedInstance.hourToString(Double(lowerValue))
                delegate?.setMinRangeValue(text)
                if upperValue != nil{
                    updateRangeVal()
                    if lowerValue != lowerValueOld {
                        lowerValueOld = lowerValue
                        self.seekToTimeInPlayer(lowerValue)
                    }
                }
            }
        }
    }
    
    var upperValueOld:Float! = -1.0
    var upperValue:Float!{
        didSet{
            if  upperValue != nil {
                let text = Utils.sharedInstance.hourToString(Double(upperValue))
                delegate?.setMaxRangeValue(text)
                if  lowerValue != nil{
                    updateRangeVal()
                    if upperValue != upperValueOld {
                        upperValueOld = upperValue
                        self.seekToTimeInPlayer(upperValue)
                    }
                }
            }
        }
    }
    var maximumValue:Float!
    
    var rangeVal:Float! = 0.0{
        didSet{
            let text = Utils.sharedInstance.hourToString(Double(rangeVal))
            delegate?.setRangeValue(text)
        }
    }

    func updateRangeVal(){
        rangeVal = upperValue - lowerValue
    }
    
    func seekToTimeInPlayer(time:Float){
        if maximumValue != nil {
            self.playerPresenter?.seekToTime(time/maximumValue)
        }
    }
    
    func updateVideoParams(){
        interactor?.setParametersOnVideoSelected(lowerValue,
                                                 stopTime: upperValue)
        updatePlayer()
    }
    
    //MARK: - Interface
    func viewDidLoad() {
        wireframe?.presentPlayerInterface()
        controller?.bringToFrontExpandPlayerButton()

        interactor?.getVideoParams()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.controller?.configureRangeSlider(self.lowerValue,
                upperValue: self.upperValue,
                maximumValue: self.maximumValue )
        })
    }
    
    func viewWillDissappear() {
        if !isGoingToExpandPlayer{
            upperValue = nil
            lowerValue = nil
            
            playerPresenter?.onVideoStops()
        }
    }
    
    func pushAcceptHandler() {
        interactor?.setParametersOnVideoSelectedOnProjectList(lowerValue,
                                                              stopTime: upperValue)
        
        wireframe?.goPrevController()
        
        let project = Project.sharedInstance
        controller?.getTrackerObject().trackClipTrimmed(project)
    }
    
    func pushCancelHandler() {
        wireframe?.goPrevController()
    }
    
    func pushBack() {
        wireframe?.goPrevController()
    }
    
    //MARK: - interactor delegate
    func setLowerValue(value: Float) {
        self.lowerValue = value
    }
    
    func setUpperValue(value: Float) {
        self.upperValue = value
    }
    
    func setMaximumValue(value: Float) {
        self.maximumValue = value
    }
    
    func updateParamsFinished() {
        updateVideoParams()
    }
    
    func expandPlayer() {
        wireframe?.presentExpandPlayer()
        
        isGoingToExpandPlayer = true
    }
    
    func updatePlayerLayer() {
        playerPresenter!.layoutSubViews()
    }
    
    func trimSliderEnded() {
        updateVideoParams()
    }
    
    func trimSliderBegan() {
        interactor?.setParametersOnVideoSelected(0,
                                                 stopTime: maximumValue)
        updatePlayer()
    }
    
    //MARK: - Inner functions
    func updatePlayer(){
        interactor?.setUpComposition({composition in
            
            self.playerPresenter?.createVideoPlayer(composition)
        })
    }
}