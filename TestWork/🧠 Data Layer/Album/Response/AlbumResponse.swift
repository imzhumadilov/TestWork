//
//  AlbumResponse.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//

import GKNetwork

struct AlbumResponse: Codable {
    
    // MARK: - Props
    let id: Int?
    let title: String?
    
    // MARK: - CodingKey
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
}

// MARK: - RemoteMappable
extension AlbumResponse: RemoteMappable {
    func mapResponseToDomain() -> AnyObject? {
        return Album(id: String(id ?? 0),
                     title: title ?? "") as AnyObject
    }
}

