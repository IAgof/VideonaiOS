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
    let overlayList = EffectProvider().getOverlayFilterList()
    let shaderList = EffectProvider().getShaderEffectList()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testOverlayResourcesAreOk(){
        for filter in overlayList{
            let overlay = filter as! OverlayEffect
            let resourceImage = UIImage(named: overlay.getResourceId())
            let iconImage = UIImage(named: overlay.getIconId())
            
            XCTAssertNotNil(iconImage)
            XCTAssertNotNil(resourceImage)
        }
    }
    
    func testShaderResourcesAreOk(){
        for filter in shaderList{
            let overlay = filter as! ShaderEffect
            let iconImage = UIImage(named: overlay.getIconId())
            
            XCTAssertNotNil(iconImage)
        }
    }
}
