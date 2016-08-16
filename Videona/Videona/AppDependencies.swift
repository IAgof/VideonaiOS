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
    var editorWireframe = EditorWireframe()
    var musicWireframe = MusicWireframe()
    var trimWireframe = TrimWireframe()
    var duplicateWireframe = DuplicateWireframe()
    var splitWireframe = SplitWireframe()
    
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
        
        let editorPresenter = EditorPresenter()
        let editorInteractor = EditorInteractor()
        
        let musicPresenter = MusicPresenter()
        let musicInteractor = MusicInteractor()

        let trimPresenter = TrimPresenter()
        let trimInteractor = TrimInteractor()
        
        let duplicatePresenter = DuplicatePresenter()
        let duplicateInteractor = DuplicateInteractor()
        
        let splitPresenter = SplitPresenter()
        let splitInteractor = SplitInteractor()
        
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
        
        filterListInteractor.delegate = filterListPresenter

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
        editorRoomWireframe.editorWireframe = editorWireframe
        editorRoomWireframe.shareWireframe = shareWireframe
        editorRoomWireframe.musicWireframe = musicWireframe
        
        //EDITOR MODULE
        editorPresenter.wireframe = editorWireframe
        editorPresenter.playerPresenter = playerPresenter
        editorPresenter.playerWireframe = playerWireframe
        editorPresenter.interactor = editorInteractor
        
        editorWireframe.editorPresenter = editorPresenter
        editorWireframe.playerWireframe = playerWireframe
        editorWireframe.rootWireframe = rootWireframe
        editorWireframe.trimWireframe = trimWireframe
        editorWireframe.duplicateWireframe = duplicateWireframe
        editorWireframe.splitWireframe = splitWireframe
        
        editorInteractor.delegate = editorPresenter
        
        //MUSIC MODULE
        musicPresenter.wireframe = musicWireframe
        musicPresenter.interactor = musicInteractor
        musicPresenter.playerPresenter = playerPresenter
        musicPresenter.playerWireframe = playerWireframe
        
        musicInteractor.delegate = musicPresenter
        
        musicWireframe.musicPresenter = musicPresenter
        musicWireframe.rootWireframe = rootWireframe
        musicWireframe.playerWireframe = playerWireframe
        
        //TRIM MODULE 
        trimPresenter.wireframe = trimWireframe
        trimPresenter.playerPresenter = playerPresenter
        trimPresenter.playerWireframe = playerWireframe
        trimPresenter.interactor = trimInteractor
        
        trimWireframe.playerWireframe = playerWireframe
        trimWireframe.rootWireframe = rootWireframe
        trimWireframe.trimPresenter = trimPresenter
        
        trimInteractor.delegate = trimPresenter
        
        //DUPLICATE MODULE
        duplicatePresenter.wireframe = duplicateWireframe
        duplicatePresenter.playerPresenter = playerPresenter
        duplicatePresenter.playerWireframe = playerWireframe
        duplicatePresenter.interactor = duplicateInteractor
        
        duplicateWireframe.playerWireframe = playerWireframe
        duplicateWireframe.rootWireframe = rootWireframe
        duplicateWireframe.duplicatePresenter = duplicatePresenter
        
        duplicateInteractor.delegate = duplicatePresenter
        
        //SPLIT MODULE
        splitPresenter.wireframe = splitWireframe
        splitPresenter.playerPresenter = playerPresenter
        splitPresenter.playerWireframe = playerWireframe
        splitPresenter.interactor = splitInteractor
        
        splitWireframe.playerWireframe = playerWireframe
        splitWireframe.rootWireframe = rootWireframe
        splitWireframe.splitPresenter = splitPresenter
        
        splitInteractor.delegate = splitPresenter
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
    func installDuplicateRoomToRootViewControllerIntoWindow(window: UIWindow){
        duplicateWireframe.presentDuplicateInterfaceFromWindow(window)
    }
    
    func installSplitRoomToRootViewControllerIntoWindow(window: UIWindow){
        splitWireframe.presentSplitInterfaceFromWindow(window)
    }
}