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
    
    private let photoUseCase: PhotoUseCaseInput
    private let albumUseCase: AlbumUseCaseInput
    private var viewModel: PhotosListViewModel
    
    // MARK: - Initialization
    override init() {
        viewModel = PhotosListViewModel()
        photoUseCase = PhotoUseCase()
        albumUseCase = AlbumUseCase()
        
        super.init()
        photoUseCase.subscribe(with: self)
        albumUseCase.subscribe(with: self)
    }
    
    // MARK: - PhotosListPresenterInput
    func configure(with album: Album) {
        viewModel.album = album
    }
    
    // MARK: - PhotosListViewOutput
    override func viewIsReady(_ controller: UIViewController) {
        view?.setupInitialState(with: viewModel)
        
        guard let albumId = viewModel.album?.id else { return }
        photoUseCase.getPhotos(albumId: albumId)
    }
    
    func saveAlbum() {
        guard let album = viewModel.album else { return }
        
        albumUseCase.localUpdateAlbum(album: album)
        photoUseCase.localUpdatePhotos(photos: album.photos)
    }
    
    // MARK: - Module functions
    private func makeSections(with photos: [Photo]) {
        
        viewModel.sourcePhotos = photos
        
        let mainSection = TableSectionModel()
        
        for photo in photos {
            let photoModel = PhotoCellModel(title: photo.title,
                                            imageUrl: photo.image.url,
                                            thumbnailImageUrl: photo.image.thumbnailUrl)
            photoModel.action = { [weak self] url in
                self?.router?.pushFullImageVC(with: url)
            }
            mainSection.rows.append(photoModel)
        }
        view?.updateSections([mainSection])
    }
}

extension PhotosListPresenter: PhotoUseCaseOutput {
    
    func gotPhotos(_ photos: [Photo]) {
        makeSections(with: photos)
    }
    
    func localUpdatedAlbum(_ album: Album) {
        print(album.id, "ALBUM")
    }
}

extension PhotosListPresenter: AlbumUseCaseOutput {
    
    func localUpdatedPhotos(_ photos: [Photo]) {
        photos.forEach { print($0.albumId, $0.id, "PHOTO") }
    }
}
