//
//  HotMapView.swift
//  HotPlace
//
//  Created by 60192229 on 8/2/24.
//

import SwiftUI
import NMapsMap

struct HotMapView: View {
    @ObservedObject var vm = HotMapViewModel()
    
    @State var selectedMarker: NMFMarker?     // 선택된 스토어 마커
    @State var dragOffsetY: CGFloat = 100
    @State var currentOffsetY: CGFloat = 100
    @State var isFisrtGuestureChanging: Bool = true
    
    var drag: some Gesture {
        DragGesture()
            .onChanged{ gesture in
                print("gesture onChanged > isFisrtGuestureChanging? \(isFisrtGuestureChanging)")
                // 하위 스크롤에서 처음 스크롤의 영향을 받는 이슈발생 > 첫 onChange 사용 안함
                if isFisrtGuestureChanging {
                    isFisrtGuestureChanging = false
                }
                else {
                    dragOffsetY = gesture.translation.height + currentOffsetY
                    if dragOffsetY < 50 { dragOffsetY = 50 }
                    else if dragOffsetY > UIScreen.main.bounds.size.height - 200 { dragOffsetY = UIScreen.main.bounds.size.height - 200 }
                }
            }
            .onEnded{ gesture in
                print("gesture onChaonEndednged")
                isFisrtGuestureChanging = true
                withAnimation() {
                    if gesture.translation.height < 0 {  dragOffsetY = 100 }
                    else { dragOffsetY = UIScreen.main.bounds.size.height - 238 }
                    currentOffsetY = dragOffsetY
                }
            }
    }
    var body: some View {
        ZStack {
            NaverMapView(selectedMarker: $selectedMarker)
            
            if selectedMarker != nil {
                VStack {
                    let store = HotStore(name: selectedMarker?.captionText, imagePath: "store_default")
                    let feed = HotFeed(store: store, title: "my best food 111", imagePaths: ["store_default", "store_default", "store_default"], description: "\(selectedMarker?.captionText ?? "11111")\n 가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하")
                    
                    VStack {
                        Text("---")
                        StoreTitleView(store: store)
                            .padding(.horizontal, 20)
                    }
                    
                    ScrollView {
                        FeedView(feed: feed)
                    }
                    .padding(.bottom, 20 + AppConstants.bottomNavigationHeight)
                }
                .background(Color.white)
                .offset(y: dragOffsetY)
                .gesture(drag)
            }
        }
        .onChange(of: selectedMarker) { marker in
            dragOffsetY = 100
            currentOffsetY = 100
        }
    }
}

#Preview {
    HotMapView()
}
