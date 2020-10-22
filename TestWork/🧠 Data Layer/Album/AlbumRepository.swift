//
//  AlbumRepository.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//

import Foundation
import GKUseCase
import GKNetwork

protocol AlbumRepositoryInterface: RepositoryInterface {
    func getAlbums(completion: @escaping (Swift.Result<[Album], Error>) -> (Void))
}

class AlbumRepository: AlbumRepositoryInterface {
    
    // MARK: - Props
    let remoteWorker = RemoteWorker()
    
    // MARK: - AlbumRepositoryInterface
    func getAlbums(completion: @escaping (Swift.Result<[Album], Error>) -> (Void)) {
        
        guard let request = AlbumRouter.Remote.getAlbums.request else {
            completion(.failure(CustomError(title: nil, description: AppLocalization.Errors.internalServerError.localized, code: ErrorCodes.internalServerError)))
            return
        }
        
        remoteWorker.execute(request, model: [AlbumResponse].self) { (result, response, error) in
            
            if let mappedResult = result?.compactMap({ $0.mapResponseToDomain() }) as? [Album],
               error == nil {
                
                completion(.success(mappedResult))
                
//            } else if response?.statusCode == ErrorCodes.userBlocked.rawValue {
//
//                UserSession.current.showBlockedScreen()
//                completion(nil, nil)
                
            } else {
                completion(.failure(CustomError(title: nil,
                                                description: AppLocalization.Errors.internalServerError.localized,
                                                code: ErrorCodes.internalServerError)))
            }
        }
    }
}
