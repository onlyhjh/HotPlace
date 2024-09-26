//
//  ServerConstants.swift
//  HotPlace
//
//  Created by 60192229 on 7/30/24.
//

import Foundation


enum ApiPath: String {
    
    case appLaunch = "/ui/al/UIAL001.pwkjson"
    case login = "/ui/lo/UILO001.pwkjson"
    case accountLogin = "/ui/lo/UILO002.pwkjson"
    case loginExtend = "/ui/lo/UILO005.pwkjson"
    case logout = "/ui/lo/UILO004.pwkjson"
    case label = "/gm/co/GMCO005.pwkjson"
    case customerInfo = "/ui/co/UICO017.pwkjson"
    case simpleAuthRegPre = "/ui/lo/UILO006.pwkjson"
    case simpleAuthReg = "/ui/lo/UILO007.pwkjson"
    case simpleAuthVerifyPre = "/ui/lo/UILO008.pwkjson"
    case simpleAuthVerify = "/ui/lo/UILO009.pwkjson"
    case simpleAuthExpire = "/ui/lo/UILO010.pwkjson"
    case getProductList = "/ui/pr/UIPR399.pwkjson"
    case getSessionData = "/ui/ho/UIHO010.pwkjson"
    case refreshHomeInfo = "/ui/ho/UIHO011.pwkjson"
    case menuRefresh = "/ui/al/UIAL002.pwkjson"
    case fraudAlert = "/ui/co/UICO012.pwkjson"

    // MARK: - BottomSheet related API
    /// Agree Personal Info
    case bottomSheetAgreePersonalInfo = "/ui/co/UICO542.pwkjson"
    
}


// API path url
struct ServerConstants {
    static let DispatchQueueLabel : String = "bg_parse_queue"
    
    /// base url for system use, default relelase baseurl
    static var baseUrl = devBaseUrl
    
    // TODO: - replace release server address
    // MARK: - Server Address
    /// for release
    //static var releaseBaseUrl = "https://gmui.ui-bk.com"
    /// for developer
    static var devBaseUrl     = "https://gmuidev.ui-bk.com"
    /// for tester
    static var testBaseUrl    = "https://gmuitst.ui-bk.com"
  
    // FOR DEBUG Change Server
    static var defaultStagingBaseUrl = testBaseUrl //need to change to releaseBaseUrl when release

    static let groupCode: String = "100"

    // MARK: - Session
    static let sessionKey = "JSESSIONID"
    
    static let httpMaximumConnectionsPerHost = 4
    static let timeoutIntervalForRequest = 60.0

    /// 10 miniutes
    static let sessionExpiredTime: Int = 10 * 60
    /// before 1 miniutes
    static let sessionExpireCountDownTime: Int = 1 * 60
    ///
    static let remainingTimeNeedExtend: Int = 3 * 60
    
    static var termConditionPath = "/pdf/sol_mobile_banking_tc.pdf"

    static func pathURL(path: ApiPath) -> URL? {
        return URL(string: baseUrl + path.rawValue)
    }
}
