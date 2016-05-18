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
    
    func findSettings()->(Array<String>,Array<Array<String>>){
    
        let settings = SettingsProvider().getSettings()
        
        let settingsContent = self.setSettingsContent(settings)
        
        return settingsContent
    }
    
    func setSettingsContent(sNArray:Array<SettingsContent>)->(Array<String>,Array<Array<String>>){
        
        var settingsDictionary = Dictionary<String,Array<String>>()
                
        var items = Array<String>()

        for settingsItem in sNArray{
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
        
        let returnSections = self.setSections(settingsDictionary)
        
        var returnTitles = Array<Array<String>>()
        
        for array in settingsDictionary{
            returnTitles.append(array.1)
        }
        
        return (returnSections,returnTitles)
    }
    
    func setSections(dictionary: Dictionary<String,Array<String>>)->Array<String>{
        var sections = Array<String>()
        
        for sectionDic in dictionary{
            sections.append(sectionDic.0)
        }
        
        print("setSections: -\n \(sections)")
        return sections
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