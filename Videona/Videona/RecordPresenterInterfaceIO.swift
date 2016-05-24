//
//  RecordPresenterInterfaceIO.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 3/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

protocol RecordPresenterInput{
    
}

protocol RecordPresenterOutput{
    
}

protocol RecordPresenterInterface{
    func pushSettings()
    func pushShare()
    func pushShowHideColorFilters()
    func pushShowHideShaderFilters()
    func showWarningOrientationImage()
    func hideWarningOrientationImage()
    func pushRecord()
    func pushFlash()
    func pushRotateCamera()

}