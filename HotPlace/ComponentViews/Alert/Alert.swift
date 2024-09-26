//
//  Alert.swift
//  gma_presentation
//
//  Created by 60156664 on 07/07/2022.
//

import SwiftUI

public enum AlertType {
    case information
    case warning
    case error
    case success
    case faceId
    case touchId

    var icon: Image {
        switch self {
        case .information:
            return Image("image_alret_informative")
        case .warning:
            return Image("image_alret_notice")
        case .error:
            return Image("image_alret_negative")
        case .success:
            return Image("image_alret_positive")
        case .faceId:
            return Image("image_alret_faceID")
        case .touchId:
            return Image("image_alret_finger")
        }
    }
}


public struct AlertConfigurations {
    var hasIcon: Bool
    var hasCloseButton: Bool
    var title: String = ""
    var description: String = ""
    var caption: String = ""
    var captionBold: Bool = false
    var textAlignment: TextAlignment?
    var image: Image? = nil
    var button1Title: String? = nil
    var button1Action: (() -> Void)? = nil
    var button2Title: String? = nil
    var button2Action: (() -> Void)? = nil
    var closeAction: (() -> Void)? = nil
	var right_image: Bool = false

    public init(hasIcon: Bool = false,
                hasCloseButton: Bool = false,
                title: String = "",
                description: String = "",
                caption: String = "",
                textAlignment: TextAlignment? = nil,
                captionBold: Bool = false,
                image: Image? = nil,
                closeAction: @escaping () -> Void = {}) {
        self.hasIcon = hasIcon
        self.hasCloseButton = hasCloseButton
        self.title = title
        self.description = description
        self.caption = caption
        self.textAlignment = textAlignment
        self.captionBold = captionBold
        self.closeAction = closeAction
        self.image = image
    }
    
    public init(hasIcon: Bool = false,
                hasCloseButton: Bool = false,
                title: String = "",
                description: String = "",
                caption: String = "",
                captionBold: Bool = false,
                textAlignment: TextAlignment? = nil,
                image: Image? = nil,
                btnTitle: String,
                onBtnClick: @escaping (() -> Void),
                closeAction: @escaping () -> Void = {}) {

        self.hasIcon = hasIcon
        self.hasCloseButton = hasCloseButton
        self.title = title
        self.description = description
        self.caption = caption
        self.captionBold = captionBold
        self.textAlignment = textAlignment
        self.image = image
        self.button1Title = btnTitle
        self.button1Action = onBtnClick
        self.closeAction = closeAction
    }
    
    public init(hasIcon: Bool = false,
                hasCloseButton: Bool = false,
                title: String = "",
                description: String = "",
                caption: String = "",
                captionBold: Bool = false,
                textAlignment: TextAlignment? = nil,
                image: Image? = nil,
                button1Title: String? = nil,
                button1Action: (() -> Void)? = nil,
                button2Title: String? = nil,
                button2Action: (() -> Void)? = nil,
                closeAction: (() -> Void)? = nil) {

        self.hasIcon = hasIcon
        self.hasCloseButton = hasCloseButton
        self.title = title
        self.description = description
        self.caption = caption
        self.captionBold = captionBold
        self.textAlignment = textAlignment
        self.image = image
        self.button1Title = button1Title
        self.button1Action = button1Action
        self.button2Title = button2Title
        self.button2Action = button2Action
        self.closeAction = closeAction
    }
	
	public init(right_image: Bool = true,
				title: String = "",
				description: String = "",
				image: Image,
				button1Title: String,
				button1Action: @escaping (() -> Void),
				button2Title: String? = nil,
				button2Action: (() -> Void)? = nil) {

		self.right_image = true
		self.hasIcon = false
		self.hasCloseButton = false
		self.title = title
		self.description = description
		self.caption = ""
		self.image = image
		self.button1Title = button1Title
		self.button1Action = button1Action
		self.button2Title = button2Title
		self.button2Action = button2Action
		self.closeAction = nil
	}
}

/**
Common Alert.
 - Author: Shinhan Bank
*/
public struct Alert: View {
    var type: AlertType = .information
    var configuration: AlertConfigurations
    
