//
//  PhotoResponse.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//

import GKNetwork

struct PhotoResponse: Codable {
    
    // MARK: - Props
    let albumId: Int?
    let id: Int?
    let title: String?
    let url: String?
    let thumbnailUrl: String?
    
    // MARK: - CodingKey
    enum CodingKeys: String, CodingKey {
        case albumId = "albumId"
        case id = "id"
        case title = "title"
        case url = "url"
        case thumbnailUrl = "thumbnailUrl"
    }
}

// MARK: - RemoteMappable
extension PhotoResponse: RemoteMappable {
    func mapResponseToDomain() -> AnyObject? {
        return Photo(albumId: String(albumId ?? 0) ,
                     id: String(id ?? 0),
                     title: title ?? "",
                     image: Image(url: url ?? "",
                                  thumbnailUrl: thumbnailUrl ?? "",
                                  data: Data())) as AnyObject
    }
}
