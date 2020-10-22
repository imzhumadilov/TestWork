//
//  PhotosListPresenter.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper
import GKRepresentable

protocol PhotosListPresenterInput: ViperPresenterInput {
    func configure(with album: Album)
}

class PhotosListPresenter: ViperPresenter, PhotosListPresenterInput, PhotosListViewOutput {
    
    // MARK: - Props
    fileprivate var view: PhotosListViewInput? {
        guard let view = self._view as? PhotosListViewInput else {
            return nil
        }
        return view
    }
    
    fileprivate var router: PhotosListRouterInput? {
        guard let router = self._router as? PhotosListRouterInput else {
            return nil
        }
        return router
    }
    
    let photoUseCase: PhotoUseCaseInput
    var viewModel: PhotosListViewModel
    
    // MARK: - Initialization
    override init() {
        viewModel = PhotosListViewModel()
        photoUseCase = PhotoUseCase()
    }
    
    // MARK: - PhotosListPresenterInput
    func configure(with album: Album) {
        
        photoUseCase.getPhotos(albumId: album.id)
    }
    
    // MARK: - PhotosListViewOutput
    override func viewIsReady(_ controller: UIViewController) {
        view?.setupInitialState(with: viewModel)
        
        photoUseCase.subscribe(with: self)
    }
    
    func didSelect() {
//        router?.pushPhotosListVC(with: album)
    }
        
    // MARK: - Module functions
    private func makeSections(with photos: [Photo]) {
        
        let mainSection = TableSectionModel()
        
        for model in photos {
            let album = PhotoCellModel(photo: model)
            mainSection.rows.append(album)
        }
                
        view?.updateSections([mainSection])
    }
}

extension PhotosListPresenter: PhotoUseCaseOutput {

    func gotPhotos(_ photos: [Photo]) {
        makeSections(with: photos)
    }
}
