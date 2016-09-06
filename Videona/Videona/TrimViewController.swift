//
//  TrimViewController.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 1/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit
import NMRangeSlider

class TrimViewController: VideonaController,TrimViewInterface,TrimPresenterDelegate {
    //MARK: - VIPER variables
    var eventHandler: TrimPresenterInterface?
    
    //MARK: - Outlet
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var trimRangeSlider: NMRangeSlider!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    
    @IBOutlet weak var minRangeLabel: UILabel!
    @IBOutlet weak var maxRangeLabel: UILabel!
    @IBOutlet weak var rangeLabel: UILabel!

    @IBOutlet weak var trimTitleLabel:   UILabel!
    @IBOutlet weak var expandPlayerButton: UIButton!

    //MARK: - LifeCycle
    override func viewDidLoad() {
        eventHandler?.viewDidLoad()
        
        trimRangeSlider.addTarget(self, action: #selector(TrimViewController.sliderBeganTracking),
                             forControlEvents: UIControlEvents.TouchDown)
        trimRangeSlider.addTarget(self, action: #selector(TrimViewController.sliderEndedTracking),
                                  forControlEvents: UIControlEvents.TouchUpInside)
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
    
    @IBAction func labelSliderChanged(sender: NMRangeSlider) {
        eventHandler?.setLowerValue(trimRangeSlider.lowerValue)
        eventHandler?.setUpperValue(trimRangeSlider.upperValue)
    }
    
    @IBAction func pushBackBarButton(sender: AnyObject) {
        eventHandler?.pushBack()
    }
   
    @IBAction func pushExpandButton(sender: AnyObject) {
        eventHandler?.expandPlayer()
    }
    
    //MARK: - Interface
    func configureRangeSlider(lowerValue: Float,
                              upperValue: Float,
                              maximumValue:Float) {
        trimRangeSlider.maximumValue = maximumValue
        trimRangeSlider.minimumValue = 0.0
        
        
        trimRangeSlider.upperValue = upperValue
        trimRangeSlider.lowerValue = lowerValue
        
        self.configureUIRangeSlider()

//        Utils.sharedInstance.debugLog("maximum value\(trimRangeSlider.maximumValue) \n upper value\(trimRangeSlider.upperValue) \n Value to set upper\(upperValue)")
//        Utils.sharedInstance.debugLog("minimum value\(trimRangeSlider.minimumValue) \nlower value\(trimRangeSlider.lowerValue) \n Value to set lower\(upperValue)")
    }
    
    func configureUIRangeSlider(){
        
        let trackImage = UIImage(named: "button_edit_thumb_seekbar_trim_normal")
        trimRangeSlider.trackImage = trackImage
        
        let handleImage = UIImage(named: "button_edit_thumb_seekbar_trim_pressed")
        trimRangeSlider.lowerHandleImageNormal = handleImage
        trimRangeSlider.upperHandleImageNormal = handleImage
        
        trimRangeSlider.lowerHandleImageHighlighted = handleImage
        trimRangeSlider.upperHandleImageHighlighted = handleImage
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
    func setMaxRangeValue(text: String) {
        self.maxRangeLabel.text = text
    }
    func setMinRangeValue(text: String) {
        self.minRangeLabel.text = text
    }
    func setRangeValue(text: String) {
        self.rangeLabel.text = text
    }
    
    func setTitleTrimLabel(text:String){
        self.trimTitleLabel.text = text
    }
    
    //MARK: Inner functions
    func sliderBeganTracking(){
        eventHandler?.trimSliderBegan()
    }
    func sliderEndedTracking(){
        eventHandler?.trimSliderEnded()
    }
}

//Force Portrait to iPad
extension TrimViewController{
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad
        {
            return UIInterfaceOrientationMask.Portrait
        }else{
            return UIInterfaceOrientationMask.All
        }
    }
}