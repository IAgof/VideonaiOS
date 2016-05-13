//
//  RecordWireframe.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 3/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

let RecordViewControllerIdentifier = "RecordViewController"

class RecordWireframe : NSObject {
    var rootWireframe : RootWireframe?
    var recordViewController : RecordController?
    var recordPresenter : RecordPresenter?
    var filterListWireframe: FilterListWireframe?
    
    func presentRecordInterfaceFromWindow(window: UIWindow) {
        let viewController = RecordViewControllerFromStoryboard()
        
        viewController.eventHandler = recordPresenter
        recordViewController = viewController
        recordPresenter?.output = viewController
        
        rootWireframe?.showRootViewController(viewController, inWindow: window)
    }
    
    func RecordViewControllerFromStoryboard() -> RecordController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewControllerWithIdentifier(RecordViewControllerIdentifier) as! RecordController
        
        viewController.eventHandler = recordPresenter
        recordViewController = viewController
        recordPresenter?.output = viewController
        
        return viewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyboard
    }
    
    func presentColorFilterListInterface() {
        filterListWireframe?.presentColorFilterListInterfaceFromViewController(recordViewController!)
    }
    func presentShaderFilterListInterface() {
        filterListWireframe?.presentShaderFilterListInterfaceFromViewController(recordViewController!)
    }
    
    func dismissFilterListInterface() {
        filterListWireframe?.dismissFilterListInterface({ finished in
            print("Record Wireframe dismissFilterListInterface")
        })
    }
}