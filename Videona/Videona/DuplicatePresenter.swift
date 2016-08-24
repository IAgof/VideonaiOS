//
//  DuplicatePresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 4/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class DuplicatePresenter: NSObject,DuplicatePresenterInterface,DuplicateInteractorDelegate {
    //MARK: - Variables VIPER
    var controller: DuplicateInterface?
    var delegate:DuplicatePresenterDelegate?
    var interactor: DuplicateInteractorInterface?
    var wireframe: DuplicateWireframe?
    
    var playerPresenter: PlayerPresenterInterface?
    var playerWireframe: PlayerWireframe?
    
    //MARK: - Variables
    var videoSelectedIndex:Int!{
        didSet{
            interactor?.setVideoPosition(videoSelectedIndex)
        }
    }
    
    var numberOfDuplicates:Int = 2 {
        didSet{
            if numberOfDuplicates<=2{
                numberOfDuplicates = 2
                controller?.hideMinusButton()
            }else if numberOfDuplicates == 3{
                controller?.showMinusButton()
            }
            
            delegate?.setNumberDuplicates("x\(numberOfDuplicates)")
        }
    }
    
    //MARK: - Interface
    func viewDidLoad() {
        numberOfDuplicates = 2

        wireframe?.presentPlayerInterface()
        controller?.bringToFrontExpandPlayerButton()

        interactor?.getThumbnail((controller?.getThumbSize())!)
        
        if let index = videoSelectedIndex {
            interactor?.setUpComposition(index,
                                         completion: {composition in
                                            self.playerPresenter?.createVideoPlayer(composition)
            })
        }
    }
    
    func viewWillDissappear() {
        playerPresenter?.onVideoStops()
    }
    
    func pushAcceptHandler() {
        interactor?.setDuplicateVideoToProject(numberOfDuplicates)
        wireframe?.goPrevController()
        
        let project = Project.sharedInstance
        controller?.getTrackerObject().trackClipDuplicated(numberOfDuplicates, project: project)
    }
    
    func pushCancelHandler() {
        wireframe?.goPrevController()
    }
    func pushBack() {
        wireframe?.goPrevController()
    }
    
    func pushLessClips() {
        numberOfDuplicates -= 1
    }
    
    func pushPlusClips() {
        numberOfDuplicates += 1
    }
    
    func expandPlayer() {
        wireframe?.presentExpandPlayer()
    }
    
    func updatePlayerLayer() {
        playerPresenter!.layoutSubViews()
    }
    
    //MARK: Interactor Delegate
    func setThumbnail(image: UIImage) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.delegate?.setThumbnails(image)
        })
    }
}