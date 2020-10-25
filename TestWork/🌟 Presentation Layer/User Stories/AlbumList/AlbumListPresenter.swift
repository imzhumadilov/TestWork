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
    
    private let albumUseCase: AlbumUseCaseInput
    private var viewModel: AlbumListViewModel
    
    // MARK: - Initialization
    override init() {
        viewModel = AlbumListViewModel()
        albumUseCase = AlbumUseCase()
        
        super.init()
        albumUseCase.subscribe(with: self)
    }
    
    // MARK: - AlbumListPresenterInput
    
    // MARK: - AlbumListViewOutput
    override func viewIsReady(_ controller: UIViewController) {
        self.view?.setupInitialState(with: viewModel)
        
        albumUseCase.getAlbums()
    }
    
    func pushPhotosListVC(with albumId: String) {
        guard let album = viewModel.sourceAlbums.first(where: { $0.id == albumId }) else { return }
        
        router?.pushPhotosListVC(with: album)
    }
        
    // MARK: - Module functions
    private func makeSections(with albums: [Album]) {
        
        viewModel.sourceAlbums = albums
        
        let mainSection = TableSectionModel()
        
        for album in albums {
            
            let albumModel = AlbumCellModel(title: album.title,
                                            id: album.id)
            mainSection.rows.append(albumModel)
        }
                
        view?.updateSections([mainSection])
    }
}

extension AlbumListPresenter: AlbumUseCaseOutput {
    
    func gotAlbums(_ albums: [Album]) {
        makeSections(with: albums)
    }
}
