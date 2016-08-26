//
//  UserEventTrackerTest.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 24/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import XCTest
@testable import Videona

class UserEventTrackerTest: XCTestCase {
    let tracker = VideonaTracker()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

//    func testUserInteracted() {
//        tracker.sendUserInteractedTracking("ActivityTest",
//                                           recording: false,
//                                           interaction: "test Interaction",
//                                           result: "test result")
//    }
//    
//    func testFilterSelected(){
//        tracker.sendFilterSelectedTracking("test filter",
//                                           code: "test code",
//                                           recording: true)
//    }
//    
//    func testMailTraits(){
//        let defaults = NSUserDefaults.standardUserDefaults()
//        let email = "test mail"
//        
//        defaults.setObject(email, forKey: SettingsConstants().SETTINGS_MAIL)
//
//        tracker.trackMailTraits()
//    }
    

}
