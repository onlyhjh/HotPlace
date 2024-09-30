//
//  AppEnviromentSingleton.swift
//  HotPlace
//
//  Created by 60192229 on 7/31/24.
//

import SwiftUI

class AppEnvironmentSingleton {
    static let shared = AppEnvironmentSingleton(appContainer: AppContainer())
    var appContainer: AppContainer
    
    init(appContainer: AppContainer) {
        self.appContainer = appContainer
    }
    
    class func showToast(_ message: String, icon: Image? = nil, duration: TimeInterval = 1.0, bottomPadding: CGFloat = 200) {
        let vm = AppEnvironmentSingleton.shared.appContainer.toastVM
        vm.showToast(msg: message, icon: icon, duration: duration, bottomPadding: bottomPadding)
    }
}

struct AppContainer {
    let mainVM = MainViewModel()
    let loadingVM = LoadingViewModel()
    let alertVM = InfoSheetViewModel()
    let toastVM = ToastViewModel()
    let loginVM = InfoSheetViewModel()
}

// 환경변수 기본값 등록
struct AppContainerKey: EnvironmentKey {
    static var defaultValue: AppContainer = AppContainer()
}

// @Environment 2 환경변수 추가
extension EnvironmentValues {
    var appContainer: AppContainer {
        get { self[AppContainerKey.self] }
        set { self[AppContainerKey.self] = newValue }
    }
}
