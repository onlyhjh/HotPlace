//
//  KeyboardManager.swift
//  gma_common
//
//  Created by 60080254 on 2023/04/10.
//

import Foundation
import Combine
import UIKit

public final class KeyboardManager : ObservableObject {
	
	static var subscriptions = Set<AnyCancellable>()
	static var canShowKeyboard: Bool = true
	
//	public init() {
//		NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillShowNotification)
//			.sink { (noti : Notification) in
//				Logger.log("will show \(KeyboardManager.canShowKeyboard)")
//			}.store(in: &KeyboardManager.subscriptions)
//		NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillHideNotification)
//			.sink { (noti : Notification) in
//				KeyboardManager.canShowKeyboard = false
//				Logger.log("will hide \(KeyboardManager.canShowKeyboard)")
//			}.store(in: &KeyboardManager.subscriptions)
//	}
}
