//
//  ApiRequestParameters.swift
//  HotPlace
//
//  Created by 60192229 on 7/31/24.
//

import Foundation

struct ApiRequestParameters {
    
    struct Login {
        public let username: String
        public let password: String
        public var newPassword: String = ""
        public var tempPwd: String = ""
    }
    
    struct Launch {
        let uuid: String = "12345"
        let deviceModel = "iphone"
        let deviceOS = "I"
        let deviceOSVersion = "17.5.1"
        let appVersion = "2.0.3"
        var appLanguage = "kr"
        var appLanguageVersion = 0
        var appMenuVersion = 0
        var tokenId = ""
    }
}
