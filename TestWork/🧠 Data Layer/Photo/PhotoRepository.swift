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
    func getImageData(url: String, completion: @escaping (Swift.Result<Data, Error>) -> (Void))
}

class PhotoRepository: Repository, PhotoRepositoryInterface {
    
    // MARK: - Props
    
    // MARK: - AlbumRepositoryInterface
    func getPhotos(albumId: String, completion: @escaping (Swift.Result<[Photo], Error>) -> (Void)) {
        
        guard let request = PhotoRouter.Remote.getPhotos(albumId: albumId).request else {
            completion(.failure(CustomError(title: nil, description: AppLocalization.Errors.internalServerError.localized, code: ErrorCodes.internalServerError)))
            return
        }
        
        execute(request, response: [PhotoResponse].self) { (result, response, error) in
            
            if let mappedResult = result as? [Photo],
               error == nil {
                
                completion(.success(mappedResult))
                
            } else {
                completion(.failure(CustomError(title: nil,
                                                description: AppLocalization.Errors.internalServerError.localized,
                                                code: ErrorCodes.internalServerError)))
            }
        }
    }
    
    func getImageData(url: String, completion: @escaping (Swift.Result<Data, Error>) -> (Void)) {
        
        guard let request = PhotoRouter.Remote.getPhoto(url: url).request else {
            completion(.failure(CustomError(title: nil, description: AppLocalization.Errors.internalServerError.localized, code: ErrorCodes.internalServerError)))
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                completion(.success(data))
            }
            
        }.resume()
    }
}

