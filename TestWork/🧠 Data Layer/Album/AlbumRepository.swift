//
//  AlbumRepository.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//

import GKUseCase
import GKNetwork

protocol AlbumRepositoryInterface: RepositoryInterface {
    func getAlbums(completion: @escaping (Swift.Result<[Album], Error>) -> (Void))
}

class AlbumRepository: Repository, AlbumRepositoryInterface {
    
    // MARK: - Props
    
    // MARK: - AlbumRepositoryInterface
    func getAlbums(completion: @escaping (Swift.Result<[Album], Error>) -> (Void)) {
        
        guard let request = AlbumRouter.Remote.getAlbums.request else {
            completion(.failure(CustomError(title: nil, description: AppLocalization.Errors.internalServerError.localized, code: ErrorCodes.internalServerError)))
            return
        }
        
        execute(request, response: [AlbumResponse].self) { (result, response, error) in

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
}
