//
//  AlbumRouter.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//

import GKNetwork

enum AlbumRouter {
    
    enum Remote {
        case getAlbums
        
        var method: HTTPMethod {
            switch self {
            case .getAlbums:
                return .get
            }
        }
        
        var path: String {
            switch self {
            case .getAlbums:
                return "\(AppConfiguration.serverUrl)/albums"
            }
        }
        
        var request: URLRequest? {
            switch self {
            case .getAlbums:
                return RemoteFactory.request(path: path, parameters: nil, headers: nil, method: method)
            }
        }
    }
}
