//
//  SavedAlbumsPresenter.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 26.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper
import GKRepresentable

protocol SavedAlbumsPresenterInput: ViperPresenterInput { }

class SavedAlbumsPresenter: ViperPresenter, SavedAlbumsPresenterInput, SavedAlbumsViewOutput {
    
    // MARK: - Props
    fileprivate var view: SavedAlbumsViewInput? {
        guard let view = self._view as? SavedAlbumsViewInput else {
            return nil
        }
        return view
    }
    
    fileprivate var router: SavedAlbumsRouterInput? {
        guard let router = self._router as? SavedAlbumsRouterInput else {
            return nil
        }
        return router
    }
    
    private let albumUseCase: AlbumUseCaseInput
    private let photoUseCase: PhotoUseCaseInput
    var viewModel: SavedAlbumsViewModel
    
    // MARK: - Initialization
    override init() {
        self.viewModel = SavedAlbumsViewModel()
        albumUseCase = AlbumUseCase()
        photoUseCase = PhotoUseCase()
        
        super.init()
        albumUseCase.subscribe(with: self)
        photoUseCase.subscribe(with: self)
    }
    
    // MARK: - SavedAlbumsPresenterInput
    
    // MARK: - SavedAlbumsViewOutput
    override func viewIsReady(_ controller: UIViewController) {
        self.view?.setupInitialState(with: self.viewModel)
        
        albumUseCase.localGetAlbums()
    }
    
    func pushPhotosListVC(with albumId: String) {
        router?.pushPhotosListVC(with: albumId)
    }
    
    func removeAlbum(with id: String) {
        albumUseCase.localRemoveAlbum(with: id)
        photoUseCase.localRemovePhotos(with: id)
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

extension SavedAlbumsPresenter: AlbumUseCaseOutput {
    
    func localGotAlbums(_ albums: [Album]) {
        makeSections(with: albums)
    }
    
    func localRemovedAlbum() {
        print("ALBUM WAS DELETED")
        albumUseCase.localGetAlbums()
    }
}

extension SavedAlbumsPresenter: PhotoUseCaseOutput {
    func localRemovedPhotos() {
        print("PHOTOS WERE DELETED")
    }
}
