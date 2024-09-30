//
//  ToastViewModel.swift
//  IOS_CleanArchitecture_Sample
//
//  Created by 60117637 on 2022/07/26.
//

import Combine
import Foundation

import SwiftUI

public class ToastViewModel: ObservableObject {
    // MARK: - Toast
    @Published var isShow: Bool = false
    @Published var toastMessage: String = ""
    @Published var icon: Image?
    @Published var toastDuration: TimeInterval = 3.0
    @Published var bottomPadding: CGFloat = 100

    deinit{
        // Logger.log("", logType: .Info)
    }
    
    public
    init() {
        //Logger.log("", logType: .Info)
    }
    
    public
    func showToast(msg: String,
                   icon: Image? = nil,
                   duration: TimeInterval = 3.0,
                   bottomPadding: CGFloat = 100) {
        self.toastMessage = msg
        self.icon = icon
        self.isShow = true
        self.toastDuration = duration
        self.bottomPadding = bottomPadding
    }
}
