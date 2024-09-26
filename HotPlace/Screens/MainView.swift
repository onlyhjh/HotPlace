//
//  ContentView.swift
//  HotPlace
//
//  Created by 60192229 on 7/30/24.
//

import SwiftUI
import Combine
import PhotosUI

enum AppScreenState: Int, CaseIterable {
    case hotFeed = 0
    case hotMap
    case my
    case web
    case launching
    case permisson
    case terms
    case setting
    case notice
    case search
    
    
    static func getAppScreenState(index: Int) -> AppScreenState {
        for (i, state) in AppScreenState.allCases.enumerated() {
            if i == index { return state }
        }
        return .hotFeed // default
    }
}

enum SheetState: Hashable, Identifiable {
    case blue
    case pink

    var id: SheetState { self }
}

@available(iOS 16.0, *)
struct MainView: View {
    @Environment(\.appContainer.mainVM) private var vm:  MainViewModel
    @Environment(\.appContainer.loadingVM) private var loadingVM:  LoadingViewModel
    @Environment(\.appContainer.alertVM) private var alertVM: InfoSheetViewModel
    @Environment(\.appContainer.toastVM) private var toastVM: ToastViewModel
    
    static let id = String(describing: Self.self)
    
    @State var isShowNavigation: Bool = false
    @State var navigationTabIndex: Int = 0
    @State var appScreenState: AppScreenState = .launching // vm.appScreenState 직접 사용하면 적용 안될때 있음
    @State var isShowFullScreenCover = false
    @State var sheetState: SheetState? = nil
    
    @State var isShowPhotoPicker = false
    @State var selectedPhotosPickerItems: [PhotosPickerItem] = []
    @State var selectedBackgroundImage: UIImage? = nil
    
    // 화면전환시 유지 되어야 할 View
    var hotFeedView = HotFeedView()
    var hotMapView = HotMapView()
    
    // test 약관 version
    let newTermsVersion = "1.0"
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.clear.opacity(0.2).ignoresSafeArea()
                if let img = selectedBackgroundImage {
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                }
                
                VStack {
                    switch self.appScreenState {
                    case .launching: Color.yellow
                    case .permisson:
                        PermissionView() {
                            PreferenceDataManager.setDidShowPermission()
                            // check terms version
                            if let lastTermsVersion = PreferenceDataManager.getTermsVersion() as? String, lastTermsVersion == newTermsVersion {
                                vm.appScreenState = .hotFeed
                            }
                            else {
                                vm.appScreenState = .terms
                            }
                        }
                    case .terms:
                        TermsView() {
                            PreferenceDataManager.setTermsVersion(version: self.newTermsVersion)
                            vm.appScreenState = .hotFeed
                        }
                    case .hotFeed: self.hotFeedView
                    case .hotMap: self.hotMapView
                    case .my: MyView()
                    case .setting: SettingView()
                    case .notice: NoticeView()
                    case .search: SearchView()
                    case .web: HotWebView(urlStr: "https://naver.com") //vm.webUrlStr)
                    }
                    
                    if isShowNavigation {
                        BottomNavigation(selectedIndex: $navigationTabIndex, items: AppConstants.navigationList, height: AppConstants.navigationHeight) { selectedIndex in
                            vm.appScreenState = AppScreenState.getAppScreenState(index: selectedIndex)
                        }
                    }
                }
                
            }
        }
        .photosPicker(isPresented: $isShowPhotoPicker, selection: $selectedPhotosPickerItems,maxSelectionCount: 1)
        .fullScreenCover(isPresented: $isShowFullScreenCover) {
            ZStack {
                switch vm.fullScreenCoverType {
                case .web:
                    Color.pink
                case .photo:
                    Color.blue
                }
                Button("close") { vm.isShowFullScreenCover = false }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .sheet(item: $sheetState) { state in
            switch state {
            case .blue:
                if #available(iOS 16.0, *) {
                    ZStack {
                        
                        Color.blue
                        Button("close") { sheetState = nil }
                    }
                    .edgesIgnoringSafeArea(.bottom)
                }
            case .pink:
                if #available(iOS 16.0, *) {
                    ZStack {
                        
                        Color.red
                        Button("close") { sheetState = nil }
                    }
                    .presentationDetents([.height(300)])
                    .edgesIgnoringSafeArea(.bottom)
                }
            }
        }
        .modifier(AlertViewModifier(vm: alertVM))
        .modifier(LoadingViewModifier(vm: loadingVM))
        .modifier(ToastViewModfier(vm: toastVM))
        .onAppear {
            if vm.appScreenState == .launching {
                vm.requestLaunch(successCompletion: {
                    // check permission did show
                    if let _ = PreferenceDataManager.getDidShowPermission() as? Bool {
                        // check terms version
                        if let lastTermsVersion = PreferenceDataManager.getTermsVersion() as? String, lastTermsVersion != newTermsVersion {
                            vm.appScreenState = .terms
                        }
                        else {
                            vm.appScreenState = .hotFeed
                        }
                    }
                    else {
                        vm.appScreenState = .permisson
                    }
                }, failureCompletion: {
                    exit(0)
                })
                
            }
        }
        .onReceive(vm.$appScreenState , perform: { newValue in
            Logger.log("appScreenState = \(vm.appScreenState), newValue = \(newValue)")
            // vm.appScreenState 직접 사용하면 view에 적용 안될때 있음 > State으로 받아서 사용
            DispatchQueue.main.async {
                self.appScreenState = newValue
            }
    
            navigationTabIndex = newValue.rawValue
            isShowNavigation = newValue == .hotFeed || newValue == .hotMap || newValue == .my || newValue == .web || newValue == .web
        })
        .onReceive(vm.$sheetState , perform: { newValue in
            Logger.log("sheetState = \(String(describing: newValue))")
            DispatchQueue.main.async {
                self.sheetState = newValue
            }
        })
        .onReceive(vm.$isShowPhotoPicker , perform: { newValue in
            Logger.log("isShowPhotoPicker = \(String(describing: newValue))")
            DispatchQueue.main.async {
                self.isShowPhotoPicker = newValue
            }
        })
        .onReceive(vm.$isShowFullScreenCover , perform: { newValue in
            Logger.log("isShowFullScreenCover = \(String(describing: newValue))")
            DispatchQueue.main.async {
                self.isShowFullScreenCover = newValue
            }
        })
        .onChange(of: selectedPhotosPickerItems) { items in
            if items.count > 0 {
                items[0].loadTransferable(type: Data.self) { result in
                    let _ = result.map { data in
                        if let imgData = data {
                            selectedBackgroundImage = UIImage(data: imgData)
                        }
                        else {
                            selectedBackgroundImage = nil
                        }
                    }
                }
            }
            else {
                selectedBackgroundImage = nil
            }
        }
    }
}

#Preview {
    if #available(iOS 16.0, *) {
        MainView()
    }
    else {
        Color.blue
    }
}
