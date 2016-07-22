//
//  EditorViewController.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 21/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class EditorViewController: VideonaController,EditorViewInterface,
UICollectionViewDataSource,UICollectionViewDelegate{
    
    var eventHandler: EditorPresenterInterface?
    
    let reuseIdentifierCell = "editorCollectionViewCell"
    
    //Esto no debe estar aqui, aqui no se debe manejar con objetos, es una clase tonta!
//    let videosList = Project.sharedInstance.getVideoList()
    var videosList = Project.sharedInstance.getVideoList()
    
    var selectedCellIndexPath:NSIndexPath?
    
    //MARK: - Outlets
    @IBOutlet weak var thumbnailClipsCollectionView: UICollectionView!

    //MARK: - Variables
    var longPressGesture: UILongPressGestureRecognizer?
    var currentDragAndDropIndexPath: NSIndexPath?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: "handleLongGesture:")
        self.thumbnailClipsCollectionView.addGestureRecognizer(longPressGesture!)
        
        
        //BORRAR
        for i in 1...10{
            let video = Video(title: "\(i)", mediaPath: "")
            video.setPosition(i)
            videosList.append(video)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

//        eventHandler?.viewWillAppear()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
//        eventHandler?.viewWillDisappear()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UICollectionViewDataSource protocol
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videosList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifierCell, forIndexPath: indexPath) as! EditorClipsCell
        
        Utils.sharedInstance.debugLog("cell for item at indexPath:\(indexPath.item) \n videolist position\(videosList[indexPath.item].getPosition())")
        cell.positionNumberLabel.text = "\(videosList[indexPath.item].getPosition())"
        
        cell.thumbnailImageView.backgroundColor = UIColor.blackColor()
        
        if indexPath == selectedCellIndexPath {
            cell.isClipSelected = true
        }else{
            cell.isClipSelected = false
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        
        // Deselect last cell
        if (selectedCellIndexPath != nil){
            if (thumbnailClipsCollectionView.cellForItemAtIndexPath(selectedCellIndexPath!) != nil){
                
                let lastCell = thumbnailClipsCollectionView.cellForItemAtIndexPath(selectedCellIndexPath!) as! EditorClipsCell
                lastCell.isClipSelected = false
            }
        }
        
        // Select cell
        let cell = thumbnailClipsCollectionView.cellForItemAtIndexPath(indexPath) as! EditorClipsCell
        
        cell.isClipSelected = !(cell.isClipSelected)
        
        selectedCellIndexPath = indexPath
    }
    
    
    //MARK: - Moving Items
    func collectionView(collectionView: UICollectionView,
                                 moveItemAtIndexPath sourceIndexPath: NSIndexPath,
                                                     toIndexPath destinationIndexPath: NSIndexPath) {
        // move your data order
        
        Utils.sharedInstance.debugLog("Move item at index \n sourceIndexPath: \(sourceIndexPath.item) \n destinationIndexPath \(destinationIndexPath.item)")
        
        moveClipToPosition(sourceIndexPath.item,
                           destionationPosition: destinationIndexPath.item)
        
        reloadPositionNumberAfterMovement()
        
        if selectedCellIndexPath == sourceIndexPath {
            selectedCellIndexPath = destinationIndexPath
        }
    }
    
    func reloadPositionNumberAfterMovement() {
        for videoPosition in 0...(videosList.count - 1) {
            videosList[videoPosition].setPosition(videoPosition + 1)
        }
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.thumbnailClipsCollectionView.reloadData()
        })
    }
    
    func moveClipToPosition(sourcePosition:Int,
                            destionationPosition:Int){
        let videoToMove = videosList[sourcePosition]
        
        videosList.removeAtIndex(sourcePosition)
        
        videosList.insert(videoToMove, atIndex: destionationPosition)
    }
    
    //MARK: - Drag and Drop hangler
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case UIGestureRecognizerState.Began:
            guard let selectedIndexPath = self.thumbnailClipsCollectionView.indexPathForItemAtPoint(gesture.locationInView(self.thumbnailClipsCollectionView)) else {
                break
            }
            thumbnailClipsCollectionView.beginInteractiveMovementForItemAtIndexPath(selectedIndexPath)
        case UIGestureRecognizerState.Changed:
            thumbnailClipsCollectionView.updateInteractiveMovementTargetPosition(gesture.locationInView(gesture.view!))
        case UIGestureRecognizerState.Ended:
            thumbnailClipsCollectionView.endInteractiveMovement()
        default:
            thumbnailClipsCollectionView.cancelInteractiveMovement()
        }
    }
}