	/**
	 Common Alert.
	 - Parameters:
	   - type: AlertType. (information, warning, error, success)
	   - configuration: AlertConfigurations.
	*/
    public init(type: AlertType = .information,
                configuration: AlertConfigurations) {
        self.type = type
        self.configuration = configuration
    }
    
    private var buttonCount: Int {
        if configuration.button1Title != nil && configuration.button2Title != nil {
            return 2
        } else if configuration.button1Title != nil || configuration.button2Title != nil {
            return 1
        } else {
            return 0
        }
    }
    @State private var safeAreaInsets: (top: CGFloat, bottom: CGFloat) = (0, 0)

    func getAlignment() -> Alignment {
        if let textAlignment = configuration.textAlignment {
            if textAlignment == .leading {
                return .leading
            } else if textAlignment == .center {
                return .center
            } else if textAlignment == .trailing {
                return .trailing
            } else {
                return .center
            }
        } else {
           return configuration.hasIcon || configuration.right_image ? .leading : .center
        }
    }
    
    func getAlignmentCaption() -> Alignment {
        if let textAlignment = configuration.textAlignment {
            if textAlignment == .leading {
                return .leading
            } else if textAlignment == .center {
                return .center
            } else if textAlignment == .trailing {
                return .trailing
            } else {
                return .center
            }
        } else {
           return configuration.hasIcon ? .leading : .center
        }
    }
    
    func getMultilineTextAlignment() -> TextAlignment {
        return configuration.textAlignment != nil ? configuration.textAlignment! : (configuration.hasIcon || configuration.right_image ? .leading : .center)
    }
    
    func getMultilineTextAlignmentCaption() -> TextAlignment {
        return configuration.textAlignment != nil ? configuration.textAlignment! : (configuration.hasIcon ? .leading : .center)
    }

    public var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { proxy in
                Color.clear.onAppear {
                    safeAreaInsets = (proxy.safeAreaInsets.top, proxy.safeAreaInsets.bottom)
                }
            }
            
            VStack {
                VStack(alignment: .leading, spacing: 0) {
                    // Navigation
                    HStack {
                        // icon
                        if configuration.hasIcon {
                            VStack {
                                type.icon
                                    .frame(width: 56, height: 56)
                                    .frame(maxHeight: .infinity)
                            }
                            .frame(maxHeight: .infinity)
                            .padding(.leading, 32)
                            .padding(.top, -56)
                        }
                        Spacer()
                        if configuration.hasCloseButton {
                            // Dismiss button
                            VStack {
                                Button(action: {
                                    if let closeAction = configuration.closeAction {
                                        closeAction()
                                    }
                                }, label: {
                                    Image("icon_line_close_24_black")
                                        .frame(width: 24, height: 24)
                                })
                                .basicStyle()
                            }
                            .padding(.trailing, 18)
                            .padding(.top, 20)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: configuration.hasCloseButton ? 56 : 50)
                    
                    VStack(spacing: 0) {
                        if !configuration.title.isEmpty {
                            Text(configuration.title)
                                .typography(.heading1, weight: .heavy, color: .gray900)
                                .frame(maxWidth: .infinity, alignment: getAlignment())
                                .multilineTextAlignment(getMultilineTextAlignment())
                        }
                        if !configuration.description.isEmpty {
                            Text(configuration.description)
                                .typography(.body2, weight: .regular, color: .gray700)
                                .padding(.top, 8)
                                .frame(maxWidth: .infinity, alignment: getAlignment())
                                .multilineTextAlignment(getMultilineTextAlignment())
                        }
                        if !configuration.caption.isEmpty {
                            Text(configuration.caption)
                                .typography(configuration.captionBold ? .body2 : .caption2, weight: configuration.captionBold ? .heavy : .regular, color: configuration.captionBold ? .gray700 : .gray500)
                                .padding(.top, 24)
                                .frame(maxWidth: .infinity, alignment: getAlignmentCaption())
                                .multilineTextAlignment(getMultilineTextAlignmentCaption())
                        }
                        
                        // Image
                        if let image = configuration.image {
                            VStack {
                                image
                                    .padding(.trailing, configuration.right_image ? 10 : 0)
                            }
                            .frame(maxWidth: .infinity, alignment: configuration.right_image ? .trailing : .center)
                            .padding(.top, configuration.right_image ? 0 : 32)
                            .padding(.bottom, configuration.right_image ? 0 : 20)
                        }
                        
                        if buttonCount == 2 {
                            VStack {
                                TwoButton(text1: configuration.button1Title ?? "",
                                          text2: configuration.button2Title ?? "",
                                          orientation: .vertical,
                                          size: .large,
                                          actionButton1: configuration.button1Action ?? {},
                                          actionButton2: configuration.button2Action ?? {})
                            }
                            .padding(.top, configuration.right_image ? 10 : (configuration.caption.isEmpty ? 40 : 24))
                        } else if buttonCount == 1 {
                            VStack {
                                OneButton(text: configuration.button1Title ?? "", size: .fullSize, action: configuration.button1Action ?? {})
                            }
                            .padding(.top, configuration.right_image ? 10 : (configuration.caption.isEmpty ? 40 : 24))
                        }
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, safeAreaInsets.bottom == 0 ? AppConstants.botPaddingNoneSafeArea : (AppConstants.botPaddingSafeArea - safeAreaInsets.bottom))
                }
                .background(Color.white
                    .cornerRadius(16, corners: [.topLeft, .topRight])
                    .edgesIgnoringSafeArea(.bottom))
            }
        }
    }
}

