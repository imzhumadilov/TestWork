//
//  PhotoRepository.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//

import GKUseCase
import GKNetwork

protocol PhotoRepositoryInterface: RepositoryInterface {
    func getPhotos(albumId: String, completion: @escaping (Swift.Result<[Photo], Error>) -> (Void))
}

class PhotoRepository: PhotoRepositoryInterface {
    
    // MARK: - Props
    let remoteWorker = RemoteWorker()
    
    // MARK: - AlbumRepositoryInterface
    func getPhotos(albumId: String, completion: @escaping (Swift.Result<[Photo], Error>) -> (Void)) {
        
        guard let request = PhotoRouter.Remote.getPhotos(albumId: albumId).request else {
            completion(.failure(CustomError(title: nil, description: AppLocalization.Errors.internalServerError.localized, code: ErrorCodes.internalServerError)))
            return
        }
        
        remoteWorker.execute(request, model: [PhotoResponse].self) { (result, response, error) in
            
            if let mappedResult = result?.compactMap({ $0.mapResponseToDomain() }) as? [Photo],
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

