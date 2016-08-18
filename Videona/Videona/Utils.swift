//
//  Utils.swift
//  Kamarada
//
//  Created by Alejandro Arjonilla Garcia on 21/4/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class Utils{
    static let sharedInstance = Utils()
    
    var thumbnailEditorListDiameter:Int {
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Phone:
            return 80
        case .Pad:
            return 120
        case .Unspecified:
            return 50
        default:
            return 80
        }
    }
    
    let udid = UIDevice.currentDevice().identifierForVendor!.UUIDString

    func getDoubleHourAndMinutes() -> Double{
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute], fromDate: date)
        let hour = components.hour
        let minutes = components.minute

        return Double(hour) + (Double(minutes))/60;
    }
    
    func giveMeTimeNow()->String{
        var dateString:String = ""
        let dateFormatter = NSDateFormatter()
        
        let date = NSDate()
        
        dateFormatter.locale = NSLocale(localeIdentifier: "es_ES")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 3600) //GMT +1
        dateString = dateFormatter.stringFromDate(date)
        
        Utils().debugLog("La hora es : \(dateString)")
        
        return dateString
    }
    
    func debugLog(logMessage:String){
        #if DEBUG
            print("\n \(logMessage)")
        #endif
    }
    
    func getUDID() -> String{
        return udid
    }
    
    func getStringByKeyFromSettings(key:String) -> String {
        return NSBundle.mainBundle().localizedStringForKey(key,value: "",table: "Settings")
    }
    
    func getStringByKeyFromShare(key:String) -> String {
        return NSBundle.mainBundle().localizedStringForKey(key,value: "",table: "Share")
    }
    
    func getStringByKeyFromIntro(key:String) -> String {
        return NSBundle.mainBundle().localizedStringForKey(key,value: "",table: "Intro")
    }
    func getStringByKeyFromEditor(key:String) -> String {
        return NSBundle.mainBundle().localizedStringForKey(key,value: "",table: "Editor")
    }
    
}