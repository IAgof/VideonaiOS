//
// Created by VIPER
// Copyright (c) 2016 VIPER. All rights reserved.
//

import Foundation

class RecordePresenter: RecordePresenterProtocol, RecordeInteractorOutputProtocol
{
    weak var view: RecordeViewProtocol?
    var interactor: RecordeInteractorInputProtocol?
    var wireFrame: RecordeWireFrameProtocol?
    
    init() {}
}