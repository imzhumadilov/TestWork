//
//  PhotoEntity.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 23.10.2020.
//

import GKCoreData
import CoreData

@objc(PhotoEntity)
public class PhotoEntity: NSManagedObject {
    @NSManaged public var albumId: String
    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var imageUrl: String
    @NSManaged public var imageThumbnailUrl: String
    @NSManaged public var imageData: Data
}

extension PhotoEntity: LocalMappable {
    
    public func mapEntityToDomain() -> AnyObject {
        return Photo(albumId: albumId,
                     id: id,
                     title: title,
                     image: Image(url: imageUrl,
                                  thumbnailUrl: imageThumbnailUrl,
                                  data: imageData)) as AnyObject
    }
    
    public func mapEntityFromDomain(data: AnyObject) {
        
        guard let photo = data as? Photo else { return }
    
        albumId = photo.albumId
        id = photo.id
        title = photo.title
        imageUrl = photo.image.url
        imageThumbnailUrl = photo.image.thumbnailUrl
        imageData = photo.image.data
    }
}
