//
//  HotFeedView.swift
//  HotPlace
//
//  Created by 60192229 on 7/30/24.
//

import SwiftUI

struct HotFeedView: View {
    @ObservedObject var vm = HotFeedViewModel()
    
    let appContainer = AppEnvironmentSingleton.shared.appContainer
    
    var body: some View {
        VStack {
            Text("New Feeds")

            ScrollView {
                FeedView()
                FeedView()
            }
            Spacer()
            
            Button("show loading", action: {
                appContainer.loadingVM.isPresented = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    appContainer.loadingVM.isPresented = false
                }
            })
            
            Button("show alert", action: {
                DispatchQueue.main.async {
                    let alert = AppEnvironmentSingleton.shared.appContainer.alertVM
                    alert.resetModel()
                    alert.title = "안내"
                    alert.description = "오류메시지 테스트 오류메시지 테스트 오류메시지 테스트 오류메시지 테스트 오류메시지 테스트 오류메시지 테스트 "
                    alert.imageType = .warning
                    alert.button1Title = "확인"
                    alert.button1Action = { alert.isPresented = false }
                    alert.isPresented = true
                }
            })
            
            Button("go to map", action: {
                appContainer.mainVM.appScreenState = .hotMap
            })
            
            Button("fullScreenCover type: web", action: {
                appContainer.mainVM.isShowFullScreenCover = true
                appContainer.mainVM.fullScreenCoverType = .web
            })
            Button("fullScreenCover type: photo", action: {
                appContainer.mainVM.isShowFullScreenCover = true
                appContainer.mainVM.fullScreenCoverType = .photo
            })
            Button("sheetState_blue_full") { appContainer.mainVM.sheetState = .blue }
            Button("sheetState_pink_h300") { appContainer.mainVM.sheetState = .pink }
            Button("show_photoPicker") { appContainer.mainVM.isShowPhotoPicker = true }
        }
    }
}

#Preview {
    HotFeedView()
}
