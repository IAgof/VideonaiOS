//
//  SettingsViewController.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 11/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import UIKit
import Foundation

class SettingsViewController: UIViewController,SettingsInterface ,
    UINavigationBarDelegate,UITableViewDelegate,UITableViewDataSource{
    
    var eventHandler: SettingsPresenterInterface?
    var titleBar = "Share video"
    var titleBackButtonBar = "Back"
    
    let reuseIdentifierCell = "settingsCell"
    
    //MARK: - List variables
    var section = Array<String>()
    var items = Array<Array<String>>()
    
    //MARK: - Outlets
    @IBOutlet weak var settingsTableView: UITableView!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        eventHandler?.viewDidLoad()
    }
    
    //MARK: - init view
    func registerClass(){
        settingsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifierCell)
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
    
    func setTitleList(titleList: Array<Array<String>>) {
        self.items = titleList
    }
    
    func setSectionList(section: Array<String>) {
        self.section = section
    }
    
    //MARK: - UITableview delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //cell push
    }
    
    //MARK: - UITableview datasource
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
//        return self.section.count
        return section.count
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.items[section].count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifierCell, forIndexPath: indexPath)
        
        // Configure the cell...
        
        cell.textLabel?.text = self.items[indexPath.section][indexPath.row]

//        cell.textLabel?.text = items[indexPath.item] as! String
        cell.detailTextLabel?.text = "detailText"
        
        return cell
    }
}