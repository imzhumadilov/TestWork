//
//  PhotoUseCase.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//

import GKUseCase

protocol PhotoUseCaseInput: UseCaseInput {
    func getPhotos(albumId: String)
}

protocol PhotoUseCaseOutput: UseCaseOutput {
    func gotPhotos(_ photos: [Photo])
    func loaded(_ error: Error)
    func noInternetConnection()
}

extension PhotoUseCaseOutput {
    func gotPhotos(_ photos: [Photo]) { }
    func loaded(_ error: Error) { }
    func noInternetConnection() { }
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
            output?.noInternetConnection()
            return
        }
        
        photoRepository.getPhotos(albumId: albumId) { [weak self] (result) -> (Void) in
            
            switch result {
            
            case .success(let photos):
                self?.output?.gotPhotos(photos)
                
            case .failure(let error):
                self?.output?.loaded(error)
            }
        }
    }
}

