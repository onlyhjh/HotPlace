//
//  TextButton.swift
//  IOS_CleanArchitecture_Sample
//
//  Created by 60156664 on 15/06/2022.
//

import SwiftUI

// Text Button style
struct TextButtonStyle: ButtonStyle {
    var type: TextButton.TextButtonType
    var size: TextButton.TextButtonSize
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    private var foregroundColorState: Color {
        return isEnabled ? foregroundColor : .gray400
    }
    
    private var foregroundPressedColor: Color {
        switch type {
        case .primary:
            return .blue900
        case .gray:
            return .gray900
        }
    }
    
    private var foregroundColor: Color {
        switch type {
        case .primary:
            return .blue700
        case .gray:
            return .gray500
        }
    }

    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        configuration.label
            .typography(size.textSize, weight: .medium, color: configuration.isPressed ? foregroundPressedColor : foregroundColorState)
    }
}

extension Button {
    func textButtonStyle(type: TextButton.TextButtonType, size: TextButton.TextButtonSize ) -> some View {
        self.buttonStyle(TextButtonStyle(type: type, size: size))
    }
}

public struct TextButton: View {
    public enum TextButtonSize {
        case medium
        case small

        var iconSize: CGFloat {
            switch self {
            case .medium:
                return 16.0
            case .small:
                return 12.0
            }
        }
        
        var textSize: CGFloat {
            switch self {
            case .medium:
                return 15.0
            case .small:
                return 13.0
            }
        }
        
        var textIconSpacing: CGFloat {
            switch self {
            case .medium: return 4
            case .small: return 2
            }
        }
    }

    public enum TextButtonType {
        case primary
        case gray
    }
    
    var text: String
    var leftIcon: Image?
    var rightIcon: Image?
    
    var type: TextButtonType = .primary
    var hasUnderLine: Bool = false
    var size: TextButtonSize = .medium
    var action: () -> Void
    
    private var spacing: CGFloat {
        if leftIcon != nil || rightIcon != nil {
            return size.textIconSpacing
        }
        return 0
    }
    
    public init(text: String,
                leftIcon: Image? = nil,
                rightIcon: Image? = nil,
                type: TextButtonType = .primary,
                hasUnderLine: Bool = false,
                size: TextButtonSize = .medium,
                action: @escaping () -> Void) {
        self.text = text
        self.leftIcon = leftIcon
        self.rightIcon = rightIcon
        self.type = type
        self.hasUnderLine = hasUnderLine
        self.size = size
        self.action = action
    }
    
    public init(text: String,
                type: TextButtonType = .primary,
                hasUnderLine: Bool = false,
                size: TextButtonSize = .medium,
                action: @escaping () -> Void) {
        self.text = text
        self.type = type
        self.hasUnderLine = hasUnderLine
        self.size = size
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: spacing) {
                if let leftIcon = leftIcon {
                    leftIcon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: size.iconSize,
                               height: size.iconSize)
                }

                // Text
                if hasUnderLine {
                    Text(text)
                        .underline()
                } else {
                    Text(text)
                }
                // Right Icon
                if let rightIcon = rightIcon {
                    rightIcon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: size.iconSize,
                               height: size.iconSize)
                }
            }
        }
        .textButtonStyle(type: type, size: size)
    }
}

struct TextButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TextButton(text: "Text button",
                       rightIcon: Image(systemName: "star"),
                       type: .gray,
                       hasUnderLine: false,
                       size: .medium, action: {
            })
            
            TextButton(text: "Text button",
                       rightIcon: Image(systemName: "star"),
                       type: .gray,
                       hasUnderLine: false,
                       size: .small, action: {
            })
        }
    }
}
