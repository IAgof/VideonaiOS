//
//  SplitVideoTests.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 8/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import XCTest
@testable import Videona

class SplitVideoTests: XCTestCase {
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
    
    func setSpitVideo(splitTime:Double,
                      videoPosition:Int){
        let interactor = SplitInteractor()
        
        interactor.setVideoPosition(videoPosition)
        
        interactor.setSplitVideosToProject(splitTime)
    }
    
    func testSplitTiming(){
        let splitTime = 2.0
        setSpitVideo(splitTime,videoPosition: 0)
        
        XCTAssert(Project.sharedInstance.getVideoList().count == 2, "Add video correct")
        
        let videoInit = Project.sharedInstance.getVideoList()[0]
        let videoEnd = Project.sharedInstance.getVideoList()[1]
        
        XCTAssertEqual(videoInit.getStartTime(), 0.0)
        XCTAssertEqual(videoInit.getStopTime(),splitTime)
        
        XCTAssertEqual(videoEnd.getStartTime(), splitTime)
        XCTAssertNotEqual(videoEnd.getStopTime(),splitTime)
    }
    
    func testSplitVideoWhenIsSplitted(){
        let splitTimeFirst = 2.0
        setSpitVideo(splitTimeFirst,
                     videoPosition: 0)
        
        let splitTimeSecond = 3.0
        setSpitVideo(splitTimeSecond,
                     videoPosition: 1)
        
        let list = Project.sharedInstance.getVideoList()
        
        for video in list{
            XCTAssertTrue(video.getIsSplit(), "Video is split")
        }
        
        let videoList = Project.sharedInstance.getVideoList()
        
        let videoTwo = videoList[1]
        let videoThree = videoList[2]
        
        XCTAssertEqual(videoTwo.getStartTime(), splitTimeFirst)
        XCTAssertEqual(videoTwo.getStopTime(),splitTimeSecond)
        
        XCTAssertEqual(videoThree.getStartTime(), splitTimeSecond)
        XCTAssertNotEqual(videoThree.getStopTime(),splitTimeFirst)
    }
}
