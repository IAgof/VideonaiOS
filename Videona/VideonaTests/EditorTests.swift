//
//  EditorTests.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 24/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import XCTest
@testable import Videona
import AVFoundation

class EditorTests: XCTestCase {
    var videoList:[Video] = []
    
    override func setUp() {
        super.setUp()
        videoList = Project.sharedInstance.getVideoList()
        
        let video = Video(title: "titleEditor",
                          mediaPath: "pathEditor")
        video.setPosition(0)
        
        video.setStartTime(0.0)
        video.setStopTime(5)
        video.duration = 5
        
        AddVideoToProjectUseCase.sharedInstance.add(video, position: 0)
        AddVideoToProjectUseCase.sharedInstance.add(video.copy() as! Video, position: 1)
        AddVideoToProjectUseCase.sharedInstance.add(video.copy() as! Video, position: 2)
        AddVideoToProjectUseCase.sharedInstance.add(video.copy() as! Video, position: 3)
        AddVideoToProjectUseCase.sharedInstance.add(video.copy() as! Video, position: 4)
        AddVideoToProjectUseCase.sharedInstance.add(video.copy() as! Video, position: 5)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        let list = [Video]()
        
        Project.sharedInstance.setVideoList(list)
    }

    func testGetTimeForSelectedVideo() {
        let interactor = EditorInteractor()
        
        let time = interactor.getSeekTimePercentForSelectedVideo(2)
        let wantedPercent:Float = 10/30
        
        XCTAssertEqual(time, wantedPercent)
    }
    
    func testGetTimeForSelectedVideoAfterTrim() {
        //Triming video
        let trimInteractor = TrimInteractor()
        
        trimInteractor.setVideoPosition(0)
        
        let startTime:Float = 1.0
        let stopTime:Float = 3.0
        
        trimInteractor.setParametersOnVideoSelectedOnProjectList(startTime, stopTime: stopTime)
        
        //Editor
        let interactor = EditorInteractor()
        
        let time = interactor.getSeekTimePercentForSelectedVideo(2)
        
        // 5 videos of 5 seconds 1 video trimmed to 2 seconds = 27
        let timeOffSet:Float = 0.1

        var wantedPercent:Float = 7/27
        wantedPercent = ((round(100*wantedPercent)/100) + timeOffSet)
        
        XCTAssertEqual(time, wantedPercent)
    }
}
