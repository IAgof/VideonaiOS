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
    
    var filterList: Array<UIImage> = []
        
    //MARK: - Outlets
    @IBOutlet weak var filtersCollectionView: UICollectionView!
   
    //MARK: - Init
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "FilterListView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }

    func initDelegates(){
        filtersCollectionView.delegate = self
        filtersCollectionView.dataSource = self
    }
    
    //MARK: - Filters setUp
    func getColorFiltersAsFilterList(){
        eventHandler?.getColorFilterList()
    }
    
    func getShaderFiltersAsFilterList(){
        eventHandler?.getShaderFilterList()
    }
    func setUpFiltersOnView(filters:Array<UIImage>) {
        filterList = filters
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
        return filterList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifierCell, forIndexPath: indexPath) as! FilterViewCell
        
        let image = filterList[indexPath.item]
        
        cell.filterImage.image = image
        
        return cell
    }
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected filter in position #\(indexPath.item) \n filter name: \(filterList[indexPath.item])!")
    }
}