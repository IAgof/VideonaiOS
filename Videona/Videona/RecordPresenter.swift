//
//  RecordPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 3/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class RecordPresenter: NSObject, RecordPresenterInterface{
    
    //MARK: - Variables VIPER
    var output: RecordViewInterface?
    var recordWireframe: RecordWireframe?
    var settingsWireframe: SettingsWireframe?
    var shareWireframe: ShareWireframe?
    
    //    var navigatorWireframe: NavigationWireframe?

    
    func pushSettings() {
        print("Record presenter pushSettings")
        let navigatorViewController = settingsWireframe?.settingsViewControllerFromStoryboard()
        
        output?.navigateToNewViewController(navigatorViewController!)
    }
    
    func pushShare() {
        print("Record presenter pushShare")
        let navigatorViewController = shareWireframe?.shareViewControllerFromStoryboard()
        
        output?.navigateToNewViewController(navigatorViewController!)
    }
}