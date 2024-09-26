//
//  ApiResponse.swift
//  HotPlace
//
//  Created by 60192229 on 7/31/24.
//

import SwiftUI

struct ApiResponses {
    
    struct Common: Codable {
        let code: Int
        let message: String
    }
    
    struct Launch: Codable {
        var isActivated: Int?
       // var menuList: [UIBMenuListInfo]?
        var appLatestVer: String?
        var appReleaseDate: String?
        //var languageList: [UIBLanguageInfo]?
        var serverMnVersion: Int?
        var serverLanguageVersion: Int?
        //var globalMenuList: [UIBMenuInfo]?
        //var homeBannerList: [UIBHomeBannerInfo]?
        //var promotionBannerList: [UIBHomeBannerInfo]?
        //var myMenuDefaultList: [UIBMenuInfo]?
        //var myMenuList: [UIBMenuInfo]?
        //var searchMenuList: [UIBMenuInfo]?
        var lastNoticeDt: String?
        var forceUpdateContent: String?
        var optionUpdateContent: String?
        //var emergencyNotice: UIBNoticeInfo?
        //var maintenanceNotice: UIBNoticeInfo?
    }
}
