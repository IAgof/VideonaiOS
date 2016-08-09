//
//  EditorViewController.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 21/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class EditorViewController: VideonaController,EditorViewInterface,PlayerViewDelegate,
UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    //MARK: - VIPER variables
    var eventHandler: EditorPresenterInterface?
    
    //MARK: - Variables
    var longPressGesture: UILongPressGestureRecognizer?
    var currentDragAndDropIndexPath: NSIndexPath?
    
    let reuseIdentifierCell = "editorCollectionViewCell"
    
    var videoPositionList: [Int] = []

    var videoImageList: [UIImage] = []{
        didSet {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.thumbnailClipsCollectionView.reloadData()
            })
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var thumbnailClipsCollectionView: UICollectionView!
    @IBOutlet weak var playerView: UIView!

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventHandler?.viewDidLoad()
        
    }
        
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        eventHandler?.viewWillAppear()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        eventHandler?.viewWillDisappear()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UICollectionViewDataSource protocol
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoPositionList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifierCell, forIndexPath: indexPath) as! EditorClipsCell
        
        cell.positionNumberLabel.text = "\(videoPositionList[indexPath.item])"
        
        if  videoImageList.indices.contains(indexPath.item){
            cell.thumbnailImageView.image = videoImageList[indexPath.item]
        }
        
        eventHandler?.cellForItemAtIndexPath(indexPath)
    
        cell.removeClipButton.tag = indexPath.row
        
        cell.removeClipButton.addTarget(self, action: "pushRemoveVideoClip:", forControlEvents: UIControlEvents.TouchUpInside)

//        Utils.sharedInstance.debugLog("cell for item at indexPath:\(indexPath.item) \n videolist position\(videoPositionList[indexPath.item])\n cell isSelected\(cell.isClipSelected)")

        return cell
    }
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
       
        let size = Utils.sharedInstance.thumbnailEditorListDiameter
        
        return CGSize(width: size,
                      height: size)
    }
    
    // MARK: - UICollectionViewDelegate protocol
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        
        eventHandler?.didSelectItemAtIndexPath(indexPath)
    }
    
    //MARK: - Moving Items
    func collectionView(collectionView: UICollectionView,
                        moveItemAtIndexPath sourceIndexPath: NSIndexPath,
                                            toIndexPath destinationIndexPath: NSIndexPath) {
        // move your data order
        
        //        Utils.sharedInstance.debugLog("Move item at index \n sourceIndexPath: \(sourceIndexPath.item) \n destinationIndexPath \(destinationIndexPath.item)")
        
        eventHandler?.moveItemAtIndexPath(sourceIndexPath,
                                          toIndexPath: destinationIndexPath)
        
    }
    
    //MARK: - Actions
    @IBAction func pushRemoveVideoClip(sender:UIButton){
        
        eventHandler?.removeVideoClip(sender.tag)
    }
    
    @IBAction func pushTrimClip(sender:UIButton){
        
        eventHandler?.pushTrimHandler()
    }
    
    @IBAction func pushDuplicateClip(sender:UIButton){
        
        eventHandler?.pushDuplicateHandler()
    }
    
    @IBAction func pushDivideClip(sender:UIButton){
        
        eventHandler?.pushSplitHandler()
    }
    
    //MARK: - Interface
    func deselectCell(indexPath:NSIndexPath) {
        if (thumbnailClipsCollectionView.cellForItemAtIndexPath(indexPath) != nil){
            let lastCell = thumbnailClipsCollectionView.cellForItemAtIndexPath(indexPath) as! EditorClipsCell
            lastCell.isClipSelected = false
        }
    }
    
    func selectCell(indexPath:NSIndexPath) {
        // Select cell
        if let cell = (thumbnailClipsCollectionView.cellForItemAtIndexPath(indexPath)){
            let editorCell = cell as! EditorClipsCell
            
            editorCell.isClipSelected = true
        }
    }
    
    func reloadCollectionViewData() {
        thumbnailClipsCollectionView.reloadData()
    }
    
    func setPositionList(list: [Int]) {
        self.videoPositionList = list
    }
    
    func setVideoImagesList(list: [UIImage]) {
        self.videoImageList = list
    }
    
    func setUpGestureRecognizer(){
        longPressGesture = UILongPressGestureRecognizer(target: self, action: "handleLongGesture:")
        self.thumbnailClipsCollectionView.addGestureRecognizer(longPressGesture!)
    }
    
    func numberOfCellsInCollectionView() -> Int {
        return self.thumbnailClipsCollectionView.numberOfItemsInSection(0)
    }
    
    //MARK: - Drag and Drop handler
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case UIGestureRecognizerState.Began:
            guard let selectedIndexPath = self.thumbnailClipsCollectionView.indexPathForItemAtPoint(gesture.locationInView(self.thumbnailClipsCollectionView)) else {
                break
            }
            thumbnailClipsCollectionView.beginInteractiveMovementForItemAtIndexPath(selectedIndexPath)
            
            let cell = thumbnailClipsCollectionView.cellForItemAtIndexPath(selectedIndexPath) as! EditorClipsCell
            cell.isMoving = true
        
        case UIGestureRecognizerState.Changed:
            thumbnailClipsCollectionView.updateInteractiveMovementTargetPosition(gesture.locationInView(gesture.view!))
                     
        case UIGestureRecognizerState.Ended:
            thumbnailClipsCollectionView.endInteractiveMovement()
           
            guard let selectedIndexPath = self.thumbnailClipsCollectionView.indexPathForItemAtPoint(gesture.locationInView(self.thumbnailClipsCollectionView)) else {
                break
            }
            let cell = thumbnailClipsCollectionView.cellForItemAtIndexPath(selectedIndexPath) as! EditorClipsCell
            cell.isMoving = false
        default:
            thumbnailClipsCollectionView.cancelInteractiveMovement()
        }
    }
    
    //MARK: Player view delegate
    func seekBarUpdate(value: Float) {
        eventHandler?.seekBarUpdateHandler(value)
    }
}