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
    
    var drag: some Gesture {
        DragGesture()
            .onChanged{ gesture in
                withAnimation() {
                    dragOffsetY = gesture.translation.height + currentOffsetY
                    if dragOffsetY < 50 { dragOffsetY = 50 }
                    else if dragOffsetY > UIScreen.main.bounds.size.height - 200 { dragOffsetY = UIScreen.main.bounds.size.height - 200 }
                }
            }
            .onEnded{ gesture in
                withAnimation() {
                    if gesture.translation.height < 0 {  dragOffsetY = 100 }
                    else { dragOffsetY = UIScreen.main.bounds.size.height - 238 }
                    currentOffsetY = dragOffsetY
                }
            }
    }
    var body: some View {
        ZStack {
            VStack {
                Text("HotMapView")
                NaverMapView(selectedMarker: $selectedMarker)
            }
            
            if selectedMarker != nil {
                VStack {
                    let store = HotStore(name: selectedMarker?.captionText, imagePath: "store_default")
                    let feed = HotFeed(store: store, title: "my best food 111", imagePaths: ["store_default", "store_default", "store_default"], description: "\(selectedMarker?.captionText ?? "11111")\n 가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하")
                    
                    Text("---")
                    StoreTitleView(store: store)
                        .padding(.horizontal, 20)
                    ScrollView {
                        FeedView(feed: feed)
                    }
                    .padding(.bottom, 20)
                }
                .background(Color.white)
                .offset(y: dragOffsetY)
                .gesture(drag)
            }
        }
        .onAppear {
            UIScrollView.appearance().bounces = false
        }
        .onDisappear {
            UIScrollView.appearance().bounces = true
        }
        .onChange(of: selectedMarker) { marker in
            if marker == nil {
                dragOffsetY = 100
                currentOffsetY = 100
            }
        }
    }
}

#Preview {
    HotMapView()
}
