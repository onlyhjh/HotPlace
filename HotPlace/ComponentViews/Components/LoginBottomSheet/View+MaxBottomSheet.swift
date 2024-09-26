//
//  View+LoginBottomSheet.swift
//  IOS_CleanArchitecture_Sample
//
//  Created by Su Jin Kim on 2022/04/30.
//

import SwiftUI

extension View {
    
	public func maxBottomSheet<PopupContent: View, Background:View>(
        isPresented: Binding<Bool>,
        blurPoint: CGFloat = 1.0,
        cornerRadius: CGFloat = 16.0,
        bottomSheetRatio: CGFloat = 0.0,
        dismissCallback: @escaping () -> () = {},
        @ViewBuilder content: @escaping () -> PopupContent,
		@ViewBuilder background: @escaping () -> Background
	) -> some View {
            self.modifier(
                MaxBottomSheetModifier(isPresented: isPresented,
                                      blurPoint: blurPoint,
                                      cornerRadius: cornerRadius,
                                      bottomSheetRatio: bottomSheetRatio,
                                      dismissCallback: dismissCallback,
                                      content: content,
									 background: background)
            )
        }
}
