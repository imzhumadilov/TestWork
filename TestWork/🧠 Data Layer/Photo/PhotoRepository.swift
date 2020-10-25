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
    func getImageWithData(photo: Photo, completion: @escaping (Swift.Result<Photo, Error>) -> Void)
    func localGetPhotos(with albumId: String, completion: @escaping (Swift.Result<[Photo], Error>) -> Void)
    func localUpdatePhotos(_ photos: [Photo], completion: @escaping (Swift.Result<[Photo], Error>) -> Void)
    func localRemovePhotos(with albumId: String, completion: @escaping (Bool) -> Void)
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
    
    func getImageWithData(photo: Photo, completion: @escaping (Swift.Result<Photo, Error>) -> Void) {
        
        guard let urlRequest = URL(string: photo.image.url) else {
            completion(.failure(CustomError(title: nil, description: AppLocalization.Errors.internalServerError.localized, code: ErrorCodes.internalServerError)))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            photo.image.data = data
            completion(.success(photo))
            
        }.resume()
    }
    
    func localGetPhotos(with albumId: String, completion: @escaping (Swift.Result<[Photo], Error>) -> Void) {
        
        let photoRequest = PhotoLocalRouter.photos(albumId: albumId).request
        
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
        
        update(photos) { (result, error) in
            if let photos = result as? [Photo] {
                completion(.success(photos))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func localRemovePhotos(with albumId: String, completion: @escaping (Bool) -> Void) {
        let request = PhotoLocalRouter.photos(albumId: albumId).request
        
        delete(request) { (success, _) in
            if success {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
