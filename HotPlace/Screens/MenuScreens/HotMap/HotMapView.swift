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
    @State var draggedOffset = CGSize.zero
    @State var lastOffsetY: Double = 50
    @State var feedSpacerHeight: CGFloat = 50
    
    var drag: some Gesture {
        DragGesture()
            .onChanged{ gesture in
                withAnimation(.spring()) {
                    var y = lastOffsetY + gesture.translation.height
                    if y < 20 { y = 20 }
                    if y > UIScreen.main.bounds.size.height - 20 { y = UIScreen.main.bounds.size.height - 20 }
                    feedSpacerHeight = y
                    print("gesutre: \(y)")
                }
                
            }
            .onEnded{ gesture in
                withAnimation(.spring()) {
                    if gesture.translation.height > 0 { feedSpacerHeight = UIScreen.main.bounds.size.height - 50 }
                    else if gesture.translation.height < 0 { feedSpacerHeight = 50 }
                    lastOffsetY = feedSpacerHeight
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
                    Spacer()
                        .frame(height: feedSpacerHeight)
                    VStack {
                        Text("---")
                            .gesture(drag)
                        ScrollView {
                            FeedView()
                        }
                    }
                    .background(Color.white)
                }
            }
        }
        .onAppear {
            UIScrollView.appearance().bounces = false
        }
        .onDisappear {
            UIScrollView.appearance().bounces = true
        }
    }
}

#Preview {
    HotMapView()
}
