//
//  AppDependencies.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 3/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

class AppDependencies {
    
    var recordWireframe = RecordWireframe()
    var introWireframe = IntroWireframe()
    var navigatorWireframe = NavigationWireframe()
    var settingsWireframe = SettingsWireframe()
    var shareWireframe = ShareWireframe()
    
    init(){
        configureDependencies()
    }
    func configureDependencies(){
        let rootWireframe = RootWireframe()
        let introPresenter = IntroPresenter()
        let recordPresenter = RecordPresenter()
        let navigatorPresenter = NavigationPresenter()
        let settingsPresenter = SettingsPresenter()
        let sharePresenter = SharePresenter()
        
        //INTRO MODULE
        introPresenter.introWireframe = introWireframe
        introPresenter.recordWireframe = recordWireframe
        
        introWireframe.rootWireframe = rootWireframe
        introWireframe.introPresenter = introPresenter

        //RECORD MODULE
        recordPresenter.recordWireframe = recordWireframe
        recordPresenter.settingsWireframe = settingsWireframe
        recordPresenter.shareWireframe = shareWireframe
        
        recordWireframe.recordPresenter = recordPresenter
        recordWireframe.rootWireframe = rootWireframe
        
        //NAVIGATOR MODULE
        navigatorPresenter.wireframe = navigatorWireframe
        navigatorPresenter.recordWireframe = recordWireframe
        
        navigatorWireframe.navigationPresenter = navigatorPresenter
        navigatorWireframe.rootWireframe = rootWireframe
        
        //SETTINGS MODULE
        settingsPresenter.wireframe = settingsWireframe
        settingsPresenter.recordWireframe = recordWireframe
        
        settingsWireframe.settingsPresenter = settingsPresenter
        settingsWireframe.rootWireframe = rootWireframe
        
        //SHARE MODULE
        sharePresenter.wireframe = shareWireframe
        sharePresenter.recordWireframe = recordWireframe
        
        shareWireframe.sharePresenter = sharePresenter
        shareWireframe.rootWireframe = rootWireframe
    }
    
    func installIntroToRootViewControllerIntoWindow(window: UIWindow){
        introWireframe.presentIntroInterfaceFromWindow(window)
    }
    
    func installRecordToRootViewControllerIntoWindow(window: UIWindow){
        recordWireframe.presentRecordInterfaceFromWindow(window)
    }
}