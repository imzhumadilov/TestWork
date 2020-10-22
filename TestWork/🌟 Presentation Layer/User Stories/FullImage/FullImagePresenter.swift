//
//  FullImagePresenter.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper

protocol FullImagePresenterInput: ViperPresenterInput {
    func configure(with imageUrl: String)
}

class FullImagePresenter: ViperPresenter, FullImagePresenterInput, FullImageViewOutput {
    
    // MARK: - Props
    fileprivate var view: FullImageViewInput? {
        guard let view = self._view as? FullImageViewInput else {
            return nil
        }
        return view
    }
    
    fileprivate var router: FullImageRouterInput? {
        guard let router = self._router as? FullImageRouterInput else {
            return nil
        }
        return router
    }
    
    var viewModel: FullImageViewModel
    
    // MARK: - Initialization
    override init() {
        self.viewModel = FullImageViewModel()
    }
    
    // MARK: - FullImagePresenterInput
    func configure(with imageUrl: String) {
        print(imageUrl)
    }
    
    // MARK: - FullImageViewOutput
    override func viewIsReady(_ controller: UIViewController) {
        self.view?.setupInitialState(with: self.viewModel)
    }
        
    // MARK: - Module functions
}
