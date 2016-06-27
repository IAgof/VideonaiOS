//
//  LoginInteractorInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

protocol LoginInteractorInterface {
    func login(user:String,
               password:String)
}

protocol LoginInteractorOutput {
    func loginReceived()
    func invalidCredentials()
    func errorInLogin() 
}