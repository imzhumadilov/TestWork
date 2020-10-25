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
        
        var method: HTTPMethod {
            switch self {
            case .getPhotos:
                return .get
            }
        }
        
        var path: String {
            switch self {
            case .getPhotos:
                return "\(AppConfiguration.serverUrl)/photos"
            }
        }
        
        var request: URLRequest? {
            switch self {
            case .getPhotos(let albumId):
                let params: [String: Any] = ["albumId": albumId]
                return RemoteFactory.request(path: path, parameters: params, headers: nil, method: method)
            }
        }
    }
}
