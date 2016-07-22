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
    let videosList = Project.sharedInstance.getVideoList()
    
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
//        return videosList.count
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifierCell, forIndexPath: indexPath) as! EditorClipsCell
        
        cell.positionNumberLabel.text = "\(indexPath.item + 1)"
        cell.thumbnailImageView.backgroundColor = UIColor.blackColor()
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events

    }
    
    func collectionView(collectionView: UICollectionView,
                                 moveItemAtIndexPath sourceIndexPath: NSIndexPath,
                                                     toIndexPath destinationIndexPath: NSIndexPath) {
        // move your data order
    }
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