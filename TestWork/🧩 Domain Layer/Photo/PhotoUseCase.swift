//
//  PhotoUseCase.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//

import GKUseCase

protocol PhotoUseCaseInput: UseCaseInput {
    func getPhotos(albumId: String)
    func getImageWithData(photos: [Photo])
    func localGetPhotos(with albumId: String)
    func localUpdatePhotos(photos: [Photo])
    func localRemovePhotos(with albumId: String)
}

protocol PhotoUseCaseOutput: UseCaseOutput {
    func gotPhotos(_ photos: [Photo])
    func gotPhotosWithData(_ photos: [Photo])
    func loadedPhotoError(_ error: Error)
    func localGotPhotos(_ photos: [Photo])
    func localUpdatedPhotos(_ photos: [Photo])
    func localLoadedPhotoError(_ error: Error)
    func localRemovedPhotos()
    func noInternetConnectionPhoto()
}

extension PhotoUseCaseOutput {
    func gotPhotos(_ photos: [Photo]) { }
    func gotPhotosWithData(_ photos: [Photo]) { }
    func loadedPhotoError(_ error: Error) { }
    func localGotPhotos(_ photos: [Photo]) { }
    func localUpdatedPhotos(_ photos: [Photo]) { }
    func localLoadedPhotoError(_ error: Error) { }
    func localRemovedPhotos() { }
    func noInternetConnectionPhoto() { }
}

class PhotoUseCase: UseCase, PhotoUseCaseInput {
    
    // MARK: - Props
    private var output: PhotoUseCaseOutput? {
        guard let output = self._output as? PhotoUseCaseOutput else {
            return nil
        }
        return output
    }
    
    private lazy var photoRepository: PhotoRepositoryInterface = PhotoRepository()
    
    // MARK: - PhotoUseCaseInput
    func getPhotos(albumId: String) {
        guard ReachabilityManager.isConnectedToInternet else {
            output?.noInternetConnectionPhoto()
            return
        }
        
        photoRepository.getPhotos(albumId: albumId) { [weak self] (result) in
            
            switch result {
            
            case .success(let photos):
                self?.output?.gotPhotos(photos)
                
            case .failure(let error):
                self?.output?.loadedPhotoError(error)
            }
        }
    }
    
    func getImageWithData(photos: [Photo]) {
        
        guard ReachabilityManager.isConnectedToInternet else {
            output?.noInternetConnectionPhoto()
            return
        }
        
        let dispatchGroup = DispatchGroup()
        var photosWithData = [Photo]()
        
        photos.forEach {
            dispatchGroup.enter()
            photoRepository.getImageWithData(photo: $0) { [weak self] (result) -> Void in
                
                switch result {
                
                case .success(let photo):
                    photosWithData.append(photo)
                    dispatchGroup.leave()
                    
                case .failure(let error):
                    self?.output?.loadedPhotoError(error)
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.output?.gotPhotosWithData(photosWithData)
        }
    }
    
    func localGetPhotos(with albumId: String) {
        photoRepository.localGetPhotos(with: albumId) { [weak self] (result) in
            
            switch result {
            
            case .success(let photos):
                self?.output?.localGotPhotos(photos)
                
            case .failure(let error):
                self?.output?.localLoadedPhotoError(error)
            }
        }
    }
    
    func localUpdatePhotos(photos: [Photo]) {
        photoRepository.localUpdatePhotos(photos) { [weak self] (result) in
            
            switch result {
            
            case .success(let photos):
                self?.output?.localUpdatedPhotos(photos)
                
            case .failure(let error):
                self?.output?.localLoadedPhotoError(error)
            }
        }
    }
    
    func localRemovePhotos(with albumId: String) {
        photoRepository.localRemovePhotos(with: albumId) { [weak self] (success) in
            if success {
                self?.output?.localRemovedPhotos()
            }
        }
    }
}
