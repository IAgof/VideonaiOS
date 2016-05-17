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
    var filterListWireframe = FilterListWireframe()
    var playerWireframe = PlayerWireframe()
    
    init(){
        configureDependencies()
    }
    func configureDependencies(){
        let rootWireframe = RootWireframe()
        let introPresenter = IntroPresenter()
        let recordPresenter = RecordPresenter()
        let navigatorPresenter = NavigationPresenter()
    
        let settingsPresenter = SettingsPresenter()
        let settingsInteractor = SettingsInteractor()
        
        let sharePresenter = SharePresenter()
        let shareInteractor = ShareInteractor()
       
        let filterListPresenter = FilterListPresenter()
        let filterListInteractor = FilterListInteractor()
       
        let playerPresenter = PlayerPresenter()
        let playerInteractor = PlayerInteractor()
        
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
        recordWireframe.filterListWireframe = filterListWireframe
        
        //NAVIGATOR MODULE
        navigatorPresenter.wireframe = navigatorWireframe
        navigatorPresenter.recordWireframe = recordWireframe
        
        navigatorWireframe.navigationPresenter = navigatorPresenter
        navigatorWireframe.rootWireframe = rootWireframe
        
        //SETTINGS MODULE
        settingsPresenter.wireframe = settingsWireframe
        settingsPresenter.recordWireframe = recordWireframe
        settingsPresenter.interactor = settingsInteractor
            
        settingsWireframe.settingsPresenter = settingsPresenter
        settingsWireframe.rootWireframe = rootWireframe
        
        //SHARE MODULE
        sharePresenter.wireframe = shareWireframe
        sharePresenter.recordWireframe = recordWireframe
        sharePresenter.interactor = shareInteractor
        sharePresenter.playerPresenter = playerPresenter
        
        shareWireframe.sharePresenter = sharePresenter
        shareWireframe.rootWireframe = rootWireframe
        shareWireframe.playerWireframe = playerWireframe
        
        //FILTER LIST MODULE
        filterListPresenter.wireframe = filterListWireframe
        filterListPresenter.recordWireframe = recordWireframe
        filterListPresenter.interactor = filterListInteractor
        
        filterListWireframe.filterListPresenter = filterListPresenter
        filterListWireframe.rootWireframe = rootWireframe
        
        //PLAYER MODULE
        playerPresenter.wireframe = playerWireframe
        playerPresenter.recordWireframe = recordWireframe
        playerPresenter.playerInteractor = playerInteractor
            
        playerWireframe.playerPresenter = playerPresenter
        playerWireframe.rootWireframe = rootWireframe
    }
    
    func installIntroToRootViewControllerIntoWindow(window: UIWindow){
        introWireframe.presentIntroInterfaceFromWindow(window)
    }
    
    func installRecordToRootViewControllerIntoWindow(window: UIWindow){
        recordWireframe.presentRecordInterfaceFromWindow(window)
    }
}