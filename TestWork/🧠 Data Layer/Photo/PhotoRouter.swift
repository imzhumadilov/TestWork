//
//  PhotoRouter.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//

import GKNetwork

enum PhotoRouter {
    
    enum Remote {
        case getPhotos(albumId: String)
        case getPhoto(url: String)
        
        var method: HTTPMethod {
            switch self {
            case .getPhotos:
                return .get
            case .getPhoto:
                return .get
            }
        }
        
        var path: String {
            switch self {
            case .getPhotos:
                return "\(AppConfiguration.serverUrl)/photos"
            case .getPhoto(let url):
                return url
            }
        }
        
        var request: URLRequest? {
            switch self {
            case .getPhotos(let albumId):
                let params: [String: Any] = ["albumId": albumId]
                return RemoteFactory.request(path: path, parameters: params, headers: nil, method: method)
            case .getPhoto:
                return RemoteFactory.request(path: path, parameters: nil, headers: nil, method: method)
            }
        }
    }
}
