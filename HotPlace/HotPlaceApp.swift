//
//  HotPlaceApp.swift
//  HotPlace
//
//  Created by 60192229 on 7/30/24.
//

import SwiftUI

@main
struct HotPlaceApp: App {
    @Environment(\.scenePhase) var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @State var isMask = true
    @State var safeAreaInsets: (top: CGFloat, bottom: CGFloat) = (0, 0)

    let appContainer = AppEnvironmentSingleton.shared.appContainer
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                MainView()
                    .environment(\.appContainer, AppEnvironmentSingleton.shared.appContainer)
                    .preventScreenshot()

                if isMask {
                    ZStack(alignment: .bottom) {
                        Image("splash_logo")
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        Text("Copyright")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(Color.blue.ignoresSafeArea())
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIScreen.capturedDidChangeNotification)) { _ in
                //#if RELEASE
                isMask = UIScreen.main.isCaptured
                //#endif
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification)) { _ in
                // Detected after screenshot
                AppEnvironmentSingleton.showToast("Screen capture detected.", duration: 2.0)
            }
            .onOpenURL { url in
                print("deeplink url: \(url)")
                switch appContainer.mainVM.appScreenState {
                case .launching, .permisson, .terms:
                    appContainer.mainVM.linkScreen = .my // Do move link later
                default :
                    appContainer.mainVM.moveToScreen(screen: .my)
                }
            }
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                Logger.log("App is active", logType: .info)
                isMask = false
                //#if RELEASE
                isMask = UIScreen.main.isCaptured
                //#endif
            case .inactive:
                Logger.log("App is inactive", logType: .info)
                if PreferenceDataManager.getDidShowPermission() == nil {
                    isMask = true
                }
            case .background:
                Logger.log("App is in background", logType: .info)
                isMask = true
            @unknown default:
                Logger.log("App scenePhase is unkown: \(newScenePhase)", logType: .hot)
            }
        }
    }
    
}
