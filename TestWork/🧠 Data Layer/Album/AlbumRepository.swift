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
    func localAlbumsList(completion: @escaping (Swift.Result<[Album], Error>) -> Void)
    func localUpdateAlbum(_ album: Album, completion: @escaping (Swift.Result<Album, Error>) -> Void)
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
    
    func localAlbumsList(completion: @escaping (Swift.Result<[Album], Error>) -> Void) {
        
        let request = AlbumLocalRouter.listAll.request
        
        select(request) { (result, error) in
            if let mappedResult = result as? [Album],
               error == nil {
                completion(.success(mappedResult))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func localUpdateAlbum(_ album: Album, completion: @escaping (Swift.Result<Album, Error>) -> Void) {
        
        update(album) { (result, error) in
            if let result = result as? Album {
                completion(.success(result))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
}
