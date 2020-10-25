//
//  AlbumEntity.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 23.10.2020.
//

import GKCoreData
import CoreData

@objc(AlbumEntity)
public class AlbumEntity: NSManagedObject {
    @NSManaged public var id: String
    @NSManaged public var title: String
}

extension AlbumEntity: LocalMappable {
    
    public func mapEntityToDomain() -> AnyObject {
        return Album(id: id,
                     title: title,
                     photos: []) as AnyObject
    }
    
    public func mapEntityFromDomain(data: AnyObject) {
        
        guard let album = data as? Album else { return }
    
        id = album.id
        title = album.title
    }
}
