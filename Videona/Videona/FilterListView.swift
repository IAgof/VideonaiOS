//
//  FilterListViewController.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 12/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

class FilterListView: UIView,FilterListInterface, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //MARK: - VIPER
    var eventHandler: FilterListPresenterInterface?
    
    var transitioningBackgroundView : UIView = UIView()
    let reuseIdentifierCell = "filterCell"
    var filterListImage: Array<UIImage> = []
    var filterListTitle: Array<String> = []
    var lastSelectedIndexPath:NSIndexPath?
    
    
    //MARK: - Outlets
    @IBOutlet weak var filtersCollectionView: UICollectionView!
    
    //MARK: - Init
    class func instanceFromNib() -> UIView {
       let view = UINib(nibName: "FilterListView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        return view
    }
    
    func initDelegates(){
        filtersCollectionView.delegate = self
        filtersCollectionView.dataSource = self
        
        filtersCollectionView.allowsSelection = true
        filtersCollectionView.allowsMultipleSelection = false
    }
    
    //MARK: - Filters setUp
    func getColorFiltersAsFilterList(){
        eventHandler?.getColorFilterList()
    }
    
    func getShaderFiltersAsFilterList(){
        eventHandler?.getShaderFilterList()
    }
    func setUpFiltersOnView(filtersImage:Array<UIImage>,filtersTitle:Array<String>) {
        filterListImage = filtersImage
        filterListTitle = filtersTitle
        self.filtersCollectionView.performBatchUpdates({
            
            self.filtersCollectionView.reloadData()
            
            }, completion: nil)
    }
    
    //MARK: - Navigation
    @IBAction func pushDismissView(sender: AnyObject) {
        eventHandler?.cancelFilterListAction()
    }
    
    func dismiss() {
        eventHandler?.cancelFilterListAction()
    }
    
    // MARK: - UICollectionViewDataSource protocol
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterListImage.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifierCell, forIndexPath: indexPath) as! FilterViewCell
        
        let image = filterListImage[indexPath.item]
        let title = filterListTitle[indexPath.item]
        
        cell.filterImage.image = image
        cell.filterTitle.text = title
        if lastSelectedIndexPath?.item==indexPath.item{
            cell.backgroundColor = UIColor.redColor()
        }else{
            cell.backgroundColor = UIColor.clearColor()
            cell.isSelectedCell = false
        }

        return cell
    }
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! FilterViewCell
        eventHandler?.toggleSelectedCell(cell)
        
        if let lastIndexPath = lastSelectedIndexPath{
            eventHandler?.checkOtherCellSelected(indexPath, lastSelectedIndexPath: lastIndexPath, collectionView: filtersCollectionView)
        }
        
        lastSelectedIndexPath = indexPath
    }
}