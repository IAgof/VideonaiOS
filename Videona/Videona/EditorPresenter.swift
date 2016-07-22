//
//  EditorPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 21/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class EditorPresenter: NSObject,EditorPresenterInterface {
    //MARK: - Variables VIPER
    var controller: EditorViewInterface?
//    var interactor: EditorInteractorInterface?
    
    var wireframe: EditorWireframe?
}