//
//  GetFromPhotosToDocumentsWithWatermark.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 22/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import XCTest
import AVFoundation

@testable import Videona

class GetFromPhotosToDocumentsWithWatermark: XCTestCase {
    let interactor = EditorInteractor()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExport() {
        let asset = AVAsset(URL: NSURL(fileURLWithPath:"file:///private/var/mobile/Containers/Data/Application/CFBA32F9-68D6-49EA-B113-BAB48088E180/tmp/trim.C6DB2E91-313A-4405-847A-29F44BF92AF9.MOV"))
        
        interactor.addWatermark(video: asset, watermarkText: nil, imageName: "water_mark", saveToLibrary: true, watermarkPosition: .TopLeft, completion: {
            status,session,path in
            
            print("status = \(status)")
            print("session = \(session)")
            print("path = \(path)")
            print("Finished = ")
        })
    }
}
