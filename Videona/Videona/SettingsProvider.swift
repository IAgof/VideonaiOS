//
//  SettingsProvider.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 17/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import AVFoundation

class SettingsProvider:NSObject{

    struct userInfo {
        var name:String
        var userName:String
        var email:String
        init(){
            let defaults = NSUserDefaults.standardUserDefaults()

            let nameSaved = defaults.stringForKey("settingsName")
            if (nameSaved != nil){
                name = nameSaved!
            }else{
                name = ""
            }
            
            let userNameSaved = defaults.stringForKey("settingsUserName")
            if (userNameSaved != nil){
                userName = userNameSaved!
            }else{
                userName = ""
            }
            
            let emailSaved = defaults.stringForKey("settingsEmail")
            if (emailSaved != nil){
                email = emailSaved!
            }else{
                email = ""
            }
        }
    }
    
    struct cameraSettings {
        var resolution:String
        var quality:String
        
        init(){
            let defaults = NSUserDefaults.standardUserDefaults()

            let resolutionSaved = defaults.stringForKey("settingsResolution")
            if (resolutionSaved != nil){
                resolution = resolutionSaved!
            }else{
                resolution = AVCaptureSessionPresetMedium
            }
            
            let qualitySaved = defaults.stringForKey("settingsQuality")
            if (qualitySaved != nil){
                quality = qualitySaved!
            }else{
                quality = ""
            }
        }
    }
    func getSettings() ->Array<SettingsContent>{
        var settings = Array<SettingsContent>()
        let user = userInfo()
        let camera = cameraSettings()
        
        settings.append( SettingsContent(title: getStringForType(.DownloadKamarada),section: "Avanzado",priority: 0))
        settings.append( SettingsContent(title: getStringForType(.ShareVideona),section: "Avanzado",priority: 0))
        settings.append( SettingsContent(title: getStringForType(.FollowUsOnTwitter),section: "Avanzado",priority: 0))

        settings.append( SettingsContent(title: getStringForType(.NameAccount),subTitle: user.name, section: "Mi cuenta",priority: 1))
        settings.append( SettingsContent(title: getStringForType(.UserNameAccount),subTitle: user.userName, section: "Mi cuenta",priority: 1))
        settings.append( SettingsContent(title: getStringForType(.emailAccount),subTitle: user.email, section: "Mi cuenta",priority: 1))
        
        settings.append( SettingsContent(title: getStringForType(.Resolution),subTitle: camera.resolution, section: "Camara",priority: 2))
//        settings.append( SettingsContent(title: getStringForType(.Quality),subTitle: camera.quality, section: "Camara",priority: 2))
        
        settings.append( SettingsContent(title: getStringForType(.AboutUs), section: "Más información",priority: 3))
        settings.append( SettingsContent(title: getStringForType(.PrivacyPolicy), section: "Más información",priority: 3))
        settings.append( SettingsContent(title: getStringForType(.ServiceConditions), section: "Más información",priority: 3))
        settings.append( SettingsContent(title: getStringForType(.Licenses), section: "Más información",priority: 3))
        settings.append( SettingsContent(title: getStringForType(.LegalAdvice), section: "Más información",priority: 3))
        
        settings.append( SettingsContent(title: getStringForType(.Exit), section: "Acciones de cuenta",priority: 4))

        return settings
    }
    
    func getStringForType(type:SettingsType)->String{
        switch type {
        case .DownloadKamarada:
            return "Descarga Kamarada"
        case .ShareVideona:
            return "Comparte Videona"
        case .FollowUsOnTwitter:
            return "Siguenos en Twitter"
       
        case .NameAccount:
            return "Nombre"
        case .UserNameAccount:
            return "Nombre de usuario"
        case .emailAccount:
            return "Email"
        
        case .Resolution:
            return "Resolucion"
        case .Quality:
            return "Calidad"
        
        case .AboutUs:
            return "Sobre nosotros"
        case .PrivacyPolicy:
            return "Politica de privacidad"
        case .ServiceConditions:
            return "Condiciones de servicio"
        case .Licenses:
            return "Licencias"
        case .LegalAdvice:
            return "Aviso legal"

        case .Exit:
            return "Exit"
        }
    }
}

enum SettingsType {
    case DownloadKamarada
    case ShareVideona
    case FollowUsOnTwitter

    case NameAccount
    case UserNameAccount
    case emailAccount
    
    case Resolution
    case Quality
    
    case AboutUs
    case PrivacyPolicy
    case ServiceConditions
    case Licenses
    case LegalAdvice
    
    case Exit
}