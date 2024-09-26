//
//  PreferenceDataManager.swift
//  foodinko
//
//  Created by JOEY HWANG on 2020/06/30.
//  Copyright © 2020 JOEY HWANG. All rights reserved.
//

import Foundation

class PreferenceDataManager {
    
    enum PreferenceKey: String {
        case termsVersion
        case didShowPermission
    }
    
    static func setTermsVersion(version: String) {
        UserDefaults.standard.set(version ,forKey: PreferenceKey.termsVersion.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func getTermsVersion() -> Any? {
        return UserDefaults.standard.object(forKey: PreferenceKey.termsVersion.rawValue)
    }
    
    static func setDidShowPermission() {
        UserDefaults.standard.set(true ,forKey: PreferenceKey.didShowPermission.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func getDidShowPermission() -> Any? {
        return UserDefaults.standard.object(forKey: PreferenceKey.didShowPermission.rawValue)
    }
}
