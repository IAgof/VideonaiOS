//
//  SettingsPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 11/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class SettingsPresenter:NSObject,SettingsPresenterInterface{
    
    var wireframe: SettingsWireframe?
    var controller: SettingsInterface?
    var recordWireframe: RecordWireframe?
    
    func pushBack() {
        print("Navigator presenter pushEdit")
        let recordViewController = recordWireframe?.RecordViewControllerFromStoryboard()
        
        controller?.navigateToNewViewController(recordViewController!)
    }
    
}