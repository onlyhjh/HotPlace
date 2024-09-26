//
//  InfoBottomSheet.swift
//
//  Created by Tieda Wei on 2020-04-25.
//  Copyright © 2020 Tieda Wei. All rights reserved.
//  Original Code: https://github.com/weitieda/bottom-sheet
//
//  위 원본코드를 토대로 전체적으로 수정함
//  2022-04-20, Shinhan

import SwiftUI

public extension View {
	func infoBottomSheet<Content: View>(
		isPresented: Binding<Bool>,
        dragToDismiss: Bool = false,
        tapToDismiss: Bool = false,
		height: CGFloat,
		topBarCornerRadius: CGFloat? = nil,
		contentBackgroundColor: Color = Color(.systemBackground),
		showTopIndicator: Bool = true,
		@ViewBuilder content: @escaping () -> Content
	) -> some View {
		ZStack {
			self
			InfoBottomSheet(isPresented: isPresented,
                            dragToDismiss: dragToDismiss,
                            tapToDismiss: tapToDismiss,
							height: height,
							topBarCornerRadius: topBarCornerRadius,
							contentBackgroundColor: contentBackgroundColor,
							showTopIndicator: showTopIndicator,
							content: content)
		}
	}
	
	func infoBottomSheet<Item: Identifiable, Content: View>(
		item: Binding<Item?>,
        dragToDismiss: Bool = false,
        tapToDismiss: Bool = false,
		height: CGFloat,
		topBarCornerRadius: CGFloat? = nil,
		contentBackgroundColor: Color = Color(.systemBackground),
		showTopIndicator: Bool = true,
		@ViewBuilder content: @escaping (Item) -> Content
	) -> some View {
		let isPresented = Binding {
			item.wrappedValue != nil
		} set: { value in
			if !value {
				item.wrappedValue = nil
			}
		}
		
		return infoBottomSheet(
			isPresented: isPresented,
            dragToDismiss: dragToDismiss,
            tapToDismiss: tapToDismiss,
			height: height,
			topBarCornerRadius: topBarCornerRadius,
			contentBackgroundColor: contentBackgroundColor,
			showTopIndicator: showTopIndicator
		) {
			if let unwrapedItem = item.wrappedValue {
				content(unwrapedItem)
			} else {
				EmptyView()
			}
		}
	}
}

