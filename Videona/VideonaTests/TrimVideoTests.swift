//
//  TrimVideoTests.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 8/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import XCTest
@testable import Videona

class TrimVideoTests: XCTestCase {

    var videoList:[Video] = []
    
    override func setUp() {
        super.setUp()
        videoList = Project.sharedInstance.getVideoList()
        
        let video = Video(title: "titleSplit",
                          mediaPath: "pathSplit")
        video.setPosition(0)
        
        video.setStartTime(0.0)
        video.setStopTime(5)
        
        AddVideoToProjectUseCase.sharedInstance.add(video, position: 0)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        let list = [Video]()
        
        Project.sharedInstance.setVideoList(list)
    }

    func testTrimVideo(){
        let interactor = TrimInteractor()
        
        interactor.setVideoPosition(0)
        
        let startTime:Float = 1.0
        let stopTime:Float = 3.0
        
        interactor.setParametersOnVideoSelectedOnProjectList(startTime, stopTime: stopTime)
        
        let videoList = Project.sharedInstance.getVideoList()
        
        let video = videoList[0]
        
        XCTAssertEqual(video.getStartTime(), Double(startTime))
        XCTAssertEqual(video.getStopTime(), Double(stopTime))
    }
}
