//
//  LoginPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class LoginPresenter: NSObject,LoginPresenterInterface,LoginInteractorOutput {
    var wireframe : LoginWireframe?
    var controller : LoginInterface?
    var interactor : LoginInteractorInterface?
    
    
    
    //MARK: - Events Receiver
    func pushLoginReceiver(user:String,
                           password:String){
        
        controller?.loginIndicatorStarts()
        
        interactor?.login(user, password: password)
    }
    
    func viewDidLoadHandler() {
        controller?.hideWaitIndicator()
        controller?.configureTextFieldListeners()
        controller?.resetErrorFields()
    }
    
    //MARK: - LoginInteractor Output
    func loginReceived() {
        //Make something in controller or wireframe or something
        controller?.loginIndicatorStops()
        controller?.configureTextFieldListeners()
    }
    
    func invalidCredentials() {
        let title = Utils().getStringByKeyFromLogin(LoginConstants.ICTitleFromStrings)
        let message = Utils().getStringByKeyFromLogin(LoginConstants.ICMessageFromStrings)
        let buttonText = Utils().getStringByKeyFromLogin(LoginConstants.ICButtonTextFromStrings)
        
        controller?.createInvalidMailOrPasswordAlert(title, message: message, buttonText: buttonText)
    }
    
    func errorInLogin() {
        let title = Utils().getStringByKeyFromLogin(LoginConstants.LoginErrorTitleFromStrings)
        let message = Utils().getStringByKeyFromLogin(LoginConstants.LoginErrorMessageFromStrings)
        let buttonText = Utils().getStringByKeyFromLogin(LoginConstants.LoginErrorButtonFromStrings)
        
        controller?.createInvalidMailOrPasswordAlert(title, message: message, buttonText: buttonText)
    }
    
    //MARK: - Valid input parameters
    func isEmailValidAndNotEmpty(email:String) -> Bool {
        if (isEmptyField(email)) {
            controller?.emailFieldRequire()
            return false
        }
        if (!isEmailValid(email)) {
            controller?.emailInvalid()
            return false
        }
        return true
    }
    
    func isPasswordValidAndNotEmpty(password:String)->Bool {
        if (isEmptyField(password)) {
            controller?.passwordFieldRequire()
            return false
        }
        if (!isPasswordValid(password)) {
            controller?.passwordInvalid()
            return false
        }
        return true
    }
    
    func isEmptyField(field:String) ->Bool{
        return field.isEmpty
    }
    
    func isEmailValid(email:String)->Bool {
        return Utils().isValidEmail(email)
    }
    
    func isPasswordValid(password:String) ->Bool{
        // TODO:(alvaro.martinez) 15/06/16 will there be a rule for passwords?
        return password.characters.count > 4
    }
    
    //MARK: - Setters
    func setLoginWireframe(wireframe: LoginWireframe) {
        self.wireframe = wireframe
    }
    
    func setLoginInterface(controller: LoginInterface) {
        self.controller = controller
    }
    
    func setLoginInteractorInterface(interactor:LoginInteractorInterface){
        self.interactor = interactor
    }
    
    //MARK: - Getters
    func getLoginWireframe() -> LoginWireframe {
        return self.wireframe!
    }
    
    func getLoginInterface() -> LoginInterface {
        return self.controller!
    }
    
    func getLoginInteractorInterface() -> LoginInteractorInterface {
        return self.interactor!
    }
    
}