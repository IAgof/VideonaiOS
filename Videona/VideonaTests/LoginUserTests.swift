//
//  LoginUserTests.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import XCTest
@testable import Videona

class LoginUserTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUserIsNotLoggedIn(){
        LoginUser().userIsLoggedIn({ isLoggedIn in
            XCTAssertEqual(isLoggedIn, false)
        } )
    }
    
    func testDeleteToken(){
        CachedToken().deleteToken()
        let hasToken = CachedToken().hasToken()
        XCTAssertFalse(hasToken)
    }
    
    func testTryToLoginWithNoRegisterUser(){
        //Expected error
        let user = "fakeUser"
        let password = "fakePassword"
        
        LoginUser().login(user, password: password, completion: {
        response in
            XCTAssertEqual(response, ResponseConstants.InvalidCredentials)
        })
    }
    
    func testWithValidCredentials(){
        //Expected get token
        let user = "jliarte@videona.com"
        let password = "qwerty"
        
        LoginInteractor().login(user, password: password)
        
        XCTAssertTrue(CachedToken().hasToken())
        XCTAssertNotNil(CachedToken().getToken())
    }
    
    
}
