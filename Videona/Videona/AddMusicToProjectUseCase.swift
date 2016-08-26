//
//  AddMusicToProjectUseCase.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 27/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class AddMusicToProjectUseCase: NSObject {
    static let sharedInstance = AddMusicToProjectUseCase()
    
    func addMusic(music:Music) {
        Project.sharedInstance.setMusic(music)
    }
}