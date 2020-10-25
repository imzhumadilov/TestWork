//
//  AlbumUseCase.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//

import GKUseCase

protocol AlbumUseCaseInput: UseCaseInput {
    func getAlbums()
    func localGetAlbums()
    func localUpdateAlbum(album: Album)
}

protocol AlbumUseCaseOutput: UseCaseOutput {
    func gotAlbums(_ albums: [Album])
    func loadedAlbumError(_ error: Error)
    func localGotAlbums(_ albums: [Album])
    func localUpdatedAlbum(_ album: Album)
    func localLoadedAlbumError(_ error: Error)
    func noInternetConnection()
}

extension AlbumUseCaseOutput {
    func gotAlbums(_ albums: [Album]) { }
    func loadedAlbumError(_ error: Error) { }
    func localGotAlbums(_ albums: [Album]) { }
    func localUpdatedAlbum(_ album: Album) { }
    func localLoadedAlbumError(_ error: Error) { }
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
                self?.output?.loadedAlbumError(error)
            }
        }
    }
    
    func localGetAlbums() {
        albumRepository.localGetAlbums { [weak self] (result) in
            
            switch result {
            
            case .success(let albums):
                self?.output?.localGotAlbums(albums)
                
            case .failure(let error):
                self?.output?.localLoadedAlbumError(error)
            }
        }
    }
    
    func localUpdateAlbum(album: Album) {
        albumRepository.localUpdateAlbum(album) { [weak self] (result) in
            
            switch result {
            
            case .success(let album):
                self?.output?.localUpdatedAlbum(album)
                
            case .failure(let error):
                self?.output?.localLoadedAlbumError(error)
            }
        }
    }
}
