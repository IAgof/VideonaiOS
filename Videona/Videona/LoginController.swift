//
//  LoginController.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

class LoginController: VideonaController,LoginInterface,UITextFieldDelegate {
    
    //MARK: - VIPER
    var eventHandler: LoginPresenterInterface?

    //MARK: - Outlets
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var mailError: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var waitIndicatorView: UIActivityIndicatorView!
    
    //MARK: - Actions
    @IBAction func pushLoginButton(sender: AnyObject) {
        self.login()
    }
    
    func login(){
        let user = mailTextField.text
        let password = passwordTextField.text
        
        eventHandler?.pushLoginReceiver(user!, password: password!)
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        eventHandler?.viewDidLoadHandler()
    }
    
    //MARK: - Configure view
    func hideWaitIndicator(){
        waitIndicatorView.hidden = true
        waitIndicatorView.stopAnimating()
    }
    
    func configureTextFieldListeners(){
        mailError.adjustsFontSizeToFitWidth = true
        passwordError.adjustsFontSizeToFitWidth = true
        
        mailTextField.delegate = self
        passwordTextField.delegate = self
        
        mailTextField.addTarget(self,
                                action: #selector(self.checkEmail),
                                forControlEvents: UIControlEvents.EditingDidEnd)
        passwordTextField.addTarget(self,
                                action: #selector(self.checkPassword),
                                forControlEvents: UIControlEvents.EditingDidEnd)
        
        mailTextField.addTarget(self,
                                action: #selector(self.resetErrorEmail),
                                forControlEvents: UIControlEvents.EditingDidBegin)
        passwordTextField.addTarget(self,
                                    action: #selector(self.resetErrorPassword),
                                    forControlEvents: UIControlEvents.EditingDidBegin)
    }
    //MARK: - TextField delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        Utils().debugLog("Return or next keyboard key pussed")
        if textField.restorationIdentifier == "mailInput" {
            passwordTextField.becomeFirstResponder()
        }
        
        if textField.restorationIdentifier == "passwordInput" {
            passwordTextField.resignFirstResponder()
            login()
        }
        
        return true
    }
    

    //MARK: - Login view change
    func loginIndicatorStops() {
        waitIndicatorView.hidden = true
        waitIndicatorView.stopAnimating()
        
        setUserInteractionEnabled(true)
    }
    
    func loginIndicatorStarts() {
        waitIndicatorView.hidden = false
        waitIndicatorView.startAnimating()
        
        setUserInteractionEnabled(false)
    }
    
    func setUserInteractionEnabled(state:Bool){
        mailTextField.enabled = state
        passwordTextField.enabled = state
        loginButton.enabled = state
    }
    
    //MARK: - User interaction delegate
    func createInvalidMailOrPasswordAlert(title:String,
                                          message:String,
                                          buttonText:String){
        self.setUserInteractionEnabled(true)
        self.loginIndicatorStops()
        
        self.createAlertInformation(title,
                                    message: message,
                                    buttonText: buttonText)
    }
    
    //MARK: - Check change event textField
    
    func checkEmail(){
        eventHandler?.isEmailValidAndNotEmpty(mailTextField.text!)
    }
    
    func checkPassword(){
        eventHandler?.isPasswordValidAndNotEmpty(passwordTextField.text!)
    }
    
    //MARK: - Input errors
    func emailInvalid() {
        self.mailError.text = Utils().getStringByKeyFromLogin(LoginConstants.ERROR_INVALID_EMAIL)
    }
    
    func passwordInvalid() {
        self.passwordError.text = Utils().getStringByKeyFromLogin(LoginConstants.ERROR_INVALID_PASSWORD)
    }
    
    func emailFieldRequire() {
        self.mailError.text = Utils().getStringByKeyFromLogin(LoginConstants.ERROR_FIELD_REQUIRED)
    }
    
    func passwordFieldRequire() {
        self.passwordError.text = Utils().getStringByKeyFromLogin(LoginConstants.ERROR_FIELD_REQUIRED)
    }
    
    func resetErrorFields() {
        self.resetErrorEmail()
        self.resetErrorPassword()
    }
    
    func resetErrorPassword(){
        self.passwordError.text = ""
    }
    
    func resetErrorEmail(){
        self.mailError.text = ""
    }
    
    //MARK: - Setters and Getters
    func setEventHandler(eventhandler: LoginPresenterInterface) {
        self.eventHandler = eventhandler
    }
    
    func getEventHandler() -> LoginPresenterInterface {
        return self.eventHandler!
    }
    
    func getSelfController() -> UIViewController {
        return self
    }
}
