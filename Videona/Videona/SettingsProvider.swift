//
//  SettingsProvider.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 17/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class SettingsProvider:NSObject{
    
    func getSettings() ->Array<SettingsContent>{
        var settings = Array<SettingsContent>()
        
        settings.append( SettingsContent(title: "Descarga Kamarada",section: "Avanzado",priority: 0))
        settings.append( SettingsContent(title: "Comparte Videona",section: "Avanzado",priority: 0))
        settings.append( SettingsContent(title: "Siguenos en Twitter",section: "Avanzado",priority: 0))
        settings.append( SettingsContent(title: "Prueba Videona beta", section: "Avanzado",priority: 0))

        settings.append( SettingsContent(title: "Nombre", section: "Mi cuenta",priority: 1))
        settings.append( SettingsContent(title: "Nombre de usuario", section: "Mi cuenta",priority: 1))
        settings.append( SettingsContent(title: "email", section: "Mi cuenta",priority: 1))
        
        settings.append( SettingsContent(title: "Resolucion", section: "Camara",priority: 2))
        settings.append( SettingsContent(title: "Calidad", section: "Camara",priority: 2))
        
        settings.append( SettingsContent(title: "Sobre nosotros", section: "Más información",priority: 3))
        settings.append( SettingsContent(title: "Politica de privacidad", section: "Más información",priority: 3))
        settings.append( SettingsContent(title: "Condiciones de servicio", section: "Más información",priority: 3))
        settings.append( SettingsContent(title: "Licencias", section: "Más información",priority: 3))
        settings.append( SettingsContent(title: "Aviso legal", section: "Más información",priority: 3))
        
        settings.append( SettingsContent(title: "Salir", section: "Acciones de cuenta",priority: 4))

        return settings
    }
    
//    func getSections()->Array<String>{
//        var sections  = Array<String>()
//        
//        sections.append("Avanzado")
//        sections.append("Cuenta")
//        sections.append("Camara")
//        sections.append("Mas informacion")
//        sections.append("Condiciones de cuenta")
//        
//        return sections
//    }
}