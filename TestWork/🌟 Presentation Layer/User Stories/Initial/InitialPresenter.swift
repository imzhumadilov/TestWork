//
//  InitialPresenter.swift
//  Arcana
//
//  Created by  Кирилл on 10/26/19.
//  Copyright © 2019 AppCraft. All rights reserved.
//

import GKViper
import GKRepresentable

protocol InitialPresenterInput: ViperPresenterInput { }

class InitialPresenter: ViperPresenter, InitialPresenterInput, InitialViewOutput {
    
    // MARK: - Props
    fileprivate var view: InitialViewInput? {
        guard let view = self._view as? InitialViewInput else {
            return nil
        }
        return view
    }
    
    fileprivate var router: InitialRouterInput? {
        guard let router = self._router as? InitialRouterInput else {
            return nil
        }
        return router
    }
    
    var viewModel: InitialViewModel
    
    // MARK: - Initialization
    override init() {
        self.viewModel = InitialViewModel()
    }
    
    // MARK: - InitialPresenterInput
    
    // MARK: - InitialViewOutput
    override func viewIsReady(_ controller: UIViewController) {
        view?.setupInitialState(with: viewModel)
        
        
    }
    
    func viewWillAppear() {
//        checkConnection()
    }
    
    // MARK: - Module functions
//    private func checkConnection() {
//        guard ReachabilityManager.isConnectedToInternet else {
//            if self.timer == nil {
//                self.showToast(message: AppLocalization.Errors.noInternetConnection.localized, style: .info)
//            }
//            self.timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false, block: { _ in
//                self.checkConnection()
//            })
//            return
//        }
//        self.timer?.invalidate()
//        self.prepareApplication()
//      
//    }
//    
//    private func prepareApplication() {
//        if UserSession.current.getAuthToken() == nil {
//            self.router?.showAuth()
//        } else {
//            self.userUseCase.getUser()
//        }
//    }
}
