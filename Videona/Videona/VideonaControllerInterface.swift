//
//  VideonaControllerInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 28/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

protocol VideonaControllerInterface {
    func viewDidLoad()
    func viewWillAppear(animated: Bool) 
    func viewWillDisappear(animated: Bool)
    func getControllerName()->String
    func getTrackerObject() -> VideonaTracker
    func getController() -> UIViewController
}