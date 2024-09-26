//
//  ViewExtension.swift
//  gma_presentation
//
//  Created by 60156664 on 22/06/2022.
//

import SwiftUI

// MARK: - SearchText 용
extension View {
	public func placeholder<Content: View> (
        isShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(isShow ? 1 : 0)
            self
        }
    }
}


#if canImport(UIKit)
extension View {
	public func hideKeyboard() {
		DispatchQueue.main.async {
			UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
		}
    }
	public func hideKeyboardDelay() {
		// Prevents the showKeyboard immediately after hideKeyboard
		hideKeyboard()
		KeyboardManager.canShowKeyboard = false
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
			KeyboardManager.canShowKeyboard = true
		}
		
		NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillShowNotification)
			.sink { (noti : Notification) in
				if !KeyboardManager.canShowKeyboard {
					self.hideKeyboard()
				}
			}.store(in: &KeyboardManager.subscriptions)
	}
}
#endif

#if canImport(UIKit)
public extension ObservableObject {
    func hideKeyboard() {
        DispatchQueue.main.async {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
	}
    func hideKeyboardDelay() {
		// Prevents the showKeyboard immediately after hideKeyboard
		hideKeyboard()
		KeyboardManager.canShowKeyboard = false
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
			KeyboardManager.canShowKeyboard = true
		}
		
		NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillShowNotification)
			.sink { (noti : Notification) in
				if !KeyboardManager.canShowKeyboard {
					self.hideKeyboard()
				}
			}.store(in: &KeyboardManager.subscriptions)
	}
}
#endif
