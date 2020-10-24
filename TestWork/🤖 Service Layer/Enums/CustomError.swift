//
//  CustomError.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//

import Foundation

protocol ErrorProtocol: LocalizedError {
    var title: String? { get }
    var code: Int { get }
}

struct CustomError: ErrorProtocol {
    var title: String?
    var code: Int
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }

    private var _description: String

    init(title: String?, description: String, code: ErrorCodes) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code.rawValue
    }
    
    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
    }
}

enum ErrorCodes: Int {
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case internalServerError = 500
    case profileNotFilled = 529
    case userBlocked = 532
    case existHelpCategory = 530
    case youAreNotANeighbor = 540
    case invalidSmsCode = 542
    case pushSubscribeFailed = -100
    case pushUnsubscribeFailed = -101
    case firebaseAuthError = -102
    case noInternetConnection = -103
    case notificationSettingsError = -104
    case noAccessToThisAdvert = -105
    case addPhotoToForumError = -106
}
