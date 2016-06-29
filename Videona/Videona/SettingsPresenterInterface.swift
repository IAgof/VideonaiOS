//
//  SettingsPresenterInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 11/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

protocol SettingsPresenterInterface {
    
    func pushBack()
    func viewDidLoad()
    func itemListSelected(itemTitle:String,index:NSIndexPath)
    func getInputFromAlert(settingsTitle:String,input:String)
}