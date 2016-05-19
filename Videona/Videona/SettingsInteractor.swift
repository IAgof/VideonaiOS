//
//  SettingsInteractor.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 13/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

class SettingsInteractor: NSObject,SettingsInteractorInterface {
    var orderArray = Dictionary<Int,String>()
    
    func findSettings()->(Array<String>,Array<Array<String>>){
    
        let settings = SettingsProvider().getSettings()
        
        let settingsContent = self.setSettingsContent(settings)
        
        return settingsContent
    }
    
    func setSettingsContent(settingsContentArray:Array<SettingsContent>)->(Array<String>,Array<Array<String>>){
        
        var settingsDictionary = Dictionary<String,Array<String>>()
        
        orderArray = self.getOrderArrays(settingsContentArray)
        
        var items = Array<String>()

        for settingsItem in settingsContentArray{
            let section = settingsItem.getSection()
            
            if settingsDictionary.indexForKey(section) == nil{//First insertion
                items = Array<String>()
                items.append(settingsItem.getSettingsTitle())
                settingsDictionary[section] = items
            }else{//add objects to different sections
                var auxArray = settingsDictionary[section]
                auxArray?.append(settingsItem.getSettingsTitle())
                settingsDictionary[section] = auxArray
            }
        }
        
        print("setSettingsContent: -\n \(settingsDictionary)")
        
        let returnSectionsAndTitles = self.setSectionsAndTitles(settingsDictionary)
        
        
        return returnSectionsAndTitles
    }
    
    func setSectionsAndTitles(dictionary: Dictionary<String,Array<String>>)->(Array<String>,Array<Array<String>>){
        var sections = Array<String>()
        var titles = Array<Array<String>>()


        for var i = 0; i <= orderArray.count; i += 1 {
            if let key = orderArray[i]{
                if let titleArray = dictionary[key]{
                    sections.append(key)
                    titles.append(titleArray)
                }
            }
        }
        print("setSections: -\n \(sections)")
        return (sections,titles)
    }
    
    func getOrderArrays(settingsContent:Array<SettingsContent>)->Dictionary<Int,String>{
        var orderByKey = Dictionary<Int,String>()
        
        var prevSection = ""
        for setting in settingsContent{
           let actualSection = setting.getSection()
            if actualSection != prevSection{
               prevSection = actualSection
                orderByKey[setting.getPriority()] = actualSection
            }
        }
        
//        print("getOrderArrays\n \(orderByKey)")
        return orderByKey
    }
    
    
    
//    func setSections(sNArray:Array<SettingsContent>)->Array<String>{
//        var sections = Array<String>()
//        
//        for settingItem in sNArray{
//            if   !sections.contains(settingItem.getSection()){
//                sections.append(settingItem.getSection())
//            }
//        }
//        
//        print("setSections: -\n \(sections)")
//        return sections
//    }
}