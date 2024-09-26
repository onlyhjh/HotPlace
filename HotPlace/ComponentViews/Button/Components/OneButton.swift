//
//  CustomButton.swift
//  IOS_CleanArchitecture_Sample
//
//  Created by 60156664 on 14/06/2022.
//

import SwiftUI

// Button style
struct OneButtonStyle: ButtonStyle {
    var backgroundType: OneButtonBackgroundType
    var size: OneButtonSize
    var colorType: OneButtonFilledColorType
    var iconType: OneButton.OneButtonIconType
    
    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        switch backgroundType {
        case .filled: return AnyView(FilledButton(fillColor: colorType, size: size, iconType: iconType, configuration: configuration))
        case .outlined: return AnyView(OutlinedButton(size: size, iconType: iconType, configuration: configuration))
        case .outlinedInvisible: return AnyView(OutlinedButton(size: size, iconType: iconType, configuration: configuration, backgroundColor: Color.subPageBG))
        case .ghost: return AnyView(GhostButton(size: size, configuration: configuration))
        }
    }
    
    struct FilledButton: View {
        var fillColor: OneButtonFilledColorType
        var size: OneButtonSize
        var iconType: OneButton.OneButtonIconType

        private var backgroundColor: Color {
            switch fillColor {
            case .primary:
                return .blue700
            case .gray:
                return .gray200
            case .background:
                return .blue900
            }
        }
        
        private var backgroundPressedColor: Color {
            switch fillColor {
            case .primary:
                return .blue900
            case .gray:
                return .gray300
            case .background:
                return .navy900
            }
        }
        
        private var foregroundColor: Color {
            switch fillColor {
            case .primary:
                return .white
            case .gray:
                return .gray900
            case .background :
                return .white
            }
        }
        
        var trailing: CGFloat {
            switch size {
            case .fullSize, .xlarge, .large, .medium:
                switch iconType {
                case .none:
                    return 16
                case .left:
                    return 20
                case .right:
                    return 16
                }
            case.small, .xsmall:
                switch iconType {
                case .none:
                    return 12
                case .left:
                    return 16
                case .right:
                    return 12
                }
            case .tiny:
                switch iconType {
                case .none:
                    return 8
                case .left:
                    return 12
                case .right:
                    return 8
                }
            }
        }
        
        var leading: CGFloat {
            switch size {
            case .fullSize, .xlarge, .large, .medium:
                switch iconType {
                case .none:
                    return 16
                case .left:
                    return 16
                case .right:
                    return 20
                }
            case.small, .xsmall:
                switch iconType {
                case .none:
                    return 12
                case .left:
                    return 12
                case .right:
                    return 16
                }
            case .tiny:
                switch iconType {
                case .none:
                    return 8
                case .left:
                    return 8
                case .right:
                    return 12
                }
            }
        }
        
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
      
        var body: some View {
            configuration.label
                .typography(size.textSize, weight: .medium, color: isEnabled ? foregroundColor : foregroundColor.opacity(0.4))
                .padding(.leading, leading)
                .padding(.trailing, trailing)
                .frame(height: size.buttonHeight)
                .background( configuration.isPressed ? backgroundPressedColor : backgroundColor)
                .cornerRadius(size.cornerRadius)
        }
    }
    
    struct OutlinedButton: View {
        var size: OneButtonSize

        private var foregroundColorState: Color {
            return isEnabled ? .blue700 : .gray400
        }
        var iconType: OneButton.OneButtonIconType

        var trailing: CGFloat {
            switch size {
            case .fullSize, .xlarge, .large, .medium:
                switch iconType {
                case .none:
                    return 16
                case .left:
                    return 20
                case .right:
                    return 16
                }
            case.small, .xsmall:
                switch iconType {
                case .none:
                    return 12
                case .left:
                    return 16
                case .right:
                    return 12
                }
            case .tiny:
                switch iconType {
                case .none:
                    return 8
                case .left:
                    return 12
                case .right:
                    return 8
                }
            }
        }
        
        var leading: CGFloat {
            switch size {
            case .fullSize, .xlarge, .large, .medium:
                switch iconType {
                case .none:
                    return 16
                case .left:
                    return 16
                case .right:
                    return 20
                }
            case.small, .xsmall:
                switch iconType {
                case .none:
                    return 12
                case .left:
                    return 12
                case .right:
                    return 16
                }
            case .tiny:
                switch iconType {
                case .none:
                    return 8
                case .left:
                    return 8
                case .right:
                    return 12
                }
            }
        }
        let configuration: ButtonStyle.Configuration
		var backgroundColor: Color = .white
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .typography(size.textSize, weight: .medium, color: configuration.isPressed ? .blue900 : foregroundColorState)
                .padding(.leading, leading)
                .padding(.trailing, trailing)
                .frame(height: size.buttonHeight)
                .background(backgroundColor)
                .cornerRadius(size.cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: size.cornerRadius)
                        .stroke(configuration.isPressed ? .blue900 : foregroundColorState, lineWidth: 1)
                )
        }
    }
    
    struct GhostButton: View {
        var size: OneButtonSize

        // TODO: update color by state
        private var foregroundColorState: Color {
            return isEnabled ? .black : .gray400
        }

        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .typography(size.textSize, weight: .medium, color: configuration.isPressed ? .gray400 : foregroundColorState)
                .padding()
                .frame(height: size.buttonHeight)
                .background(Color.white)
                .cornerRadius(size.cornerRadius)
        }
    }
}

