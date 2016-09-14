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
    func hourToString(time:Double) -> String {
        let hours = Int(floor(time/3600))
        let mins = Int(floor(time % 3600) / 60)
        let secs = Int(floor(time % 3600) % 60)
        
        let x:Double = (time % 3600) % 60
        let numberOfPlaces:Double = 4.0
        let powerOfTen:Double = pow(10.0, numberOfPlaces)
        let targetedDecimalPlaces:Double = round((x % 1.0) * powerOfTen) / powerOfTen
        
        let decimals = Int(targetedDecimalPlaces * 1000)
        
//        return String(format:"%d:%02d:%02d,%02d", hours, mins, secs,decimals)
        return String(format:"%02d:%02d:%02d", mins, secs,decimals)
//        return String(format:"%02d:%02d", mins, secs)
    }
    
    func removeAllTempFiles(){
        print("Remove all temporally files")
        
        let fm = NSFileManager.defaultManager()
        do {
            let folderPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
            let paths = try fm.contentsOfDirectoryAtPath(folderPath)
            for path in paths
            {
                try fm.removeItemAtPath("\(folderPath)/\(path)")
            }
        } catch{
            print("error removeAllTempFiles ")
        }
    }
    
    func delay(delay: Double, closure: ()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(),
            closure
        )
    }
}