//
//  AlbumListPresenter.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper
import GKRepresentable

protocol AlbumListPresenterInput: ViperPresenterInput { }

class AlbumListPresenter: ViperPresenter, AlbumListPresenterInput, AlbumListViewOutput {
    
    // MARK: - Props
    fileprivate var view: AlbumListViewInput? {
        guard let view = self._view as? AlbumListViewInput else {
            return nil
        }
        return view
    }
    
    fileprivate var router: AlbumListRouterInput? {
        guard let router = self._router as? AlbumListRouterInput else {
            return nil
        }
        return router
    }
    
    let albumUseCase: AlbumUseCaseInput
    var viewModel: AlbumListViewModel
    
    // MARK: - Initialization
    override init() {
        self.viewModel = AlbumListViewModel()
        albumUseCase = AlbumUseCase()
        
        super.init()
        albumUseCase.subscribe(with: self)
    }
    
    // MARK: - AlbumListPresenterInput
    
    // MARK: - AlbumListViewOutput
    override func viewIsReady(_ controller: UIViewController) {
        self.view?.setupInitialState(with: self.viewModel)
        
        albumUseCase.getAlbums()
    }
    
    func didSelect(album: Album) {
        router?.pushPhotosListVC(with: album)
    }
        
    // MARK: - Module functions
    private func makeSections(with albums: [Album]) {
        
        let mainSection = TableSectionModel()
        
        for model in albums {
            let album = AlbumCellModel(album: model)
            mainSection.rows.append(album)
        }
                
        view?.updateSections([mainSection])
    }
}

extension AlbumListPresenter: AlbumUseCaseOutput {
    
    func gotAlbums(_ albums: [Album]) {
        makeSections(with: albums)
    }
}
