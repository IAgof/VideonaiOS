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
    
    //MARK: - Interface
    func viewDidLoad() {
        interactor?.getMusicList()
    }
    
    func viewWillAppear() {
        
    }
    
    func viewWillDisappear() {
        
    }
    
    func didSelectMusicAtIndexPath(indexPath: NSIndexPath) {
        let index = indexPath.item
        
        delegate?.animateToShowDetail((interactor?.getTitleFromIndexPath(index))!,
                                  author: (interactor?.getAuthorFromIndexPath(index))!,
                                  image: (interactor?.getImageFromIndexPath(index))!)
    }
    
    func cancelDetailButtonPushed() {
        delegate?.animateToShowTable()
    }
    
    func acceptDetailButtonPushed() {
        delegate?.animateToShowTable()
    }
    
    //MARK: - Interactor delegate
    func setTextList(titleList: [String]) {
        delegate?.setTextList(titleList)
    }
    
    func setImageList(imageList: [UIImage]) {
        delegate?.setMusicImageList(imageList)
    }
}