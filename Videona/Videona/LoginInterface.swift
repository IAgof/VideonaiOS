//
//  LoginInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

protocol LoginInterface {
    
    func setEventHandler(eventhandler:LoginPresenterInterface)
    func getEventHandler() -> LoginPresenterInterface
    func getSelfController() -> UIViewController
    
    func hideWaitIndicator()

    func loginIndicatorStarts()
    func loginIndicatorStops()
    func createInvalidMailOrPasswordAlert(title:String,
                                          message:String,
                                          buttonText:String)
    
    func resetErrorFields()
    func passwordFieldRequire()
    func emailFieldRequire()
    func emailInvalid()
    func passwordInvalid()
    
    func configureTextFieldListeners()

}