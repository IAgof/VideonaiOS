//
//  FilterListViewController.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 12/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

class FilterListView: UIView,FilterListInterface,
UICollectionViewDataSource,
UICollectionViewDelegate {
    
    //MARK: - VIPER
    var eventHandler: FilterListPresenterInterface?
    
    var transitioningBackgroundView : UIView = UIView()
    let reuseIdentifierCell = "filterCell"
    var filterListImage: Array<UIImage> = []
    var filterListTitle: Array<String> = []
    var lastSelectedIndexPath:NSIndexPath = NSIndexPath.init(index: -1)
    
    
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
            
            }, completion: { finished in
                //When the filtersList load finished, then scroll to last selected item
                self.scrollToSelectedItem(self.lastSelectedIndexPath)
        })
    }
    
    func setSelectedCellIndexPath(indexForItem:NSIndexPath){
        self.lastSelectedIndexPath = indexForItem
    }

    func scrollToSelectedItem(indexForItem:NSIndexPath) {
        if indexForItem.item != -1 {
            self.filtersCollectionView.scrollToItemAtIndexPath(indexForItem, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
        }
    }

    func scrollToNextElement() {
        let visibleItems = self.filtersCollectionView.indexPathsForSelectedItems()
        let currentItem = visibleItems![0]
        
        self.filtersCollectionView.scrollToItemAtIndexPath(currentItem, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
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
        
        if lastSelectedIndexPath.item==indexPath.item{
            cell.isSelectedCell = true
        }else{
            cell.isSelectedCell = false
        }

        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! FilterViewCell
        
        eventHandler?.toggleSelectedCell(cell,item: indexPath.item)
        
        eventHandler?.checkOtherCellSelected(indexPath, lastSelectedIndexPath: lastSelectedIndexPath, collectionView: filtersCollectionView)
        
        lastSelectedIndexPath = indexPath
        
        self.scrollToNextElement()
    }
}