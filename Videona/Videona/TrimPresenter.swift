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
    
    var lowerValue:Float!{
        didSet{
            if lowerValue != nil {
                delegate?.setMinRangeValue(String.init(format: "%.02f", lowerValue))
                if upperValue != nil{
                    updateVideoParams()
                    updateRangeVal()
                }
            }
        }
    }
    
    var upperValue:Float!{
        didSet{
            if  upperValue != nil {
                delegate?.setMaxRangeValue(String.init(format: "%.02f", upperValue))
                if  lowerValue != nil{
                    updateVideoParams()
                    updateRangeVal()
                }
            }
        }
    }
    var maximumValue:Float!
    
    var rangeVal:Float! = 0.0{
        didSet{
            delegate?.setRangeValue(String.init(format: "%.02f", rangeVal))
        }
    }

    func updateRangeVal(){
        rangeVal = upperValue - lowerValue
    }
    
    func updateVideoParams(){
        interactor?.setParametersOnVideoSelected(lowerValue,
                                                 stopTime: upperValue)
        updatePlayer()
    }
    
    //MARK: - Interface
    func viewDidLoad() {
        wireframe?.presentPlayerInterface()

        interactor?.getVideoParams()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.controller?.configureRangeSlider(self.lowerValue,
                upperValue: self.upperValue,
                maximumValue: self.maximumValue )
        })
        
        updatePlayer()
    }
    
    func viewWillDissappear() {
        upperValue = nil
        lowerValue = nil
        
        playerPresenter?.onVideoStops()
    }
    
    func pushAcceptHandler() {
        interactor?.setParametersOnVideoSelectedOnProjectList(lowerValue,
                                                              stopTime: upperValue)
        
        wireframe?.goPrevController()
    }
    
    func pushCancelHandler() {
        wireframe?.goPrevController()
    }
    func pushBack() {
        wireframe?.goPrevController()
    }
    
    func setLowerValue(value: Float) {
        self.lowerValue = value
    }
    
    func setUpperValue(value: Float) {
        self.upperValue = value
    }
    
    func setMaximumValue(value: Float) {
        self.maximumValue = value
    }
    
    //MARK: - Inner functions
    func updatePlayer(){
        interactor?.setUpComposition(videoSelectedIndex!    ,
                                     completion: {composition in
                                        self.playerPresenter?.createVideoPlayer(composition)
        })
    }
}