public enum OneButtonBackgroundType {
    case filled
    case outlined
	case outlinedInvisible
    case ghost
}

public enum OneButtonFilledColorType {
    case primary // Main color = blue 700
    case gray    // Gray color
    case background // For screens with backgrounds such as login pages, use One Button_Background.
}

public enum OneButtonSize {
    case fullSize, xlarge, large, medium, small, xsmall, tiny
    
    var textSize: CGFloat {
        switch self {
        case .fullSize, .xlarge, .large: return 17
        case .medium: return 15
        case.small, .xsmall, .tiny: return 13
        }
    }
    
    var buttonHeight: CGFloat {
        switch self {
        case .fullSize, .xlarge: return 52
        case .large: return 48
        case .medium: return 44
        case.small: return 36
        case .xsmall: return 32
        case .tiny: return 28
        }
    }
    
    var iconHeight: CGFloat {
        switch self {
        case .fullSize, .xlarge, .large, .medium: return 16
        case .small, .xsmall, .tiny: return 12
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .fullSize, .xlarge, .large: return 10
        case .medium, .small: return 8
        case .xsmall, .tiny: return 6
        }
    }
    
    var textIconSpacing: CGFloat {
        switch self {
        case .fullSize, .xlarge, .large: return 4
        case .medium, .small, .xsmall, .tiny: return 2
        }
    }
}

public struct OneButton: View {
    enum OneButtonIconType {
        case none // none icon
        case left // has left icon
        case right // has right icon
    }
    
    var text: String?
    var leftIcon: Image?
    var rightIcon: Image?
    var colorType: OneButtonFilledColorType = .primary
    var backgroundType: OneButtonBackgroundType = .filled
    var size: OneButtonSize = .xlarge
    var action: () -> Void
    @State var isButtonDisabled: Bool = false

    private var textAndImage: Bool { (text != nil && leftIcon != nil) || (text != nil && rightIcon != nil) }
    
    private var iconType: OneButtonIconType {
        if leftIcon != nil {
            return .left
        } else if rightIcon != nil {
            return .right
        } else {
            return .none
        }
    }
    
    public init(text: String?,
         leftIcon: Image? = nil,
         rightIcon: Image? = nil,
         colorType: OneButtonFilledColorType = .primary,
         size: OneButtonSize = .xlarge,
         backgroundType: OneButtonBackgroundType = OneButtonBackgroundType.filled,
         action: @escaping () -> Void) {
        self.text = text
        self.leftIcon = leftIcon
        self.rightIcon = rightIcon
        self.colorType = colorType
        self.size = size
        self.backgroundType = backgroundType
        self.action = action
    }
    
    public var body: some View {
        Button(action: {
            action()
            // Delay 0.3 seconds to disable multi tap
            isButtonDisabled = true
            // Reset the flag after a short delay to re-enable the button
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isButtonDisabled = false
            }
        }, label: {
            HStack(spacing: textAndImage ? size.textIconSpacing : 0) {
                if size == .fullSize || size == .xlarge || size == .large {
                    Spacer()
                }
                if let leftIcon = leftIcon {
                    leftIcon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: size.iconHeight, height: size.iconHeight)
                    
                }
                Text(text ?? "")
                if let rightIcon = rightIcon {
                    rightIcon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: size.iconHeight, height: size.iconHeight)
                }
                if size == .fullSize || size == .xlarge || size == .large {
                    Spacer()
                }
            }
            
        })
        .type(backgroundType, size: size, colorType: colorType, iconType: iconType)
        .disabled(isButtonDisabled)
    }
}

// MARK: - Usage
extension Button {
    func type(_ backgroundType: OneButtonBackgroundType, size: OneButtonSize, colorType: OneButtonFilledColorType, iconType: OneButton.OneButtonIconType) -> some View {
        self.buttonStyle(OneButtonStyle(backgroundType: backgroundType, size: size, colorType: colorType, iconType: iconType))
    }
}

struct OneButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            OneButton(text: "Button filled gray",
                      leftIcon: Image(systemName: "trash"),
                      colorType: .gray,
                      size: .fullSize,
                      backgroundType: .filled) {}
                      .frame(maxWidth: .infinity)
			OneButton(text: "Button outlined invisible",
					  leftIcon: Image(systemName: "trash"),
					  colorType: .gray,
					  size: .fullSize,
					  backgroundType: .outlinedInvisible) {}
				.frame(maxWidth: .infinity)
            OneButton(text: "Button filled blue",
                      leftIcon: Image(systemName: "trash"),
                      colorType: .primary,
                      size: .large,
                      backgroundType: .filled) {}.disabled(true)
                .disabled(true)
            OneButton(text: "Button outlined",
                      rightIcon: Image(systemName: "star"),
                      size: .xsmall,
                      backgroundType: .outlined) {}
                .disabled(true)
            
            OneButton(text: "Button right icon",
                      rightIcon: Image(systemName: "star"),
                      size: .tiny,
                      backgroundType: .filled) {}
            
            OneButton(text: "Button right icon",
                      leftIcon: Image(systemName: "star"),
                      size: .medium,
                      backgroundType: .filled) {}
            OneButton(text: "Button right icon",
                      leftIcon: Image(systemName: "star"),
                      size: .medium,
                      backgroundType: .ghost) {}

        }.padding()
    }
}