struct Alert_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Alert(type: .information,
                  configuration: AlertConfigurations(hasIcon: true,
                                                     hasCloseButton: true,
                                                     title: "Title title",
                                                     description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Dignissim consectetur.Lorem ipsum dolor sit amet",
                                                     caption: "caption caption captioncaptioncaptioncaption",
                                                     image: Image("image_area_80")))
        }
        .frame(maxHeight: .infinity)
        .background(Color.blue.ignoresSafeArea())
                    
        VStack {
            Alert(type: .error,
                  configuration: AlertConfigurations(hasIcon: false,
                                                     hasCloseButton: true,
                                                     title: "Title title",
                                                     description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Dignissim consectetur.Lorem ipsum dolor sit amet",
                                                     caption: "caption caption captioncaptioncaptioncaption",
                                                     image: Image("image_area_80"),
                                                     btnTitle: "button",
                                                     onBtnClick: {
                
            }))
        }
        .frame(maxHeight: .infinity)
        .background(Color.blue)
        
        VStack {
            Spacer()
            Alert(type: .warning,
                  configuration: AlertConfigurations(hasIcon: true,
                                                     hasCloseButton: true,
                                                     title: "Title title",
                                                     description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Dignissim consectetur.Lorem ipsum dolor sit amet",
                                                     caption: "caption caption captioncaptioncaptioncaption",
                                                     button1Title: "button 1",
                                                     button1Action: {
                
            }))
        }
        .frame(maxHeight: .infinity)
        .background(Color.blue)
        
        VStack {
            Spacer()
            Alert(type: .warning,
                  configuration: AlertConfigurations(hasIcon: true,
                                                     hasCloseButton: true,
                                                     title: "ログインパスワードを一定回数誤ったため、初期化のお手続きが必要です。",
                                                     description: "UI銀行の口座番号がお分かりのお客さまは、お客さま番号・ログインパスワード入力画面の下部にある「ログインパスワードをお忘れの場合」からお手続きができます。\nUI銀行の口座番号がご不明なお客さまは、コンタクトセンターへお電話にてご連絡ください。ご本人さま確認のうえ、口座番号をお知らせします。",
                                                     caption: "コンタクトセンタ―\n 電話番号：0120－860－098\n 受付時間：平日9:00～17:00\n(土日等の銀行休業日を除く)",
                                                     captionBold: true,
                                                     button1Title: "確認",
                                                     button1Action: {
                
            }))
        }
        .frame(maxHeight: .infinity)
        .background(Color.blue)
		
		VStack {
			Alert(type: .warning,
				  configuration: AlertConfigurations(right_image: true,
													 title: "Title",
													 description: "This phone number is not registered with SHINHAN Bank. Would you like to create a new account?",
													 image: Image("image_area_80"),
													 button1Title: "button1Title",
													 button1Action: {},
													 button2Title: "button2Title",
													 button2Action: {})
			)
		}
		.frame(maxHeight: .infinity)
		.background(Color.blue)
    }
}

