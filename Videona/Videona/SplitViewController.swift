//
//  SplitViewController.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 4/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit
import NMRangeSlider

class SplitViewController: VideonaController,SplitViewInterface,SplitPresenterDelegate,PlayerViewDelegate {
    //MARK: - VIPER variables
    var eventHandler: SplitPresenterInterface?
    
    //MARK: - Outlet
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    
    @IBOutlet weak var splitYourClipLabel: UILabel!
    @IBOutlet weak var timeToCutLabel: UILabel!
    
    @IBOutlet weak var splitRangeSlider: NMRangeSlider!

    @IBOutlet weak var expandPlayerButton: UIButton!

    //MARK: - LifeCycle
    override func viewDidLoad() {
        eventHandler?.viewDidLoad()
    }
    
    override func viewWillDisappear(animated: Bool) {
        eventHandler?.viewWillDissappear()
    }
    
    //MARK: - Actions
    @IBAction func pushCancelButton(sender: AnyObject) {
        eventHandler?.pushCancelHandler()
    }
    
    @IBAction func pushAcceptButton(sender: AnyObject) {
        eventHandler?.pushAcceptHandler()
    }
    
    @IBAction func pushBackBarButton(sender: AnyObject) {
        eventHandler?.pushBack()
    }
    
    @IBAction func labelSliderChanged(sender: NMRangeSlider) {
        
        eventHandler?.setSplitValue(splitRangeSlider.upperValue)
    }
    
    @IBAction func labelSliderPushed(sender: NMRangeSlider) {
        
        eventHandler?.setSplitValue(splitRangeSlider.upperValue)
    }
    
    @IBAction func pushExpandButton(sender: AnyObject) {
        eventHandler?.expandPlayer()
    }
    
    //MARK: - Interface
    func configureRangeSlider(splitValue: Float,
                              maximumValue:Float) {
        
        self.configureUIRangeSlider()
        
        splitRangeSlider.maximumValue = maximumValue
        splitRangeSlider.minimumValue = 0.0
        
        splitRangeSlider.lowerHandleHidden = true
        splitRangeSlider.upperValue = splitValue
        
        Utils.sharedInstance.debugLog("maximum value\(splitRangeSlider.maximumValue) \n upper value\(splitRangeSlider.upperValue)")
    }
    
    func configureUIRangeSlider(){

        var trackBackgroundImage = UIImage(named: "button_edit_seekbar_background_split")
        trackBackgroundImage = trackBackgroundImage?.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 5.0, 0.0, 5.0))
        splitRangeSlider.trackBackgroundImage = trackBackgroundImage
        
        var handleImage = UIImage(named: "button_edit_thumb_seekbar_over_advance_split")
        handleImage = handleImage?.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 2, 0.0, 2))
        splitRangeSlider.upperHandleImageNormal = handleImage

        var handleImagePressed = UIImage(named: "button_edit_thumb_seekbar_advance_split_pressed")
        handleImage = handleImage?.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 2, 0.0, 2))
        splitRangeSlider.upperHandleImageHighlighted = handleImagePressed
        
    }
    
    func setSliderValue(value:Float){
        splitRangeSlider.upperValue = value
    }
    
    func bringToFrontExpandPlayerButton(){
        self.playerView.bringSubviewToFront(expandPlayerButton)
    }
    
    func cameFromFullScreenPlayer(playerView:PlayerView){
        self.playerView.addSubview(playerView)
        self.playerView.bringSubviewToFront(expandPlayerButton)
        eventHandler?.updatePlayerLayer()
    }
    
    //MARK: - Presenter delegate
    func setSplitValueText(text: String) {
        self.timeToCutLabel.text = text
    }
    
    //MARK: - Player view delegate
    func seekBarUpdate(value: Float) {
        eventHandler?.updateSplitValueByPlayer(value)
    }
}

//Force Portrait to iPad
extension SplitViewController{
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad
        {
            return UIInterfaceOrientationMask.Portrait
        }else{
            return UIInterfaceOrientationMask.All
        }
    }
}