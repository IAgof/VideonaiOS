//
//  SharePresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 11/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class SharePresenter:NSObject,SharePresenterInterface{
    
    var wireframe: ShareWireframe?
    var controller: ShareInterface?
    var recordWireframe: RecordWireframe?
    
    func pushBack() {
        print("Navigator presenter pushEdit")
        let recordViewController = recordWireframe?.RecordViewControllerFromStoryboard()
        
        controller?.navigateToNewViewController(recordViewController!)
    }
    
}