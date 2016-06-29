//
//  SettingsPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 11/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class SettingsPresenter:NSObject,SettingsPresenterInterface{
    
    var controller: SettingsInterface?
    var interactor: SettingsInteractorInterface?

    var wireframe: SettingsWireframe?
    var detailTextWireframe: DetailTextWireframe?
    var recordWireframe: RecordWireframe?

    let kamaradaAppleStoreURL = Utils().getStringByKeyFromSettings(SettingsConstants().KAMARADA_ITUNES_LINK)
    let videonaTwitterUser = Utils().getStringByKeyFromSettings(SettingsConstants().VIDEONA_TWITTER_USER)
    
    func pushBack() {
        wireframe?.goPrevController()
    }
    func viewDidLoad() {
        controller?.setNavBarTitle(Utils().getStringByKeyFromSettings(SettingsConstants().SETTINGS_TITLE)
)
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
    
    func itemListSelected(itemTitle: String, index: NSIndexPath) {
        
        switch itemTitle {
        case SettingsProvider().getStringForType(SettingsType.DownloadKamarada):
            wireframe?.goToAppleStoreURL(NSURL(string:kamaradaAppleStoreURL)!)
            
            controller?.getTrackerObject().trackLinkClicked(kamaradaAppleStoreURL,
                                                            destination: AnalyticsConstants().DESTINATION_KAMARADA_ITUNES)
            break
        case SettingsProvider().getStringForType(SettingsType.ShareVideona):
            controller?.getTrackerObject().trackAppShared("Videona", socialNetwork: "Whatsapp")
            
            controller?.createActiviyVCShareVideona(Utils().getStringByKeyFromSettings(SettingsConstants().WHATSAPP_SHARE_TEXT))
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
            let resolutions = interactor?.getAVResolutions()
            controller?.createActionSheetWithOptions(SettingsProvider().getStringForType(SettingsType.Resolution),
                                                     options: resolutions!,
                                                     index: index)

            break
        case SettingsProvider().getStringForType(SettingsType.Quality):
            let qualitys = interactor?.getAVQualitys()
            controller?.createActionSheetWithOptions(SettingsProvider().getStringForType(SettingsType.Quality),
                                                     options: qualitys!,
                                                     index: index)
            break
        case SettingsProvider().getStringForType(SettingsType.LegalAdvice):
            detailTextWireframe?.presentShareInterfaceFromViewController((controller?.getController())!,
                                                                         textRef: Utils().getStringByKeyFromSettings(SettingsConstants().LEGAL_ADVICE_CONTENT))

            break
        case SettingsProvider().getStringForType(SettingsType.Licenses):
            detailTextWireframe?.presentShareInterfaceFromViewController((controller?.getController())!,
                                                                         textRef: Utils().getStringByKeyFromSettings(SettingsConstants().LICENSES_CONTENT))

            break
        case SettingsProvider().getStringForType(SettingsType.TermsOfService):
            detailTextWireframe?.presentShareInterfaceFromViewController((controller?.getController())!,
                                                                         textRef: Utils().getStringByKeyFromSettings(SettingsConstants().TERMS_OF_SERVICE_CONTENT))

            break
        case SettingsProvider().getStringForType(SettingsType.PrivacyPolicy):
            detailTextWireframe?.presentShareInterfaceFromViewController((controller?.getController())!,
                                                                         textRef: Utils().getStringByKeyFromSettings(SettingsConstants().PRIVACY_POLICY_CONTENT))

            break
        case SettingsProvider().getStringForType(SettingsType.AboutUs):
            detailTextWireframe?.presentShareInterfaceFromViewController((controller?.getController())!,
                                                                         textRef: Utils().getStringByKeyFromSettings(SettingsConstants().ABOUT_US_CONTENT))

            break
            
        case SettingsProvider().getStringForType(SettingsType.Exit):
            controller?.createAlertExit()
            break
            
        default:
            
            break
        }
    }
    
    func getInputFromAlert(settingsTitle:String,input:String){
        switch settingsTitle {
        case SettingsProvider().getStringForType(SettingsType.NameAccount):
            interactor?.saveNameOnDefaults(input)
            controller?.getTrackerObject().trackNameTraits()

            break
        
        case SettingsProvider().getStringForType(SettingsType.UserNameAccount):
            interactor?.saveUserNameOnDefaults(input)
            controller?.getTrackerObject().trackUserNameTraits()
            break
            
        case SettingsProvider().getStringForType(SettingsType.emailAccount):
            if interactor?.isValidEmail(input) == true {
                interactor?.saveEmailOnDefaults(input)
            }else{
                controller?.createAlertViewError("OK",
                                                      message: Utils().getStringByKeyFromSettings(SettingsConstants().INVALID_MAIL),
                                                      title: Utils().getStringByKeyFromSettings(SettingsConstants().EMAIL_PREFERENCE))
                return
            }
            interactor?.saveEmailOnDefaults(input)
            controller?.getTrackerObject().trackMailTraits()
            break
        
        case SettingsProvider().getStringForType(SettingsType.Resolution):
            interactor?.saveResolutionOnDefaults(input)

            break
        case SettingsProvider().getStringForType(SettingsType.Quality):
            interactor?.saveQualityOnDefaults(input)

            break

        default:
            
            break
        }
        //Reload data
        self.getListData()
        
        controller?.reloadTableData()
    }
}