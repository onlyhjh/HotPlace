//
//  BottomSheetDefault.swift
//  gma_common
//
//  Created by 60117639 on 2022/10/18.
//  BottomSheet Component

import SwiftUI
import Foundation

struct BottomSheet: View {
    /// bottomsheet style
    enum Style {
        case `default`  // default
        case withHandle // sheet style that dismiss by drag
    }
    
    /// bottomsheet size
    enum Size {
        case middle                  // height 244
        case max                     // height on screen
        case custom(height: CGFloat) // custom heigth
        
        var height: CGFloat {
            get {
                switch self {
                case .max:
                    return UIScreen.main.bounds.height
                case .middle:
                    return 244.0
                case .custom(let height):
                    return height
                }
            }
        }
    }
    
    private var contents: AnyView
    private var style: Style = .default
    private var size: Size = .max
    private var closeAction: (() -> Void)?
    private var dismissThreshold: CGFloat { size.height * 0.4 }
    private var pulledUpThreshold: CGFloat { UIScreen.main.bounds.height * 0.6 }
    private var pulledUpMaxHeight: CGFloat { UIScreen.main.bounds.height * 0.9 }
    
    @Binding var isPresent: Bool
	@State private var foregroundColor: Color
	@State private var backgroundColor: Color
    @State private var offsetY: CGFloat = 0
    @State private var safeAreaInsets: (top: CGFloat, bottom: CGFloat) = (0, 0)
    @State private var dragHeight: CGFloat = 0.0
    @State private var preDragHeight: CGFloat = 0.0
    
    /// Bottom sheet
    /// - Parameters:
    ///   - contents: view to include
    ///   - style: bottomsheet style
    ///   - size: bottomsheet size
    ///   - isPresent: present or not
	///   - foregroudColor: foregroundColor color
    ///   - backgroundColor: background color (dim area)
    ///   - closeAction: Handle action when tap to close button or dismiss by drag.
    public init(contents: some View,
                style: Style = .default,
                size: Size = .middle,
                isPresent: Binding<Bool>,
				foregroundColor: Color = Color.white,
                backgroundColor: Color = Color.clear,
                closeAction: (() -> Void)? = nil) {
        self.contents = AnyView(contents)
        self.style = style
        self.size = size
        self._isPresent = isPresent
		self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.closeAction = closeAction
    }

    /// close button in default style
    var closeButtonView: some View {
        VStack(alignment: .trailing) {
            Button(action: {
                isPresent = false
                closeAction?()
            }, label: {
                Image("icon_line_close_24_black")
            })
            .frame(width: 24, height: 24)
            .basicStyle()
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.trailing, 18)
        .padding(.top, 20)
    }
    
    /// pullup bar in withHandle style
    var pullUpBarView: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundColor(.gray300)
                .cornerRadius(100)
                .frame(width: 48, height: 3)
                .padding(.top, 7)
            Spacer().frame(height: 36)
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { proxy in
				backgroundColor.ignoresSafeArea(.all).onAppear() {
                    safeAreaInsets = (proxy.safeAreaInsets.top, proxy.safeAreaInsets.bottom)
                    offsetY = isPresent ? 0:size.height+proxy.safeAreaInsets.bottom
                }
            }
            
            ZStack(alignment: .top) {
                Rectangle()
                    .foregroundColor(Color.white)
                    .cornerRadius(16, corners: [.topLeft, .topRight])
                    .shadow(color: Color.bottomSheetShadow, radius: 16)

                // gesture prevention area
                Rectangle()
                    .foregroundColor(foregroundColor)
                    .padding(.top, style == .withHandle ? 36:0)
                    .cornerRadius(16, corners: [.topLeft, .topRight])
                    .gesture(DragGesture())
                
                // withHandle style
                if style == .withHandle {
                    contents
                    pullUpBarView
                }
                // Default style
                else {
                    ScrollView {
                        contents
                            .frame(maxWidth: .infinity)
                    }
					.simultaneousGesture(DragGesture(minimumDistance: 0))
                    closeButtonView
                }
            }
            .offset(y: offsetY)
            .frame(width: UIScreen.main.bounds.width, height: size.height+dragHeight, alignment: .bottom)
            .onChange(of: isPresent) { _ in
                withAnimation {
                    offsetY = isPresent ? 0:(size.height + safeAreaInsets.bottom)
                    dragHeight = 0
                    preDragHeight = 0
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .gesture(
            DragGesture()
                .onChanged({ value in
                    let dragHeight = -value.translation.height + preDragHeight
                    if (dragHeight + size.height) < pulledUpMaxHeight {
                        self.dragHeight = dragHeight
                    }
                })
                .onEnded({ value in
                    preDragHeight = dragHeight
                    
                    let currentHeight = size.height+dragHeight
                    if currentHeight < dismissThreshold {
                        isPresent = false
                        closeAction?()
                    } else if currentHeight >= pulledUpThreshold {
                        withAnimation {
                            dragHeight = pulledUpMaxHeight - size.height
                            preDragHeight = dragHeight
                        }
                    }
                })
        )
    }
}

struct BottomSheetDefault_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet(contents: VStack(spacing: 0) {
            Text("Contents View")
                .typography(.heading3, weight: .heavy, color: .gray900)
                .padding(.top, 50)
        }, isPresent: .constant(true))

        BottomSheet(contents: VStack(spacing: 0) {
            Text("Contents View")
                .typography(.heading3, weight: .heavy, color: .gray900)
                .padding(.top, 50)
        }, style: .withHandle, isPresent: .constant(true))
        
        BottomSheet(contents: VStack(spacing: 0) {
            Text("Contents View")
                .typography(.heading3, weight: .heavy, color: .gray900)
                .padding(.top, 50)
        }, style: .default, size: .custom(height: 500), isPresent: .constant(true), backgroundColor: .gray900.opacity(0.6))
    }
}
