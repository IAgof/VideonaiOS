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
    let nextTitle = "Next"
    let doneTitle = "Done"
    
    //MARK: - Interface
    
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
        
        controller?.updateCurrentPage(numPage)
        print("IntroPresenter currentPage \(numPage)")
    }
    
    func pushSkip(){
        print("Intro presenter onSkipPush")
       recordWireframe?.presentRecordInterfaceFromViewController(controller!)
    }
    
}