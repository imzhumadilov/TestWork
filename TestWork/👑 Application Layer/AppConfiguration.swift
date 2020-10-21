//
//  AppConfiguration.swift
//  Arcana
//
//  Created by  Кирилл on 10/26/19.
//  Copyright © 2019 AppCraft. All rights reserved.
//

import Foundation

enum AppConfiguration {
    
    static var databaseContainerName: String {
        return "TestWork"
    }
    
    static var serverUrl: String {
        let url = ""
        if url.isEmpty {
            fatalError("set your server url in AppConfiguration")
        }
        return url
    }
    
    static var serverApi: String {
        return AppConfiguration.serverUrl + "/api"
    }
    
}
