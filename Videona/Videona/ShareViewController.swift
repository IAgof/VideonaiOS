//
//  ShareViewController.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 11/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import UIKit
import Foundation

class ShareViewController: UIViewController,ShareInterface ,
UINavigationBarDelegate ,
UITableViewDelegate, UITableViewDataSource{
    
    //MARK: - VIPER
    var eventHandler: SharePresenterInterface?
    
    //MARK: - Variables and Constants
    var titleBar = "Share video"
    var titleBackButtonBar = "Back"
    
    let reuseIdentifierCell = "shareCell"
    let shareNibName = "ShareCell"
    var listImages = Array<UIImage>()
    var listImagesPressed = Array<UIImage>()
    var listTitles = Array<String>()
    
    //MARK: - Outlets
    @IBOutlet weak var shareTableView: UITableView!
    @IBOutlet weak var playerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDid Load")

        eventHandler?.viewDidLoad()
    }
    
    //MARK: - View Init
    func registerNib(){
        let nib = UINib.init(nibName: shareNibName, bundle: nil)
        shareTableView.registerNib(nib, forCellReuseIdentifier: reuseIdentifierCell)
    }
    
    func setTitleList(titleList: Array<String>) {
        self.listTitles = titleList
    }
    
    func setImageList(imageList: Array<UIImage>) {
        self.listImages = imageList
    }
    func setImagePressedList(imageList: Array<UIImage>) {
        self.listImagesPressed = imageList
    }
    func createNavigationBar(){
        // Create the navigation bar
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 44)) // Offset by 20 pixels vertically to take the status bar into account
        
        navigationBar.backgroundColor = UIColor.whiteColor()
        navigationBar.delegate = self;
        
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = titleBar
        
        // Create left and right button for navigation item
        let leftButton =  UIBarButtonItem(title: titleBackButtonBar, style:   UIBarButtonItemStyle.Plain, target: self, action: #selector(SettingsViewController.pushBackBarButton(_:)))
        
        // Create two buttons for the navigation item
        navigationItem.leftBarButtonItem = leftButton
        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
    }
    
    func pushBackBarButton(sender: UIBarButtonItem) {
        // Do something
        eventHandler?.pushBack()
    }
    
    func navigateToNewViewController(controller: UIViewController) {
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    //MARK: - UITableView Datasource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return listTitles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // get a reference to our storyboard cell
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifierCell) as! ShareCell
        
        cell.shareTitle!.text = listTitles[indexPath.item]
        cell.shareImage!.image = listImages[indexPath.item]
        
        return cell
    }

    //MARK: - UITableView Delegate
   func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected in position #\(indexPath.item)\n filter name: \(listTitles[indexPath.item])!")
        tableView.cellForRowAtIndexPath(indexPath)?.selected = false
    }
}