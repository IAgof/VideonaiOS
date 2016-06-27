//
//  LoginInteractor.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class LoginInteractor: NSObject,LoginInteractorInterface {
    var outputToPresenter:LoginInteractorOutput?
    
    func login(user:String,
               password:String) {
        
        LoginUser().login(user,
                          password: password,
                          completion: {response in
                            
                            switch response {
                            case ResponseConstants.InvalidCredentials:
                                self.outputToPresenter?.invalidCredentials()
                                break
                            case ResponseConstants.Error:
                                self.outputToPresenter?.errorInLogin()
                                break
                            default:
                                Utils().debugLog("Login token correct")
                                CachedToken().setToken(Token(token: response))
                                self.outputToPresenter?.loginReceived()
                            }
        })
        
    }
}