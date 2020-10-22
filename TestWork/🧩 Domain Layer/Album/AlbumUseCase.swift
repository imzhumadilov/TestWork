//
//  AlbumUseCase.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//

import GKUseCase

protocol AlbumUseCaseInput: UseCaseInput {
    func getAlbums()
}

protocol AlbumUseCaseOutput: UseCaseOutput {
    func gotAlbums(_ albums: [Album])
    func loaded(_ error: Error)
    func noInternetConnection()
}

extension AlbumUseCaseOutput {
    func gotAlbums(_ albums: [Album]) { }
    func loaded(_ error: Error) { }
    func noInternetConnection() { }
}

class AlbumUseCase: UseCase, AlbumUseCaseInput {
    
    // MARK: - Props
    private var output: AlbumUseCaseOutput? {
        
        guard let output = self._output as? AlbumUseCaseOutput else {
            return nil
        }
        
        return output
    }
    
    private lazy var albumRepository: AlbumRepositoryInterface = AlbumRepository()
    
    // MARK: - AlbumUseCaseInput
    func getAlbums() {
        
        guard ReachabilityManager.isConnectedToInternet else {
            output?.noInternetConnection()
            return
        }
        
        albumRepository.getAlbums { [weak self] (result) -> (Void) in
            
            switch result {
            
            case .success(let albums):
                self?.output?.gotAlbums(albums)
                
            case .failure(let error):
                self?.output?.loaded(error)
            }
        }
    }
}
