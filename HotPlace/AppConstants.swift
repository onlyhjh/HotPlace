//
//  AppConstants.swift
//  HotPlace
//
//  Created by 60192229 on 7/30/24.
//

import SwiftUI
import NMapsMap

public struct AppConstants {
    static let DispatchQueueLabel : String = "bg_parse_queue"
    
    /// base url
    static var baseUrl = "https://gcodev.shinhanglobal.com"

    // MARK: - Session
    /// 세션 id 키
    static let sessionKey = "JSESSIONID"
    
    static var languageCode = "kr"
    
    // naver map
    static let naverClientId = "f9j5el0909"
    static let naverClientSecret = "jvGaxBAPnPZ6rFG91nKbVjIRsTVvydvRHI62TWgF"
    static let mapDefaultLocation = NMGLatLng(lat: 37.5195552, lng: 127.0206216) // 지도의 기본 시작 위경도 > 신사역
    static let mapLimitBounds = NMGLatLngBounds(southWest: NMGLatLng(lat: 33.094692, lng: 124.823879), northEast: NMGLatLng(lat: 38.618493, lng: 131.878146)) // 지도 한계 범위 설정

    // MARK: - Network Manager Config
    /// 동시 접속 세션수 제한 max 4
    static let httpMaximumConnectionsPerHost = 4
    /// request timeout 시간 설정, 기본값 60
    static let timeoutIntervalForRequest = 60.0
    
    
    static var setupSkeypadPath: String = "/gm/co/GMCO013.pwkjson"
    static var decryptSkeypadPath: String = "/gm/co/GMCO014.pwkjson"

    static let changeLanguageNotiName = Notification.Name(rawValue: "changeLanguageNotification")
    
    static let defaultDuration: Double = 0.2
    static let popupDuration: Double = 0.3
    static let bottomNavigationHeight: CGFloat = 72.0
    static let bottomToastPadding: CGFloat = 100.0
    static let toastDuration: Double = 3.0
    static let botPaddingSafeArea: CGFloat = 34.0
    static let botPaddingNoneSafeArea: Double = 12.0
    
    static let homeBannerHeight: CGFloat = 104.0
    static let homeBannerHeightEasyMode: Double = 120.0
    static let pluginImageResize: Double = 2500000.0 // 2.5Mb
    
    static let navigationList = [BottomNavigationItem(normalIcon: Image("menu_hot_feed_off"), selectedIcon: Image("menu_hot_feed"), text: "New Feeds"),
                      BottomNavigationItem(normalIcon: Image("menu_hot_map_off"), selectedIcon: Image("menu_hot_map"), text: "Map"),
                      BottomNavigationItem(normalIcon: Image("menu_my_off"), selectedIcon: Image("menu_my"), text: "My"),
                                 BottomNavigationItem(normalIcon: Image("menu_web_off"), selectedIcon: Image("menu_web"), text: "Web")]
    static let navigationHeight = 72.0
    
    static var didLogin = false
}

enum LoginType: String {
    /// 아이디 비번
    case idPassword
    /// 간편인증
    case simpleAuth
    /// 패턴 로그인
    case pattern
    /// 지문 인식
    case fingerPrint
    /// FaceID
    case faceId
}

