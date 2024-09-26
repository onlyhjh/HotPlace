//
//  InfoBox.swift
//  gma_presentation
//
//  Created by 60156664 on 05/07/2022.
//

import SwiftUI

/**
 A box for delivering messages to customers
 - Author: Shinhan Bank
*/
public struct InfoBox: View {
    public enum InfoBoxStyle {
        case positive
        case informative
        case caution
        case error
        case qrCode
        
        var textColor: Color {
            switch self {
            case .qrCode:
                return .white
            default:
                return .gray700
            }
        }
        
        var backgroundColor: Color {
            switch self {
            case .positive:
                return .semanticPositive.opacity(0.1)
            case .informative:
                return .gray200
            case .caution:
                return .semanticNotice.opacity(0.1)
            case .error:
                return .semanticNegative.opacity(0.1)
            case .qrCode:
                return .black.opacity(0.6)
            }
        }
       // "icon_line_close_12_white"
        var icon: Image {
            switch self {
            case .positive:
                return Image("Icon_filled_20_success")
            case .informative:
                return Image("Icon_filled_20_info")
            case .caution:
                return Image("Icon_filled_20_caution")
            case .error:
                return Image("Icon_filled_20_error")
            case .qrCode:
                return Image("Icon_filled_20_info")
            }
        }
    }

    var message: String
    var isShowIcon: Bool
    var style: InfoBoxStyle
    var closeAction: () -> Void = {}
	/**
	 A box for delivering messages to customers
	 - Parameters:
	   - isShowIcon: Whether an icon is displayed on the left side of the box, if true: there is an icon, false: no icon.
	   - style: InfoBox Style. (informative, notice, negativeDark, negative)
	   - message: Info Message.
	*/
    public init(message: String = "Enter the Informative message here",
                isShowIcon: Bool = true,
                style: InfoBoxStyle,
                closeAction: @escaping () -> Void = {}) {
        self.message = message
        self.isShowIcon = isShowIcon
        self.style = style
        self.closeAction = closeAction
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: isShowIcon ? 8 : 0) {
            if isShowIcon {
                HStack(alignment: .top) {
                    VStack {
                        style.icon
                            .frame(width: 20, height: 20)
                    }
                    VStack(alignment: .center) {
                        Text(message)
                            .typography(.caption1, weight: .regular, color: style.textColor)
                    }.frame(maxWidth: .infinity, minHeight: 20, alignment: .leading)
                }
            } else {
                VStack {
                    Text(message)
                        .typography(.body3, weight: .semibold, color: style.textColor)
                }
            }
        }
        .padding(.top, 12)
        .padding(.bottom, 12)
        .padding(.leading, 12)
        .padding(.trailing, 12)
        .background(style.backgroundColor)
        .cornerRadius(8)
    }
}

struct InfoBox_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            InfoBox(isShowIcon: true, style: .positive)
            InfoBox(isShowIcon: true, style: .informative)
            InfoBox(isShowIcon: true, style: .caution)
            InfoBox(message: "Poor connection. Please check your connection connectionconnection connection", isShowIcon: true, style: .error)

            InfoBox(message: "Poor connection. Please check your connection connectionconnection connection.", isShowIcon: true, style: .qrCode)
                .padding()

        }
        .background(Color.white.ignoresSafeArea())
    }
}
