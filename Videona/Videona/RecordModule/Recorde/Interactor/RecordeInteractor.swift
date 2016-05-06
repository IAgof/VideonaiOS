//
// Created by VIPER
// Copyright (c) 2016 VIPER. All rights reserved.
//

import Foundation

class RecordeInteractor: RecordeInteractorInputProtocol
{
    weak var presenter: RecordeInteractorOutputProtocol?
    var APIDataManager: RecordeAPIDataManagerInputProtocol?
    var localDatamanager: RecordeLocalDataManagerInputProtocol?
    
    init() {}
}