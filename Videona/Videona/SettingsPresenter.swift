//
//  SettingsPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 11/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class SettingsPresenter:NSObject,SettingsPresenterInterface{
    
    var wireframe: SettingsWireframe?
    var controller: SettingsViewController?
    var recordWireframe: RecordWireframe?
    var interactor: SettingsInteractor?
   
    let kamaradaAppleStoreURL = NSURL.init(string:"https://itunes.apple.com/us/app/silent-movie-camera-kamarada/id1109300504?l=es&ls=1&mt=8")
    let videonaTwitterUser = "Videona_es"
    
    func pushBack() {
        print("Navigator presenter pushEdit")
        recordWireframe?.goBackToRecordView(controller!)
    }
    func viewDidLoad() {
        controller?.registerClass()
        self.getListData()
    }
    
    func getListData (){
        let settings = interactor?.findSettings()
        
        self.setListTitleAndSubtitleData((settings?.1)!)
        self.setSectionListData((settings?.0)!)
    }
    
    func setListTitleAndSubtitleData(titleArray:Array<Array<Array<String>>>){
        controller?.setListTitleAndSubtitleData(titleArray)
    }
    
    func setSectionListData(section:Array<String>){
        controller?.setSectionList(section)
    }
    
    func itemListSelected(itemTitle:String){
        switch itemTitle {
        case SettingsProvider().getStringForType(SettingsType.DownloadKamarada):
            wireframe?.goToAppleStoreURL(kamaradaAppleStoreURL!)
            break
        case SettingsProvider().getStringForType(SettingsType.ShareVideona):
            
            break
        case SettingsProvider().getStringForType(SettingsType.FollowUsOnTwitter):
            wireframe?.goToTwitterUserPage(videonaTwitterUser)
            break
        
        case SettingsProvider().getStringForType(SettingsType.NameAccount):
            controller?.createAlertViewWithInputText(SettingsProvider().getStringForType(SettingsType.NameAccount))
            break
        case SettingsProvider().getStringForType(SettingsType.UserNameAccount):
            controller?.createAlertViewWithInputText(SettingsProvider().getStringForType(SettingsType.UserNameAccount))

            break
        case SettingsProvider().getStringForType(SettingsType.emailAccount):
            controller?.createAlertViewWithInputText(SettingsProvider().getStringForType(SettingsType.emailAccount))

            break
        
        case SettingsProvider().getStringForType(SettingsType.Resolution):
            
            break
        case SettingsProvider().getStringForType(SettingsType.Quality):
            
            break
        
        case SettingsProvider().getStringForType(SettingsType.AboutUs):
            
            break
        case SettingsProvider().getStringForType(SettingsType.PrivacyPolicy):
            
            break
        case SettingsProvider().getStringForType(SettingsType.ServiceConditions):
            
            break
        case SettingsProvider().getStringForType(SettingsType.Licenses):
            
            break
        case SettingsProvider().getStringForType(SettingsType.LegalAdvice):
            
            break
        
        case SettingsProvider().getStringForType(SettingsType.Exit):
            
            break
            
        default:
            
            break
        }
    }
    
    func getInputFromAlert(settingsTitle:String,input:String){
        switch settingsTitle {
        case SettingsProvider().getStringForType(SettingsType.NameAccount):
            interactor?.saveNameOnDefaults(input)
            
            break
        
        case SettingsProvider().getStringForType(SettingsType.UserNameAccount):
            interactor?.saveUserNameOnDefaults(input)
            break
            
        case SettingsProvider().getStringForType(SettingsType.emailAccount):
            if interactor?.isValidEmail(input) == true {
                interactor?.saveEmailOnDefaults(input)
            }else{
                controller?.createEmailAlertViewError()
                return
            }
            interactor?.saveEmailOnDefaults(input)
            break
        
        default:
            
            break
        }
        //Reload data
        self.getListData()
        
        controller?.reloadTableData()
    }
}