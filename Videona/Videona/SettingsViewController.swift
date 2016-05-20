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
    
    @IBAction func pushBackBarButton(sender: AnyObject) {
        eventHandler?.pushBack()
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