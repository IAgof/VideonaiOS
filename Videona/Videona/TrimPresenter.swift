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
            delegate?.setMinRangeValue("\(lowerValue)")
            if upperValue != nil{
                updateVideoParams()
                updateRangeVal()
            }
        }
    }
    var upperValue:Float!{
        didSet{
            delegate?.setMaxRangeValue("\(upperValue)")
            if lowerValue != nil{
                updateVideoParams()
                updateRangeVal()
            }
        }
    }
    
    var rangeVal:Float! = 0.0{
        didSet{
            delegate?.setRangeValue("\(rangeVal)")
        }
    }

    func updateRangeVal(){
        rangeVal = upperValue - lowerValue
    }
    
    func updateVideoParams(){
        interactor?.setParametersOnVideoSelectedOnProjectList(lowerValue,
                                                              stopTime: upperValue)
        updatePlayer()
    }
    
    //MARK: - Interface
    func viewDidLoad() {
        wireframe?.presentPlayerInterface()

        interactor?.getVideoParams()
        
        controller?.configureRangeSlider(lowerValue,
                                         upperValue: upperValue)
        updatePlayer()
    }
    
    func viewWillDissappear() {
        
    }
    
    func pushAcceptHandler() {
        
    }
    
    func pushCancelHandler() {
        
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
    
    //MARK: - Inner functions
    func updatePlayer(){
        interactor?.setUpComposition(videoSelectedIndex!    ,
                                     completion: {composition in
                                        self.playerPresenter?.createVideoPlayer(composition)
        })
    }
}