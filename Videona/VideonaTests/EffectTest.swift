//
//  EffectTest.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 26/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import XCTest
@testable import Videona

class EffectTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEffect() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let effect = Effect("id","name","iconPath","type")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
