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
    
    var detailEventHandler: MusicDestailInterface?

    //MARK: - Variables
    var lastMusicSelected:Int = -1
    
    //MARK: - Constants
    let NO_MUSIC_SELECTED = -1

    //MARK: - Interface
    func viewDidLoad() {
        interactor?.getMusicList()
        
        if (interactor?.hasMusicSelectedInProject())! {
            let music = Project.sharedInstance.getMusic()
            
            delegate?.animateToShowDetail(music.getTitle(),
                                          author: music.getAuthor(),
                                          image: UIImage(named: music.getIconResourceId())!)
            
            detailEventHandler?.showRemoveButton()
        }
    }
    
    func viewWillAppear() {
        
    }
    
    func viewWillDisappear() {
        
    }
    
    func didSelectMusicAtIndexPath(indexPath: NSIndexPath) {
        lastMusicSelected = indexPath.item
        
        delegate?.animateToShowDetail((interactor?.getTitleFromIndexPath(lastMusicSelected))!,
                                  author: (interactor?.getAuthorFromIndexPath(lastMusicSelected))!,
                                  image: (interactor?.getImageFromIndexPath(lastMusicSelected))!)
    }
    
    func cancelDetailButtonPushed() {
        delegate?.animateToShowTable()
        
        lastMusicSelected = NO_MUSIC_SELECTED
    }
    
    func acceptDetailButtonPushed() {
        delegate?.animateToShowTable()
        
        interactor?.setMusicToProject(lastMusicSelected)
    }
    
    func removeDetailButtonPushed() {
        delegate?.animateToShowTable()
        
        interactor?.setMusicToProject(NO_MUSIC_SELECTED)
    }
    
    //MARK: - Interactor delegate
    func setTextList(titleList: [String]) {
        delegate?.setTextList(titleList)
    }
    
    func setImageList(imageList: [UIImage]) {
        delegate?.setMusicImageList(imageList)
    }
}