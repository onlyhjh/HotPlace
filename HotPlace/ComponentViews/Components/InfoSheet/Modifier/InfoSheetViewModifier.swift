//
//  InfoSheetViewModifier.swift
//  IOS_CleanArchitecture_Sample
//
//  Created by 60029474 on 2022/06/07.
//

import SwiftUI

// MARK: - ViewModidifer 이용하기 위한 함수 추가
extension View {
	/**
	 - parameter sKeyPadViewModel: 키보드 뷰 모델, 이벤트 처리 및 show/hide
	 - parameter type: 키보드 타입
	 */
	public func uses(infoSheetViewModel: InfoSheetViewModel) -> some View {
		modifier(InfoSheetViewModifier(infoSheetViewModel: infoSheetViewModel))
	}
}

// TODO: - uses를 통해 등록하면 등록이 되면 화면에 메모리가 생성됨. 메모리를 동적으로 생성해야 하는 경우는 infoBottomSheet 대신 메모리를 동적으로 생성하는 bottomSheet를 새로 제작해야함

public struct InfoSheetViewModifier: ViewModifier {
	
	@ObservedObject public var infoSheetViewModel: InfoSheetViewModel
	
	public
	func body(content: Content) -> some View {
		GeometryReader { geo in
			ZStack(alignment: .top) {
				content
			}
			//.debugFrame()
			.infoBottomSheet(isPresented: $infoSheetViewModel.isPresented, height: geo.size.height, content: {
                VStack {
                    Spacer()
                    Alert(type: infoSheetViewModel.imageType?.alertType ?? .information,
                          configuration: AlertConfigurations(hasIcon: infoSheetViewModel.imageType != .none,
                                                             hasCloseButton: infoSheetViewModel.hasCloseButton,
                                                             title: infoSheetViewModel.title ?? "",
                                                             description: infoSheetViewModel.description,
                                                             caption: infoSheetViewModel.caption ?? "",
                                                             textAlignment: infoSheetViewModel.textAlignment,
                                                             button1Title: infoSheetViewModel.button1Title ,
                                                             button1Action: {
                        infoSheetViewModel.isPresented = false
                        if let button1Action = infoSheetViewModel.button1Action {
                            button1Action()
                        }
                    },
                                                             button2Title: infoSheetViewModel.button2Title,
                                                             button2Action: {
                        infoSheetViewModel.isPresented = false
                        if let button2Action = infoSheetViewModel.button2Action {
                            button2Action()
                        }
                    },
                                                             closeAction: {
                        infoSheetViewModel.isPresented = false
                        if let closeAction = infoSheetViewModel.closeAction {
                            closeAction()
                        }
                    }))
                }
			})
		}
	}
}
