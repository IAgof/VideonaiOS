//
// Created by VIPER
// Copyright (c) 2016 VIPER. All rights reserved.
//

import Foundation

protocol RecordeViewProtocol: class
{
    var presenter: RecordePresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
}

protocol RecordeWireFrameProtocol: class
{
    class func presentRecordeModule(fromView view: AnyObject)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
}

protocol RecordePresenterProtocol: class
{
    var view: RecordeViewProtocol? { get set }
    var interactor: RecordeInteractorInputProtocol? { get set }
    var wireFrame: RecordeWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
}

protocol RecordeInteractorOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
}

protocol RecordeInteractorInputProtocol: class
{
    var presenter: RecordeInteractorOutputProtocol? { get set }
    var APIDataManager: RecordeAPIDataManagerInputProtocol? { get set }
    var localDatamanager: RecordeLocalDataManagerInputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
}

protocol RecordeDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
    */
}

protocol RecordeAPIDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
}

protocol RecordeLocalDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
}
