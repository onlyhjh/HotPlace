//
//  ToastModifier.swift
//  IOS_CleanArchitecture_Sample
//
//  Created by 60117637 on 2022/07/26.
//

import SwiftUI

// MARK: - ViewModidifer 이용하기 위한 함수 추가
extension View {
    /**
      - parameter sKeyPadViewModel: 키보드 뷰 모델, 이벤트 처리 및 show/hide
      - parameter type: 키보드 타입
     */
    public func uses(toastVM: ToastViewModel) -> some View {
        modifier(ToastViewModfier(vm: toastVM))
    }
}

// TODO: - uses를 통해 등록하면 등록이 되면 화면에 메모리가 생성됨. 메모리를 동적으로 생성해야 하는 경우는 infoBottomSheet 대신 메모리를 동적으로 생성하는 bottomSheet를 새로 제작해야함

public struct ToastViewModfier: ViewModifier {
    @ObservedObject public var vm: ToastViewModel
    public func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
        }
        // MARK: - Demo Toast
        .toastOverlay(icon: vm.icon, message: vm.toastMessage, isDisplay: $vm.isShow, duration: vm.toastDuration, bottomPadding: vm.bottomPadding)
    }
}
