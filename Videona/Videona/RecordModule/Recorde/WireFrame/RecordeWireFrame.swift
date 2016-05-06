//
// Created by VIPER
// Copyright (c) 2016 VIPER. All rights reserved.
//

import Foundation

class RecordeWireFrame: RecordeWireFrameProtocol
{
    class func presentRecordeModule(fromView view: AnyObject)
    {
        // Generating module components
        var view: RecordeViewProtocol = RecordeView()
        var presenter: protocol<RecordePresenterProtocol, RecordeInteractorOutputProtocol> = RecordePresenter()
        var interactor: RecordeInteractorInputProtocol = RecordeInteractor()
        var APIDataManager: RecordeAPIDataManagerInputProtocol = RecordeAPIDataManager()
        var localDataManager: RecordeLocalDataManagerInputProtocol = RecordeLocalDataManager()
        var wireFrame: RecordeWireFrameProtocol = RecordeWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
    }
}