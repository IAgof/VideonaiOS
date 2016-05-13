//
//  PlayerPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 13/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class PlayerPresenter:NSObject,PlayerPresenterInterface{
    
    var wireframe: PlayerWireframe?
    var controller: PlayerInterface?
    var playerDelegate: PlayerDelegate?
    var recordWireframe: RecordWireframe?
    
        
    func configureUserInterfaceForPresentation(addViewUserInterface: PlayerInterface) {
        
    }
}