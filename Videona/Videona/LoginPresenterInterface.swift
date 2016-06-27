//
//  LoginPresenterInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

protocol LoginPresenterInterface {
    func viewDidLoadHandler()
    
    func pushLoginReceiver(user:String,
                           password:String)
    
    func setLoginWireframe(wireframe:LoginWireframe)
    func setLoginInterface(controller:LoginInterface)
    func setLoginInteractorInterface(interactor:LoginInteractorInterface)
    
    func getLoginWireframe() -> LoginWireframe
    func getLoginInterface() -> LoginInterface
    func getLoginInteractorInterface() -> LoginInteractorInterface
    
    func isEmailValidAndNotEmpty(email:String) -> Bool
    func isPasswordValidAndNotEmpty(password:String)->Bool 
}

protocol LoginPresenterOutput {
    
}