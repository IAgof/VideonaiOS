//
//  FilterListInteractorTest.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 27/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import XCTest
@testable import Videona
class FilterListInteractorTest: XCTestCase {
    let filtersOverlay = FilterListInteractor().findColorFilters()
    let filtersShader = FilterListInteractor().findShaderFilters()
    
    override func setUp() {
        super.setUp()
        
    }
    
    func testGetOverlayFiltersIsNotEmpty(){
        XCTAssert(filtersOverlay.0.count != 0)
        XCTAssert(filtersOverlay.1.count != 0)
    }
    
    func testOverlayHaveBothTextAndImage(){
        for text in filtersOverlay.1{
            XCTAssertNotNil(text.isEmpty)
        }
        
        for image in filtersOverlay.0 {
            XCTAssertNotNil(image.images?.count != 0)
        }
    }
    
    func testGetShaderFiltersIsNotEmpty(){
        XCTAssert(filtersShader.0.count != 0)
        XCTAssert(filtersShader.1.count != 0)
    }
    
    func testShaderHaveBothTextAndImage(){
        for text in filtersShader.1{
            XCTAssertNotNil(text.isEmpty)
        }
        
        for image in filtersShader.0 {
            XCTAssertNotNil(image.images?.count != 0)
        }
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
