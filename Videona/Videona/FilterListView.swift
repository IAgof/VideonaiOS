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
        
        return cell
    }
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! FilterViewCell
        
        var filters = Array<String>()
        if let cellTitle = cell.filterTitle.text{
            filters.append(cellTitle)
        }
        
        print("You selected filter in position #\(indexPath.item) \n filter name: \(cell.filterTitle.text)!")
        eventHandler?.FilterListSelectedFilters(filters)
    }
}