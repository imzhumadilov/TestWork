//
//  AppManager.swift
//  BeMove
//
//  Created by  Кирилл on 4/4/19.
//  Copyright © 2019 AppCraft. All rights reserved.
//

import Foundation

enum AppManager {
    
    static var name: String {
        if let displayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            return displayName
        }
        
        return ""
    }
    
    static var version: String {
        if let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String, let buildNumber: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String {
            var target: String = ""
            #if DEBUG
            target = ".D"
            #else
            let isTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
            if isTestFlight {
                target = ".T"
            }
            #endif
            return "v.\(versionNumber).\(buildNumber)\(target)"
        }
        
        return ""        
    }
    
}
