//
//  InfoBottomSheet.swift
//  InfoBottomSheet
//
//  Created by Tieda Wei on 2020-04-25.
//  Copyright © 2020 Tieda Wei. All rights reserved.
//  Original Code: https://github.com/weitieda/bottom-sheet
// 
//  위 원본코드를 토대로 전체적으로 수정함
//  2022-04-20, Shinhan

import SwiftUI
/**
	하단 BottomSheet
 - remark:
	화면에 기술하면 스크린이 생성될때 메모리에 같이 생성됨, 동적으로 생성하는 부분은 loginBottomSheet를 참고해서 새로 만들어야 함.
 */
public struct InfoBottomSheet<Content: View>: View {
	
	private var dragToDismissThreshold: CGFloat { height * 0.2 }
	private var grayBackgroundOpacity: Double { isPresented ? (0.4 - Double(draggedOffset)/self.height) : 0 }
	
	@State private var draggedOffset: CGFloat = 0
	@State private var previousDragValue: DragGesture.Value?
	
	@Binding var isPresented: Bool
    var dragToDismiss: Bool = true
    var tapToDismiss: Bool = false
	private let height: CGFloat
	private let topBarHeight: CGFloat
	private let topBarCornerRadius: CGFloat
    private let content: () -> Content
	private let contentBackgroundColor: Color
	private let topBarBackgroundColor: Color
	private let showTopIndicator: Bool
	
	public init(
		isPresented: Binding<Bool>,
        dragToDismiss: Bool = false,
        tapToDismiss: Bool = false,
		height: CGFloat,
		topBarHeight: CGFloat = 30,
		topBarCornerRadius: CGFloat? = nil,
		topBarBackgroundColor: Color = Color(.systemBackground),
		contentBackgroundColor: Color = Color(.systemBackground),
		showTopIndicator: Bool,
        @ViewBuilder content: @escaping () -> Content
	) {
		self.topBarBackgroundColor = topBarBackgroundColor
		self.contentBackgroundColor = contentBackgroundColor
		self._isPresented = isPresented
		self.height = height
        self.dragToDismiss = dragToDismiss
        self.tapToDismiss = tapToDismiss
		self.topBarHeight = topBarHeight
		if let topBarCornerRadius = topBarCornerRadius {
			self.topBarCornerRadius = topBarCornerRadius
		} else {
			self.topBarCornerRadius = topBarHeight / 3
		}
		self.showTopIndicator = showTopIndicator
		self.content = content
	}
    @State private var sheetContentRect: CGRect = .zero

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                self.fullScreenLightGrayOverlay()
                
                Group {
                    VStack {
                        self.content()
							.background(contentBackgroundColor
								.ignoresSafeArea(edges: .bottom)
								.frame(height: geometry.safeAreaInsets.bottom), alignment: .bottom)
                            .frameGetter($sheetContentRect)
                    }
                }
                .animation(.linear(duration: 0.3))
                .offset(y: self.isPresented ? (self.draggedOffset) : (geometry.size.height + geometry.safeAreaInsets.bottom))
                .gesture(
                    DragGesture()
                        .onChanged({ (value) in
                            if !dragToDismiss {
                                return
                            }
                            
                            let offsetY = value.translation.height
                            // 위로 스크롤 못하게 막음
                            if offsetY > 0 {
                                self.draggedOffset = offsetY
                            }
                            
                            if let previousValue = self.previousDragValue {
                                let previousOffsetY = previousValue.translation.height
                                let timeDiff = Double(value.time.timeIntervalSince(previousValue.time))
                                let heightDiff = Double(offsetY - previousOffsetY)
                                let velocityY = heightDiff / timeDiff
                                if velocityY > 1400 {
                                    self.isPresented = false
                                    return
                                }
                            }
                            self.previousDragValue = value
                            
                        })
                        .onEnded({ (value) in
                            if !dragToDismiss {
                                return
                            }
                            
                            let offsetY = value.translation.height
                            if offsetY > sheetContentRect.height * 0.2 {
                                self.isPresented = false
                            }
                            self.draggedOffset = 0
                        })
                )
                
            }
        }
        // 키보드 safeArea 방지
		.ignoresSafeArea(.keyboard)
	}
	
	fileprivate func fullScreenLightGrayOverlay() -> some View {
		Color
			.black
			.opacity(grayBackgroundOpacity)
			.edgesIgnoringSafeArea(.all)
			.animation(.interactiveSpring())
            .onTapGesture {
                if tapToDismiss {
                    self.isPresented = false
                }
            }
	}
}
