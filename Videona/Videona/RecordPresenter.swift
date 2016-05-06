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
    var navigatorWireframe: NavigationWireframe?
    
    func pushSettings() {
        print("Record presenter pushSettings")
        let navigatorViewController = navigatorWireframe?.NavigationViewControllerFromStoryboard()
        
        output?.navigateToNewViewController(navigatorViewController!)
    }
}