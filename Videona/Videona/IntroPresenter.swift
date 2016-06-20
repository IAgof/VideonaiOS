//
//  IntroPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 4/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

class IntroPresenter:NSObject, IntroPresenterInterface {
    
    //MARK: - VIPER
    var introWireframe: IntroWireframe?
    var controller: IntroViewController?
    var recordWireframe: RecordWireframe?
    
    //MARK: - Constants
    //Change to string file
    let nextTitle = Utils().getStringByKeyFromIntro(IntroTextConstants().NEXT)
    let doneTitle = Utils().getStringByKeyFromIntro(IntroTextConstants().FINISH)
    let skipTitle = Utils().getStringByKeyFromIntro(IntroTextConstants().SKIP)
    
    //MARK: - Interface
    func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(IntroPresenter.checkOrientation), name: UIDeviceOrientationDidChangeNotification, object: nil)

        controller?.setUpView()
        controller?.changeNextFinishButtonTitle(nextTitle)
        controller?.changeSkipButtonTittle(skipTitle)
    }
    
    func checkOrientation(){
        controller?.pageViewController.view.setNeedsUpdateConstraints()
    }
    
    func pushNext(buttonTitle:String) {
        print("Intro presenter onNextPush")
        
        if buttonTitle == nextTitle{
            controller?.goToNextView()
        }else{
            self.pushSkip()
        }
    }
    
    func onPageChange(numPage: Int, size: Int){
        if numPage == (size - 2) {
            controller?.changeNextFinishButtonTitle(nextTitle)
        }else if numPage == (size - 1) {//done
            controller?.changeNextFinishButtonTitle(doneTitle)
        }
        print("IntroPresenter on page change currentPage \(numPage)")
        controller?.updateCurrentPage(numPage)
    }
    
    func pushSkip(){
        print("Intro presenter onSkipPush")
       recordWireframe?.setRecordViewControllerAsRootController()
    }
    
}