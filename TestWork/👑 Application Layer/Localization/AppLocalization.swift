//
//  AppLocalization.swift
//  Arcana
//
//  Created by  Кирилл on 10/26/19.
//  Copyright © 2019 AppCraft. All rights reserved.
//

import Foundation

enum AppLocalization {
    
    enum General: String, Localizable {
        case ok         = "OK"
        case save       = "SAVE"
        case cancel     = "CANCEL"
        case close      = "CLOSE"
        case attention  = "ATTENSION"
        case unknown    = "UNKNOWN"
        case loading    = "LOADING"
        case refresh    = "REFRESH"
        case tryAgain   = "TRY_AGAIN"
        case yes        = "YES"
        case noo        = "NO"
        case error      = "ERROR"
        case warning    = "WARNING"
        case cont       = "CONTINUE"
        case search     = "SEARCH"
        case next       = "NEXT"
    }
    
    enum Theme: String, Localizable {
        case light  = "APP_THEME_DARK"
    }
    
    enum Language: String, Localizable {
        case english    = "APP_LANG_ENG"
        case russian    = "APP_LANG_RUS"
    }
    
    enum Errors: String, Localizable {
        case badRequest                = "BAD_REQUEST"
        case unauthorized              = "UNAUTHORIZED"
        case internalServerError       = "INTERNAL_SERVER_ERROR"
        case notFoundError             = "NOT_FOUND_ERROR"
        case pushSubscribeFailed       = "PUSH_SUBSCRIBE_FAILED"
        case pushUnsubscribeFailed     = "PUSH_UNSUBSCRIBE_FAILED"
        case firebaseAuthError         = "FIREBASE_AUTH_ERROR"
        case noInternetConnection      = "NO_INTERNET_CONNECTION"
        case profileNotFilled          = "PROFILE_NOT_FILLED"
        case userBlocked               = "USER_BLOCKED"
        case errorPhoneNumber          = "ERROR_PHONE_NUMBER"
        case errorSmsCode              = "ERROR_SMS_CODE"
        case failedToSaveData          = "FAILED_TO_SAVE_DATA"
        case notСompletedError         = "NOT_COMPLETED_ERROR"
        case existHelpCategory         = "EXIST_HELP_CATEGORY"
        case notificationEditError     = "NOTIFICATION_EDIT_ERROR"
        case impossibleDeleteAdvert    = "IMPOSSIBLE_DELETE_ADVERT"
        case impossibleDeleteResponse  = "IMPOSSIBLE_DELETE_RESPONSE"
        case impossibleCompleteAdvert  = "IMPOSSIBLE_COMPLETE_ADVERT"
        case instruction               = "INSTRUCTION"
        case impossibleComplainReview  = "IMPOSSIBLE_COMPLAIN_REVIEW"
        case noAccessToThisAdvert      = "NO_ACCESS_TO_THIS_ADVERT"
        case youAreNotANeighbor        = "YOU_ARE_NOT_A_NEIGHBOR"
        case addPhotoToForumError      = "ADD_PHOTO_TO_FORUM_ERROR"
        case invalidSmsCode            = "INVALID_SMS_CODE"
    }
    
    enum Navigation: String, Localizable {
        case albums     = "Albums"
        case photos     = "Photos"
    }
    
    enum TabBar: String, Localizable {
        case network    = "Network"
    }
}
