//
//  AppDelegate.swift
//  HotPlace
//
//  Created by 60192229 on 7/30/24.
//

import SwiftUI
import NMapsMap

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        
        // push Enable for token id.
        self.registPush()
        
        
        // set naver map
        NMFAuthManager.shared().clientId = AppConstants.naverClientId
        
        return true
    }
}

extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // TODO: Check it
        let userInfo = notification.request.content.userInfo
        completionHandler([[.banner, .badge, .sound]])
        
        Logger.log("APNS PUSH willPresent \(userInfo)", logType: .hot)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let newToken = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        Logger.log("newToken : \(newToken)", logType: .hot)

        if let oldToken = UserDefaults.standard.value(forKey: "ApnsToken") as? String, oldToken == newToken {
            // newToken is equals with oldToken
        }
        else {
            UserDefaults.standard.setValue(newToken, forKey: "ApnsToken")
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        Logger.log("APNS PUSH Register Fail: \(error.localizedDescription)", logType: .error)

    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        Logger.log("APNS PUSH didReceive: \(userInfo)", logType: .hot)
        
        guard let dicAps = userInfo["aps"] as? Dictionary<String, Any>,
              let dicData = dicAps["data"] as? Dictionary<String, Any> else {
            return
        }
        
        let receiveCode = dicData["menuCd"] as? String ?? ""
        let paramValue = dicData["ums_svc_c"] as? String ?? ""
        
        let moveEvent = {
            //RouteUtility.routePush(receiveCode: receiveCode, param: paramValue)
            completionHandler()
        }
        
//        if HomeViewModel.isReadyHomeView {
//            moveEvent()
//        } else {
//            HomeViewModel.readyHomeEvent = moveEvent
//        }
    }
}

// MARK: - Push Process
extension AppDelegate {
    func registPush() {
        if #available(iOS 10.0, *) {
            let current = UNUserNotificationCenter.current()
            current.delegate = self
            
            // push 권한 요청
            current.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                DispatchQueue.main.async {
                    if granted {
                        UIApplication.shared.registerForRemoteNotifications()
                    } else {
                        // 수락을 안하는 케이스
                    }
                    //MARK: removed asis code
                    //self.appTrackingPermission()
                }
            }
        } else { // iOS10 미만. iOS8 이상
            let settings = UIUserNotificationSettings(types: [.alert, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()
        }
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
}
