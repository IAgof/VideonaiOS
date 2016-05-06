//
//  NavigationPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 4/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class NavigationPresenter:NSObject,NavigationPresenterInterface{
    
    var wireframe: NavigationWireframe?
    var controller: NavigationInterface?
    var recordWireframe: RecordWireframe?
    
    func pushEdit() {
        print("Navigator presenter pushEdit")
        let recordViewController = recordWireframe?.RecordViewControllerFromStoryboard()
        
        controller?.navigateToNewViewController(recordViewController!)
    }
    
    func pushShare() {
        print("Navigator presenter pushShare")
        let recordViewController = recordWireframe?.RecordViewControllerFromStoryboard()
        
        controller?.navigateToNewViewController(recordViewController!)
    }
    
    func pushCancel() {
        print("Navigator presenter pushCancel")
        let recordViewController = recordWireframe?.RecordViewControllerFromStoryboard()
        
        controller?.navigateToNewViewController(recordViewController!)
    }
    
    func pushRecord() {
        print("Navigator presenter pushRecord")
        let recordViewController = recordWireframe?.RecordViewControllerFromStoryboard()
        
        controller?.navigateToNewViewController(recordViewController!)
    }
    
    func pushGame() {
        print("Navigator presenter pushGame")
        let recordViewController = recordWireframe?.RecordViewControllerFromStoryboard()
        
        controller?.navigateToNewViewController(recordViewController!)
    }
}