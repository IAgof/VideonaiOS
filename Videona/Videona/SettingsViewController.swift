//
//  SettingsViewController.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 11/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import UIKit
import Foundation

class SettingsViewController: VideonaController,SettingsInterface ,
    UINavigationBarDelegate,UITableViewDelegate,UITableViewDataSource{
    
    var eventHandler: SettingsPresenterInterface?
    var titleBar = "Share video"
    var titleBackButtonBar = "Back"
    
    let reuseIdentifierCell = "settingsCell"
    
    //MARK: - List variables
    var section = Array<String>()
    var items = Array<Array<String>>()
    var subItems = Array<Array<String>>()
    
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
    
    //MARK: - UITableview delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //cell push
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let settingsOption = items[indexPath.section][indexPath.item]
        print("Settings option #\(indexPath.item)\n filter name: \(settingsOption)!")
        eventHandler?.itemListSelected(settingsOption)
    }
    
    
    //MARK: - AlertViewController
    func createAlertViewWithInputText(title:String){
        let saveString = "Save"
        let alertController = UIAlertController(title: title, message: "Insert your \(title.lowercaseString) here", preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
            textField.placeholder = title
        }
        
        let saveAction = UIAlertAction(title: saveString, style: .Default, handler: {alert -> Void in
            let firstTextFieldText = (alertController.textFields![0] as UITextField).text
            print("El \(title) introducido para mandar al presenter es: \(firstTextFieldText!)")
            self.eventHandler?.getInputFromAlert(title, input: firstTextFieldText!)
        })
        
        alertController.addAction(saveAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}