//
//  SavedFullImagePresenter.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 26.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper

protocol SavedFullImagePresenterInput: ViperPresenterInput { }

class SavedFullImagePresenter: ViperPresenter, SavedFullImagePresenterInput, SavedFullImageViewOutput {
    
    // MARK: - Props
    fileprivate var view: SavedFullImageViewInput? {
        guard let view = self._view as? SavedFullImageViewInput else {
            return nil
        }
        return view
    }
    
    fileprivate var router: SavedFullImageRouterInput? {
        guard let router = self._router as? SavedFullImageRouterInput else {
            return nil
        }
        return router
    }
    
    var viewModel: SavedFullImageViewModel
    
    // MARK: - Initialization
    init(imageData: Data) {
        viewModel = SavedFullImageViewModel(imageData: imageData)
    }
    
    // MARK: - SavedFullImagePresenterInput
    
    // MARK: - SavedFullImageViewOutput
    override func viewIsReady(_ controller: UIViewController) {
        self.view?.setupInitialState(with: self.viewModel)
        
        view?.setupImage(with: viewModel.imageData)
    }
        
    // MARK: - Module functions
}
