//
//  SettingsInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 11/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsInterface {
    
    
    func setListTitleAndSubtitleData(titleList: Array<Array<Array<String>>>)
    func setSectionList(section: Array<String>)
    func registerClass()
    func reloadTableData()
    func createAlertExit()
    func setNavBarTitle(title:String)
}