//
//  DetailTextInteractorTest.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 27/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import XCTest
@testable import Videona

class DetailTextInteractorTest : XCTestCase {
    
    func testAboutUsTextNotEmpty() {
        let searchKeyText = SettingsConstants().ABOUT_US_CONTENT
        let content = DetailTextInteractor().getTextFromInternalMemory(searchKeyText)
        XCTAssertNotEqual(content, searchKeyText)
    }
    
    func testLicensesTextNotEmpty() {
        let searchKeyText = SettingsConstants().LICENSES_CONTENT
        let content = DetailTextInteractor().getTextFromInternalMemory(searchKeyText)
        XCTAssertNotEqual(content, searchKeyText)
    }
    
    func testLegalAdviceTextNotEmpty() {
        let searchKeyText = SettingsConstants().LEGAL_ADVICE_CONTENT
        let content = DetailTextInteractor().getTextFromInternalMemory(searchKeyText)
        XCTAssertNotEqual(content, searchKeyText)
    }
    
    func testPrivacyPolicyTextNotEmpty() {
        let searchKeyText = SettingsConstants().PRIVACY_POLICY_CONTENT
        let content = DetailTextInteractor().getTextFromInternalMemory(searchKeyText)
        XCTAssertNotEqual(content, searchKeyText)
    }
    
    func testTermsOfServiceTextNotEmpty() {
        let searchKeyText = SettingsConstants().TERMS_OF_SERVICE_CONTENT
        let content = DetailTextInteractor().getTextFromInternalMemory(searchKeyText)
        XCTAssertNotEqual(content, searchKeyText)
    }
}
