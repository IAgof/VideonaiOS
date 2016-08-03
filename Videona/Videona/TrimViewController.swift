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
    
    @IBAction func labelSliderChanged(sender: NMRangeSlider) {
        
        eventHandler?.setLowerValue(trimRangeSlider.lowerValue)
        eventHandler?.setUpperValue(trimRangeSlider.upperValue)
    }
    @IBAction func pushBackBarButton(sender: AnyObject) {
        eventHandler?.pushBack()
    }
    
    //MARK: - Interface
    func configureRangeSlider(lowerValue: Float,
                              upperValue: Float,
                              maximumValue:Float) {
        
        self.configureUIRangeSlider()
        
        trimRangeSlider.maximumValue = maximumValue
        trimRangeSlider.minimumValue = 0.0
        
        trimRangeSlider.lowerValue = lowerValue
        trimRangeSlider.upperValue = upperValue
        
        Utils.sharedInstance.debugLog("maximum value\(trimRangeSlider.maximumValue) \n upper value\(trimRangeSlider.upperValue)")
        Utils.sharedInstance.debugLog("maximum value\(trimRangeSlider.minimumValue) \nlower value\(trimRangeSlider.lowerValue)")
    }
    
    func configureUIRangeSlider(){
        let trackBackground = UIImage(named: "button_edit_thumb_seekbar_over_advance_split")
        trimRangeSlider.trackBackgroundImage = trackBackground
        
        let trackImage = UIImage(named: "button_edit_thumb_seekbar_trim_normal")
        trimRangeSlider.trackImage = trackImage
        
        let handleImage = UIImage(named: "button_edit_thumb_seekbar_trim_pressed")
        trimRangeSlider.lowerHandleImageNormal = handleImage
        trimRangeSlider.upperHandleImageNormal = handleImage
        
        trimRangeSlider.lowerHandleImageHighlighted = handleImage
        trimRangeSlider.upperHandleImageHighlighted = handleImage
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
}
