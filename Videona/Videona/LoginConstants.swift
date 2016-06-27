//
//  ResponseConstants.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 24/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

struct ResponseConstants {
    static let InvalidCredentials = "Invalid credentials"
    static let Error = "Error"
    
}

struct LoginConstants {
    static let ICTitleFromStrings = "invalidCredentialsTitle"
    static let ICMessageFromStrings = "invalidCredentialsMessage"
    static let ICButtonTextFromStrings = "invalidCredentialsButtonText"
    
    static let LoginErrorTitleFromStrings = "errorLoginTitle"
    static let LoginErrorMessageFromStrings = "errorLoginMessage"
    static let LoginErrorButtonFromStrings = "errorLoginButtonText"
    
    static let LoginTokenSaved = "AUTH_TOKEN"
    static let HasTokenSaved = "HAS_TOKEN"
    
    static let  PROMPT_EMAIL = "prompt_email"
    static let  PROMPT_PASSWORD = "prompt_password"
    static let  ACTION_SIGN_IN = "action_sign_in"
    static let  ACTION_SIGN_IN_SHORT = "action_sign_in_short"
    static let  ERROR_INVALID_EMAIL = "error_invalid_email"
    static let  ERROR_INVALID_PASSWORD = "error_invalid_password"
    static let  ERROR_INCORRECT_PASSWORD = "error_incorrect_password"
    static let  ERROR_FIELD_REQUIRED = "error_field_required"
}