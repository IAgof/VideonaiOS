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
    
    let reuseIdentifierCell = "settingsCell"
    
    //MARK: - List variables
    var section = Array<String>()
    var items = Array<Array<Array<String>>>()
    
    //MARK: - Outlets
    @IBOutlet weak var settingsTableView: UITableView!
    @IBOutlet weak var settingsNavBar: UINavigationItem!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        eventHandler?.viewDidLoad()
    }
    
    //MARK: - init view
    func registerClass(){
        settingsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifierCell)
    }
    
    func removeSeparatorTable() {
        settingsTableView.separatorStyle = .None
    }
    
    func setNavBarTitle(title:String){
                settingsNavBar.title = title
    }
    
    @IBAction func pushBackBarButton(sender: AnyObject) {
        eventHandler?.pushBack()
    }
    
    func setListTitleAndSubtitleData(titleAndSubtitleList: Array<Array<Array<String>>>) {
        self.items = titleAndSubtitleList
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
        
        return section.count
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.items[section][0].count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell? =
            tableView.dequeueReusableCellWithIdentifier(reuseIdentifierCell)
        if (cell != nil)
        {
            cell = UITableViewCell(style: .Value1,
                                   reuseIdentifier: reuseIdentifierCell)
        }
        // Configure the cell...
        
        let title = self.items[indexPath.section][0][indexPath.row]
        let subTitle = self.items[indexPath.section][1][indexPath.row]
        
        cell!.textLabel?.text = title
        
        if subTitle != ""{
            cell!.detailTextLabel?.text = self.items[indexPath.section][1][indexPath.row]
            print("\n Title equals = \(title) \n Subtitle equals = \(subTitle)")
        }
        cell!.detailTextLabel?.adjustsFontSizeToFitWidth
        cell!.textLabel?.adjustsFontSizeToFitWidth
        
        return cell!
    }
    
    //MARK: - UITableview delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //cell push
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let settingsOption = items[indexPath.section][0][indexPath.item]
        print("Settings option #\(indexPath.item)\n option selected: \(settingsOption)!")
        eventHandler?.itemListSelected(settingsOption,index: indexPath)
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
    
    func createAlertViewError(buttonText:String,message:String,title:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: buttonText, style: .Destructive, handler: nil)
        
        alertController.addAction(saveAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func createActionSheetWithOptions(title: String, options: Array<String>, index: NSIndexPath) {
        
        let cancelString = "Cancel"
        let title = title
        
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .ActionSheet)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = settingsTableView.cellForRowAtIndexPath(index)
        }
        
        for option in options {
            let optionAction = UIAlertAction(title: option, style: .Default, handler: {alert -> Void in
                
                self.eventHandler?.getInputFromAlert(title, input: option)
                print("El \(title) introducido para mandar al presenter es: \(option)")
            })
            alertController.addAction(optionAction)
        }
        
        let optionAction = UIAlertAction(title: cancelString, style: .Cancel, handler: nil)
        alertController.addAction(optionAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func createAlertExit(){
        
        // create the alert
        let alert = UIAlertController(title: "Exit", message: "Do you want to exit application?", preferredStyle: UIAlertControllerStyle.Alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "YES", style: UIAlertActionStyle.Destructive, handler: { action in
            
            // do something like...
            exit(1)
            
        }))
        alert.addAction(UIAlertAction(title: "NO", style: UIAlertActionStyle.Cancel, handler: nil))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
    func reloadTableData() {
        self.settingsTableView.reloadData()
    }
    
    func createActiviyVCShareVideona(text:String){
        var whatsAppText:String = "whatsapp://send?text="
        whatsAppText.appendContentsOf(text)
        
        let whatsAppTextCoded = whatsAppText.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())

        let whatsappURL = NSURL.init(string: whatsAppTextCoded!)
            
        if UIApplication.sharedApplication().canOpenURL(whatsappURL!){
            UIApplication.sharedApplication().openURL(whatsappURL!)
        }else{
            self.createAlertViewError("OK",
                                      message: Utils().getStringByKeyFromSettings(SettingsConstants().WHATSAPP_NOT_INSTALLED),
                                      title: Utils().getStringByKeyFromSettings(SettingsConstants().SHARE_VIDEONA_TITLE))
        }
    }
}