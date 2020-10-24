//
//  AlbumUseCase.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//

import GKUseCase

protocol AlbumUseCaseInput: UseCaseInput {
    func getAlbums()
    func getLocalAlbums()
    func updateLocalAlbum(album: Album)
}

protocol AlbumUseCaseOutput: UseCaseOutput {
    func gotAlbums(_ albums: [Album])
    func loaded(_ error: Error)
    func loadedLocal(_ error: Error)
    func gotLocalAlbums(_ albums: [Album])
    func updatedLocalAlbum(_ album: Album)
    func noInternetConnection()
}

extension AlbumUseCaseOutput {
    func gotAlbums(_ albums: [Album]) { }
    func loaded(_ error: Error) { }
    func gotLocalAlbums(_ albums: [Album]) { }
    func updatedLocalAlbum(_ album: Album) { }
    func loadedLocal(_ error: Error) { }
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
        
        albumRepository.getAlbums { [weak self] (result) in
            
            switch result {
            
            case .success(let albums):
                self?.output?.gotAlbums(albums)
                
            case .failure(let error):
                self?.output?.loaded(error)
            }
        }
    }
    
    func getLocalAlbums() {
        albumRepository.localAlbumsList { [weak self] (result) in
            
            switch result {
            
            case .success(let albums):
                self?.output?.gotLocalAlbums(albums)
                
            case .failure(let error):
                self?.output?.loadedLocal(error)
            }
        }
    }
    
    func updateLocalAlbum(album: Album) {
        albumRepository.localUpdateAlbum(album) { [weak self] (result) in
            
            switch result {
            
            case .success(let album):
                self?.output?.updatedLocalAlbum(album)
                
            case .failure(let error):
                self?.output?.loadedLocal(error)
            }
        }
    }
}
