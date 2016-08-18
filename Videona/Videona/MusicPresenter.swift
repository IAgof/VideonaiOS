//
//  MusicPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 27/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class MusicPresenter: MusicPresenterInterface,MusicInteractorDelegate {
    //MARK: - Variables VIPER
    var controller: MusicViewInterface? //O tengo referencia a uno u a otro, pero no a los dos
    var delegate:MusicPresenterDelegate?
    var interactor: MusicInteractorInterface?
    var wireframe: MusicWireframe?
    
    var detailEventHandler: MusicDetailInterface?

    var playerPresenter: PlayerPresenterInterface?
    var playerWireframe: PlayerWireframe?
    
    //MARK: - Variables
    var lastMusicSelected:Int = -1
    var isMusicSet:Bool = false
    
    //MARK: - Constants
    let NO_MUSIC_SELECTED = -1

    //MARK: - Interface
    func viewDidLoad() {
        interactor?.getMusicList()
        
        wireframe?.presentPlayerInterface()
        playerPresenter?.createVideoPlayer(GetActualProjectAVCompositionUseCase.sharedInstance.getComposition())
    }
    
    func viewWillAppear() {
        
    }
    
    func viewDidAppear() {
        self.checkIfHasMusicSelected()
    }
    
    func checkIfHasMusicSelected(){
        if (interactor?.hasMusicSelectedInProject())! {
            let music = Project.sharedInstance.getMusic()
            
            delegate?.animateToShowDetail(" \(music.getTitle()) ",
                                          author: " \(music.getAuthor()) ",
                                          image: UIImage(named: music.getIconResourceId())!)
            
            detailEventHandler?.showRemoveButton()
        }
    }
    
    func viewWillDisappear() {
        playerPresenter?.pauseVideo()
        
        if !isMusicSet {
            interactor?.setMusicToProject(NO_MUSIC_SELECTED)
        }
    }
    
    func setMusicDetailInterface(eventHandler: MusicDetailInterface) {
        self.detailEventHandler = eventHandler
    }
    
    func didSelectMusicAtIndexPath(indexPath: NSIndexPath) {
        lastMusicSelected = indexPath.item
        
        delegate?.animateToShowDetail(" \((interactor?.getTitleFromIndexPath(lastMusicSelected))!) ",
                                  author: " \((interactor?.getAuthorFromIndexPath(lastMusicSelected))!) ",
                                  image: (interactor?.getImageFromIndexPath(lastMusicSelected))!)

        interactor?.setMusicToProject(lastMusicSelected)
        playerPresenter?.createVideoPlayer(GetActualProjectAVCompositionUseCase.sharedInstance.getComposition())
    }
    
    func cancelDetailButtonPushed() {
        self.removeDetailButtonPushed()
    }
    
    func acceptDetailButtonPushed() {
        detailEventHandler?.showRemoveButton()
        isMusicSet = true
    }
    
    func removeDetailButtonPushed() {
        delegate?.animateToShowTable()
        interactor?.setMusicToProject(NO_MUSIC_SELECTED)

        playerPresenter?.createVideoPlayer(GetActualProjectAVCompositionUseCase.sharedInstance.getComposition())
        
        isMusicSet = false
    }
    
    //MARK: - Interactor delegate
    func setTextList(titleList: [String]) {
        delegate?.setTextList(titleList)
    }
    
    func setImageList(imageList: [UIImage]) {
        delegate?.setMusicImageList(imageList)
    }
}