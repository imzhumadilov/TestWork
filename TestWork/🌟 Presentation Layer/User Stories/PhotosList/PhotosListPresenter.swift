//
//  PhotosListPresenter.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper
import GKRepresentable

protocol PhotosListPresenterInput: ViperPresenterInput { }

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
    
    private let dispatchGroup = DispatchGroup()
    
    // MARK: - Initialization
    init(album: Album) {
        viewModel = PhotosListViewModel(album: album)
        photoUseCase = PhotoUseCase()
        albumUseCase = AlbumUseCase()
        
        super.init()
        photoUseCase.subscribe(with: self)
        albumUseCase.subscribe(with: self)
    }
    
    // MARK: - PhotosListPresenterInput
    
    // MARK: - PhotosListViewOutput
    override func viewIsReady(_ controller: UIViewController) {
        view?.setupInitialState(with: viewModel)
        
        photoUseCase.getPhotos(albumId: viewModel.album.id)
    }
    
    func saveAlbum() {
        albumUseCase.localUpdateAlbum(album: viewModel.album)
        savePhotos()
    }
    
    // MARK: - Module functions
    private func makeSections(with photos: [Photo]) {
        
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
    
    private func savePhotos() {
        
        viewModel.sourcePhotos.forEach {
            dispatchGroup.enter()
            photoUseCase.getImageWithData(photo: $0)
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.photoUseCase.localUpdatePhotos(photos: self.viewModel.album.photos)
        }
    }
}

extension PhotosListPresenter: PhotoUseCaseOutput {
    
    func gotPhotos(_ photos: [Photo]) {
        viewModel.sourcePhotos = photos
        makeSections(with: photos)
    }
    
    // MARK: - Save photos
    func gotImageWithData(_ photo: Photo) {
        viewModel.photos.append(photo)
        dispatchGroup.leave()
    }
    
    func localUpdatedPhotos(_ photos: [Photo]) {
        photos.forEach { print($0.albumId, $0.id, "PHOTOS WERE SAVED") }
    }
}

extension PhotosListPresenter: AlbumUseCaseOutput {
    
    // MARK: - Save album
    func localUpdatedAlbum(_ album: Album) {
        print(album.id, "ALBUM WAS SAVED")
    }
}
