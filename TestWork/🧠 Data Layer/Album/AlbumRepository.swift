//
//  AlbumRepository.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//

import GKUseCase
import GKNetwork

protocol AlbumRepositoryInterface: RepositoryInterface {
    func getAlbums(completion: @escaping (Swift.Result<[Album], Error>) -> Void)
    func localGetAlbums(completion: @escaping (Swift.Result<[Album], Error>) -> Void)
    func localUpdateAlbum(_ album: Album, completion: @escaping (Swift.Result<Album, Error>) -> Void)
    func localRemoveAlbum(with id: String, completion: @escaping (Bool) -> Void)
}

class AlbumRepository: TestWorkRepository, AlbumRepositoryInterface {
    
    // MARK: - Props
    override var entityClass: AnyClass {
        return AlbumEntity.self
    }
    
    // MARK: - AlbumRepositoryInterface
    func getAlbums(completion: @escaping (Swift.Result<[Album], Error>) -> Void) {
        
        guard let request = AlbumRouter.Remote.getAlbums.request else {
            completion(.failure(CustomError(title: nil, description: AppLocalization.Errors.internalServerError.localized, code: ErrorCodes.internalServerError)))
            return
        }
        
        execute(request, response: [AlbumResponse].self) { (result, _, error) in
            
            if let mappedResult = result as? [Album],
               error == nil {
                
                completion(.success(mappedResult))
                
            } else {
                completion(.failure(CustomError(title: nil,
                                                description: AppLocalization.Errors.internalServerError.localized,
                                                code: ErrorCodes.internalServerError)))
            }
        }
    }
    
    func localGetAlbums(completion: @escaping (Swift.Result<[Album], Error>) -> Void) {
        
        let albumRequest = AlbumLocalRouter.listAll.request
        
        select(albumRequest) { (result, error) in
            if let albums = result as? [Album],
               error == nil {
                completion(.success(albums))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func localUpdateAlbum(_ album: Album, completion: @escaping (Swift.Result<Album, Error>) -> Void) {
        
        update(album) { (album, error) in
            if let album = album as? Album,
               error == nil {
                completion(.success(album))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func localRemoveAlbum(with id: String, completion: @escaping (Bool) -> Void) {
        let request = AlbumLocalRouter.album(id: id).request
        
        delete(request) { (success, _) in
            if success {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
