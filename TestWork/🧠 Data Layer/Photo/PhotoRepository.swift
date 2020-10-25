//
//  PhotoRepository.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//

import GKUseCase
import GKNetwork

protocol PhotoRepositoryInterface: RepositoryInterface {
    func getPhotos(albumId: String, completion: @escaping (Swift.Result<[Photo], Error>) -> Void)
    func getImageData(url: String, completion: @escaping (Swift.Result<Data, Error>) -> Void)
    func localGetPhotos(completion: @escaping (Swift.Result<[Photo], Error>) -> Void)
    func localUpdatePhotos(_ photos: [Photo], completion: @escaping (Swift.Result<[Photo], Error>) -> Void)
}

class PhotoRepository: TestWorkRepository, PhotoRepositoryInterface {
    
    // MARK: - Props
    override var entityClass: AnyClass {
        return PhotoEntity.self
    }
    
    // MARK: - AlbumRepositoryInterface
    func getPhotos(albumId: String, completion: @escaping (Swift.Result<[Photo], Error>) -> Void) {
        
        guard let request = PhotoRouter.Remote.getPhotos(albumId: albumId).request else {
            completion(.failure(CustomError(title: nil, description: AppLocalization.Errors.internalServerError.localized, code: ErrorCodes.internalServerError)))
            return
        }
        
        execute(request, response: [PhotoResponse].self) { (result, _, error) in
            
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
    
    func getImageData(url: String, completion: @escaping (Swift.Result<Data, Error>) -> Void) {
        
        guard let request = PhotoRouter.Remote.getPhoto(url: url).request else {
            completion(.failure(CustomError(title: nil, description: AppLocalization.Errors.internalServerError.localized, code: ErrorCodes.internalServerError)))
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            completion(.success(data))
            
        }.resume()
    }
    
    func localGetPhotos(completion: @escaping (Swift.Result<[Photo], Error>) -> Void) {
        
        let photoRequest = PhotoLocalRouter.listAll.request
        
        select(photoRequest) { (result, error) in
            if let photos = result as? [Photo],
               error == nil {
                completion(.success(photos))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func localUpdatePhotos(_ photos: [Photo], completion: @escaping (Swift.Result<[Photo], Error>) -> Void) {
        
        update(photos) { (photos, error) in
            if let photos = photos as? [Photo] {
                completion(.success(photos))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
}
