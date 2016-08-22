//
//  TrimPresenterInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 1/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

protocol TrimPresenterInterface {
    func viewDidLoad()
    func viewWillDissappear()
    func pushCancelHandler()
    func pushAcceptHandler()
    func pushBack()
    
    func setLowerValue(value:Float)
    func setUpperValue(value:Float)
    func expandPlayer()
    func updatePlayerLayer()
}

protocol TrimPresenterDelegate {
    func setMinRangeValue(text:String)
    func setMaxRangeValue(text:String)
    func setRangeValue(text:String)
    func setTitleTrimLabel(text:String)
}