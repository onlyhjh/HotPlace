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
    let feeds = [
                HotFeed(store: HotStore(name: "Store111", imagePath: "store_default"), title: "my best food 111", imagePaths: ["store_default", "store_default", "store_default"], description: "11111 가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하"),
                 HotFeed(store: HotStore(name: "Store2222", imagePath: "store_default"), title: "my best food 222", imagePaths: ["store_default", "store_default", "store_default"], description: "22222 가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하")
    ]
    
    var body: some View {
        VStack {
            Text("New Feeds")

            ScrollView {
                ForEach(feeds, id: \.title) { feed in
                    StoreTitleView(store: feed.store)
                    .padding(.horizontal, 10)
                    FeedView(feed: feed)
                        .padding(.bottom, 10)
                }
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
