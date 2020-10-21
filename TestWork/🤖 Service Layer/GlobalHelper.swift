//
//  GlobalHelper.swift
//  hockey
//
//  Created by Кирилл Баюков on 21/10/2019.
//  Copyright © 2019 AppCraft. All rights reserved.
//

import Foundation


import GKViper

enum GlobalHelper {
    
    static func openTerms() {
        if let url = URL(string: "https://terms.go-hockey.com/") {
            GlobalHelper.openLink(url: url)
        }
    }
    
    static func isTutorialShown() -> Bool {
        return UserDefaults.standard.bool(forKey: "isTutorialShown")
    }
    
    static func setTutorialShown() {
        UserDefaults.standard.set(true, forKey: "isTutorialShown")
    }
    
    static func setToken(token: String) {
        UserDefaults.standard.setValue(token, forKey: "accessToken")
    }
    
    static func getToken() -> String? {
        return UserDefaults.standard.string(forKey: "accessToken")
    }
    
    static func logout() {
        
        //perform clean here
        UserDefaults.standard.removeObject(forKey: "accessToken")
        let vc = InitialAssembly.create()
        _ = InitialAssembly.configure(with: vc)
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
    static func defaultHeaders() -> [String : String] {
        return ["Authorization": "Token \(GlobalHelper.getToken() ?? "")"]
    }
    
    static func openLink(url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
