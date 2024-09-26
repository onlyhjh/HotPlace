//
//  InfoSheetView.swift
//  IOS_CleanArchitecture_Sample
//
//  Created by 60029474 on 2022/04/22.
//

import SwiftUI

/**
 Network API 요청에서 오류가 발생할때 Alert형 BottomSheet UI
 타이틀, 서브타이틀, 버튼 등이 표시되며 버튼 클릭시 이벤트 처리수행
 */
struct InfoSheetView: View {
	
	typealias function = ()->Void
	
	// image type
    var imageType: InfoSheetViewModel.ImageType? = .none
	
	var titleText: String?
	var bodyText: String?
	var confirmTitle: String
	var cancelTitle: String?
	
	/// do action
	var performAction: function?
	/// do cancel
	var cancelAction: function?
	
	var body: some View {
		VStack {
			Spacer()
			
			VStack(spacing:0) {
                ZStack {
                    VStack {
                        Spacer()
                        Color.white
                            .frame(height:32)
                            .cornerRadius(16, corners: [.topLeft, .topRight])
                    }
                    if let imageType = imageType {
                        VStack {
                            Spacer()
                            HStack {
                                Image(imageType.name)
                                Spacer()
                            }
                        }
                        .padding(.leading, 32)
                        .padding(.bottom, 5)
                    }
                }
                
				VStack {
					VStack(spacing: 8) {
						// Title
                        if let titleText = self.titleText {
                            Text(titleText)
                                .font(.system(size: 22, weight: .heavy))
                                .foregroundColor(Color(hex: "222428"))
                                .multilineTextAlignment(.center)
                        }
						// Body Text
                        if let bodyText = self.bodyText {
                            Text(bodyText)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(Color(hex:"76797E"))
                                .multilineTextAlignment(.center)
                        }
					}
					// 버튼
					Group {
						VStack(spacing: 12) {
                            // 확인 버튼
							Button {
                                if let performAction = performAction {
                                    performAction()
                                }
							} label: {
								buttonView(confirmTitle)
							}
                            
                            // 취소 버튼
                            if let cancelTitle = cancelTitle {
                                Button {
                                    if let cancelAction = cancelAction {
                                        cancelAction()
                                    }
                                } label: {
                                    Text(cancelTitle)
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(Color(hex: "76797E"))
                                        .multilineTextAlignment(.center)
                                }
                            }
						}
					}
				}
				.padding(.bottom, 20)
				.padding(.horizontal, 20)
				.background(Color.white.edgesIgnoringSafeArea(.bottom))
			}
        }
	}
}

// MARK: - Views
extension InfoSheetView {
	// TODO: -  Components
	// MARK: Button
	func buttonView(_ title:String, titleColor:Color = Color(hex:"FFFFFF"), bgColor:Color = Color(hex: "3270EA"))-> some View {
		@ViewBuilder var renderedView: some View {
			ZStack {
				RoundedRectangle(cornerRadius: 8)
					.fill(bgColor)
					.frame( height: 40)
					.opacity(1.0)
				
				Text(title)
					.fontWeight(.medium)
					.multilineTextAlignment(.center)
					.foregroundColor(titleColor)
			}
			.padding(.leading, 20)
			.padding(.trailing, 20)
		}
		return renderedView
	}
}

// MARK: - PreView
struct LoginInfoSheetView_Previews: PreviewProvider {
	static var previews: some View {
		ZStack {
			Color.blue.ignoresSafeArea()
            InfoSheetView(imageType: .warning,
							   titleText: "Your account is locked.",
							   bodyText: "You entered the wrong password 5 times.\nPlease reset your password on the Internet\nbanking.",
							   confirmTitle: "Reset",
							   cancelTitle: "I'll do it next time",
							   performAction: {
				Logger.log("")
			}
			)
		}
	}
}

// MARK: - PreView
struct LoginInfoSheetView2_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            InfoSheetView(imageType: .warning,
                               titleText: nil,
                               bodyText: "You entered the wrong password 5 times.\nPlease reset your password on the Internet\nbanking.",
                               confirmTitle: "Reset",
                               cancelTitle: nil,
                               performAction: {
                Logger.log("")
            },
                               cancelAction: {
                Logger.log("")
            }
            )
        }
    }
}
