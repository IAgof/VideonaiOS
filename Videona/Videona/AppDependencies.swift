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
    var settingsWireframe = SettingsWireframe()
    var shareWireframe = ShareWireframe()
    var filterListWireframe = FilterListWireframe()
    var playerWireframe = PlayerWireframe()
    var detailTextWireframe = DetailTextWireframe()
    var fullScreenPlayerWireframe = FullScreenPlayerWireframe()
    var editorRoomWireframe = EditingRoomWireframe()
    
    init(){
        configureDependencies()
    }
    func configureDependencies(){
        let rootWireframe = RootWireframe()
        let introPresenter = IntroPresenter()
        let recordPresenter = RecordPresenter()
        let settingsPresenter = SettingsPresenter()
        let settingsInteractor = SettingsInteractor()
        
        let sharePresenter = SharePresenter()
        let shareInteractor = ShareInteractor()
       
        let filterListPresenter = FilterListPresenter()
        let filterListInteractor = FilterListInteractor()
       
        let playerPresenter = PlayerPresenter()
        let playerInteractor = PlayerInteractor()
        
        let detailTextPresenter = DetailTextPresenter()
        let detailTextInteractor = DetailTextInteractor()

        let fullScreenPlayerPresenter = FullScreenPlayerPresenter()

        let editorRoomPresenter = EditingRoomPresenter()
        
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
        recordWireframe.editorRoomWireframe = editorRoomWireframe
        
        //SETTINGS MODULE
        settingsPresenter.wireframe = settingsWireframe
        settingsPresenter.recordWireframe = recordWireframe
        settingsPresenter.interactor = settingsInteractor
        settingsPresenter.detailTextWireframe = detailTextWireframe
        
        settingsWireframe.settingsPresenter = settingsPresenter
        settingsWireframe.rootWireframe = rootWireframe
        
        settingsInteractor.presenter = settingsPresenter
        
        //SHARE MODULE
        sharePresenter.wireframe = shareWireframe
        sharePresenter.recordWireframe = recordWireframe
        sharePresenter.fullScreenPlayerWireframe = fullScreenPlayerWireframe
        sharePresenter.playerWireframe = playerWireframe
        sharePresenter.interactor = shareInteractor
        sharePresenter.playerPresenter = playerPresenter
        
        shareWireframe.sharePresenter = sharePresenter
        shareWireframe.rootWireframe = rootWireframe
        shareWireframe.playerWireframe = playerWireframe
        
        //FILTER LIST MODULE
        filterListPresenter.wireframe = filterListWireframe
        filterListPresenter.recordWireframe = recordWireframe
        filterListPresenter.interactor = filterListInteractor
        filterListPresenter.filterListDelegate = recordPresenter
        
        filterListWireframe.filterListPresenter = filterListPresenter
        filterListWireframe.rootWireframe = rootWireframe
        
        //PLAYER MODULE
        playerPresenter.wireframe = playerWireframe
        playerPresenter.recordWireframe = recordWireframe
        playerPresenter.playerInteractor = playerInteractor
        
        playerWireframe.playerPresenter = playerPresenter
        playerWireframe.rootWireframe = rootWireframe
       
        //DETAIL TEXT MODULE
        detailTextPresenter.wireframe = detailTextWireframe
        detailTextPresenter.interactor = detailTextInteractor
        
        detailTextWireframe.detailTextPresenter = detailTextPresenter
        detailTextWireframe.rootWireframe = rootWireframe

        //DETAIL TEXT MODULE
        fullScreenPlayerPresenter.wireframe = fullScreenPlayerWireframe

        fullScreenPlayerWireframe.fullScreenPlayerPresenter = fullScreenPlayerPresenter
        fullScreenPlayerWireframe.rootWireframe = rootWireframe
        
        //EDITOR ROOM MODULE
        editorRoomPresenter.wireframe = editorRoomWireframe
        
        editorRoomWireframe.editingRoomPresenter = editorRoomPresenter
        editorRoomWireframe.rootWireframe = rootWireframe
    }
    
    func installIntroToRootViewControllerIntoWindow(window: UIWindow){
        introWireframe.presentIntroInterfaceFromWindow(window)
    }
    
    func installRecordToRootViewControllerIntoWindow(window: UIWindow){
        recordWireframe.presentRecordInterfaceFromWindow(window)
    }
    func installSettingsToRootViewControllerIntoWindow(window: UIWindow){
        settingsWireframe.presentSettingsInterfaceFromWindow(window)
    }
    func installShareToRootViewControllerIntoWindow(window: UIWindow){
        shareWireframe.presentShareInterfaceFromWindow(window)
    }
    
    func installEditorRoomToRootViewControllerIntoWindow(window: UIWindow){
        editorRoomWireframe.presentEditingRoomInterfaceFromWindow(window)
    }
}