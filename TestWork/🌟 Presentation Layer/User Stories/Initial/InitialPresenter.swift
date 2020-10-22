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
    
    let albumUseCase: AlbumUseCaseInput
    var viewModel: InitialViewModel
    
    // MARK: - Initialization
    override init() {
        self.viewModel = InitialViewModel()
        albumUseCase = AlbumUseCase()
    }
    
    // MARK: - InitialPresenterInput
    
    // MARK: - InitialViewOutput
    override func viewIsReady(_ controller: UIViewController) {
        view?.setupInitialState(with: viewModel)
        albumUseCase.getAlbums()
        albumUseCase.subscribe(with: self)
    }
    
    // MARK: - Module functions
    private func makeSections(with albums: [Album]) {
        
        let mainSection = TableSectionModel()
        
        for model in albums {
            let album = AlbumCellModel(text: model.title)
            mainSection.rows.append(album)
        }
                
        view?.updateSections([mainSection])
    }
}

extension InitialPresenter: AlbumUseCaseOutput {
    
    func gotAlbums(_ albums: [Album]) {
        makeSections(with: albums)
    }
}
