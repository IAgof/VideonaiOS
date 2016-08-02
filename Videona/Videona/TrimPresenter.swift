//
//  TrimPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 1/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class TrimPresenter: NSObject,TrimPresenterInterface {
    //MARK: - Variables VIPER
//    var controller: TrimViewInterface? //O tengo referencia a uno u a otro, pero no a los dos
//    var delegate:MusicPresenterDelegate?
//    var interactor: TrimInteractorInterface?
    var wireframe: TrimWireframe?
        
    var playerPresenter: PlayerPresenterInterface?
    var playerWireframe: PlayerWireframe?
}