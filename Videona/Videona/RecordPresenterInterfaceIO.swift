//
//  RecordPresenterInterfaceIO.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 3/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import GPUImage

protocol RecordPresenterInput{
    
}

protocol RecordPresenterOutput{
    
}

protocol RecordPresenterInterface{
    func viewDidLoad(displayView:GPUImageView)
    func viewWillDisappear()
    func viewWillAppear()
    func pushSettings()
    func pushShare()
    func showWarningOrientationImage()
    func hideWarningOrientationImage()
    func pushRecord()
    func pushFlash()
    func pushRotateCamera()
    func resetRecorder()
    func displayHasTapped(tapGesture:UIGestureRecognizer)
    func displayHasPinched(pinchGesture:UIPinchGestureRecognizer)
    func changeOrientationEvent()
    func pushShowHideColorFilters()
    func pushShowHideShaderFilters()
    func hideAnyFilterList()
    func checkFlashAvaliable()
}