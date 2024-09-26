//
//  CTAButton.swift
//  gma_common
//
//  Created by 60156664 on 26/09/2022.
//

import SwiftUI

extension View {
    public func basicStyle() -> some View {
        self
            .buttonStyle(.plain)
    }
}

public protocol CTAButtonConfig {
}

public enum CTAButtonConfigUsage {
    case subPage
    case popup
    case clear

    var backgroundColor: Color {
        switch self {
        case .subPage:
            return Color.subPageBG
        case .popup:
            return Color.white
        case .clear:
            return Color.clear
        }
    }
}

public struct OneButtonConfig: CTAButtonConfig {
    var text: String?
    var leftIcon: Image?
    var rightIcon: Image?
    var colorType: OneButtonFilledColorType = .primary
    var backgroundType: OneButtonBackgroundType = .filled
    var usage: CTAButtonConfigUsage = .subPage
    var action: () -> Void = {}
    
    public init(text: String?,
                leftIcon: Image? = nil,
                rightIcon: Image? = nil,
                colorType: OneButtonFilledColorType = .primary,
                backgroundType: OneButtonBackgroundType = OneButtonBackgroundType.filled,
                usage: CTAButtonConfigUsage = .subPage,
                action: @escaping () -> Void = {}) {
        self.text = text
        self.leftIcon = leftIcon
        self.rightIcon = rightIcon
        self.colorType = colorType
        self.backgroundType = backgroundType
        self.usage = usage
        self.action = action
    }
    
    public init(text: String?,
                leftIcon: Image? = nil,
                rightIcon: Image? = nil,
                colorType: OneButtonFilledColorType = .primary,
                backgroundType: OneButtonBackgroundType = OneButtonBackgroundType.filled,
                action: @escaping () -> Void = {}) {
        self.text = text
        self.leftIcon = leftIcon
        self.rightIcon = rightIcon
        self.colorType = colorType
        self.backgroundType = backgroundType
        self.action = action
    }
    
    
    public init(text: String?,
                colorType: OneButtonFilledColorType = .primary,
                backgroundType: OneButtonBackgroundType = OneButtonBackgroundType.filled,
                action: @escaping () -> Void = {}) {
        self.text = text
        self.colorType = colorType
        self.backgroundType = backgroundType
        self.action = action
    }
}

public struct TwoButtonConfig: CTAButtonConfig {
    public enum TwoButtonOrientation {
        case horizon
        case vertical
    }
    
    public enum TwoButtonSize {
        case xlarge
        case large
        
        var oneButtonSize: OneButtonSize {
            switch self {
            case .xlarge:
                return .xlarge
            case .large:
                return .large
            }
        }
        
        var height: CGFloat {
            switch self {
            case .xlarge: return 52
            case .large: return 48
            }
        }
    }

    var text1: String
    var text2: String
	var leftIcon1: Image?
	var rightIcon1: Image?
	var leftIcon2: Image?
	var rightIcon2: Image?
    var orientation: TwoButtonOrientation = .vertical
    /*
     * ratio of button1 width/ button2 width:
     * ratio 1:1 : 1
     * ratio 1:2 : 0.5
     */
    var ratio: CGFloat = 0.5
    var usage: CTAButtonConfigUsage = .subPage
    var actionButton1: () -> Void = {}
    var actionButton2: () -> Void = {}

    public init(text1: String,
                text2: String,
				leftIcon1: Image? = nil,
				rightIcon1: Image? = nil,
				leftIcon2: Image? = nil,
				rightIcon2: Image? = nil,
                orientation: TwoButtonOrientation = .horizon,
                ratio: CGFloat = 0.5,
                actionButton1: @escaping () -> Void = {},
                actionButton2: @escaping () -> Void = {}) {
        self.text1 = text1
        self.text2 = text2
		self.leftIcon1 = leftIcon1
		self.rightIcon1 = rightIcon1
		self.leftIcon2 = leftIcon2
		self.rightIcon2 = rightIcon2
        self.orientation = orientation
        self.ratio = ratio
        self.actionButton1 = actionButton1
        self.actionButton2 = actionButton2
    }
    
    public init(text1: String,
                text2: String,
				leftIcon1: Image? = nil,
				rightIcon1: Image? = nil,
				leftIcon2: Image? = nil,
				rightIcon2: Image? = nil,
                orientation: TwoButtonOrientation = .horizon,
                ratio: CGFloat = 0.5,
                usage: CTAButtonConfigUsage = .subPage,
                actionButton1: @escaping () -> Void = {},
                actionButton2: @escaping () -> Void = {}) {
        self.text1 = text1
        self.text2 = text2
		self.leftIcon1 = leftIcon1
		self.rightIcon1 = rightIcon1
		self.leftIcon2 = leftIcon2
		self.rightIcon2 = rightIcon2
        self.orientation = orientation
        self.ratio = ratio
        self.usage = usage
        self.actionButton1 = actionButton1
        self.actionButton2 = actionButton2
    }
}

public struct ThreeButtonConfig: CTAButtonConfig {
    var text1: String
    var text2: String
    var text3: String
    var actionButton1: () -> Void = {}
    var actionButton2: () -> Void = {}
    var actionButton3: () -> Void = {}

    public init(text1: String,
                text2: String,
                text3: String,
                actionButton1: @escaping () -> Void = {},
                actionButton2: @escaping () -> Void = {},
                actionButton3: @escaping () -> Void = {}) {
        self.text1 = text1
        self.text2 = text2
        self.text3 = text3
        self.actionButton1 = actionButton1
        self.actionButton2 = actionButton2
        self.actionButton3 = actionButton3
    }
}

public enum CTAButtonType {
    case basic
	case basicInvisible
    case fixed
    case alert
}

public struct CTAButton: View {
    var type: CTAButtonType
    var config: CTAButtonConfig
    
    public init(type: CTAButtonType, config: CTAButtonConfig) {
        self.type = type
        self.config = config
    }
    
    public init(type: CTAButtonType, config: OneButtonConfig) {
        self.type = type
        self.config = config
    }
    
    public var body: some View {
        switch type {
        case .basic:
            getBasicButton(config: config)
		case .basicInvisible:
			getBasicButton(config: config, isInvisible: true)
        case .fixed:
            getFixedButton(config: config)
        case .alert:
            getAlertButton(config: config)
        }
    }

    @ViewBuilder
	private func getBasicButton(config: CTAButtonConfig, isInvisible: Bool = false) -> some View {
        if config is OneButtonConfig {
            if let config = config as? OneButtonConfig  {
                OneButton(text: config.text,
                          leftIcon: config.leftIcon,
                          rightIcon: config.rightIcon,
                          colorType: config.colorType,
                          size: .fullSize,
                          backgroundType: config.backgroundType,
                          action: config.action)
            } else {
                EmptyView()
            }
        } else if config is TwoButtonConfig {
            if let config = config as? TwoButtonConfig  {
                TwoButton(text1: config.text1,
                          text2: config.text2,
						  leftIcon1: config.leftIcon1,
						  rightIcon1: config.rightIcon1,
						  leftIcon2: config.leftIcon2,
						  rightIcon2: config.rightIcon2,
                          orientation: config.orientation,
                          size: .xlarge,
                          ratio: config.ratio,
						  isInvisible: isInvisible,
                          actionButton1: config.actionButton1,
                          actionButton2: config.actionButton2)
            } else {
                EmptyView()
            }
        } else {
            // Three button config
            if let config = config as? ThreeButtonConfig  {
                Group {
                    GeometryReader { geometry in
                        HStack(spacing: 8) {
                            OneButton(text: config.text1, size: .fullSize, action: config.actionButton1)
                                .frame(width: (geometry.size.width - 8*2)/3  /* spacing */)
                            OneButton(text: config.text2, size: .fullSize, action: config.actionButton2)
                                .frame(width: (geometry.size.width - 8*2)/3  /* spacing */)
                            OneButton(text: config.text3, size: .fullSize, action: config.actionButton3)
                                .frame(width: (geometry.size.width - 8*2)/3  /* spacing */)
                        }
                    }
                }
                .frame(height: OneButtonSize.fullSize.buttonHeight)
            } else {
                EmptyView()
            }
        }
    }

    @ViewBuilder
    private func getFixedButton(config: CTAButtonConfig) -> some View {
        if config is OneButtonConfig {
            if let config = config as? OneButtonConfig  {
                ZStack(alignment: .top) {
                    // shadow view
                    Rectangle()
                        .fill(config.usage.backgroundColor)
                        .frame(height: 92)
                    
                    OneButton(text: config.text,
                              leftIcon: config.leftIcon,
                              rightIcon: config.rightIcon,
                              colorType: config.colorType,
                              size: .fullSize,
                              backgroundType: config.backgroundType,
                              action: config.action)
                    .padding(20)

                    Rectangle()
                        .fill(LinearGradient(colors: [.white.opacity(0), config.usage.backgroundColor.opacity(1)], startPoint: .top, endPoint: .bottom))
                        .frame(height: 16)
                }
            } else {
                EmptyView()
            }
        } else if config is TwoButtonConfig {
            if let config = config as? TwoButtonConfig  {
                ZStack(alignment: .top) {
                    // shadow view
                    Rectangle()
                        .fill(config.usage.backgroundColor)
                        .frame(height: 92)
                    
                    TwoButton(text1: config.text1,
                              text2: config.text2,
                              orientation: config.orientation,
                              size: .xlarge,
                              ratio: config.ratio,
                              actionButton1: config.actionButton1,
                              actionButton2: config.actionButton2)
                    .padding(20)
                    
                    Rectangle()
                        .fill(LinearGradient(colors: [.white.opacity(0), config.usage.backgroundColor.opacity(1)], startPoint: .top, endPoint: .bottom))
                        .frame(height: 16)
                }

            } else {
                EmptyView()
            }
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    private func getAlertButton(config: CTAButtonConfig) -> some View {
        if config is OneButtonConfig {
            if let config = config as? OneButtonConfig  {
                OneButton(text: config.text,
                          leftIcon: config.leftIcon,
                          rightIcon: config.rightIcon,
                          colorType: config.colorType,
                          size: .large,
                          backgroundType: config.backgroundType,
                          action: config.action)
            } else {
                EmptyView()
            }
        } else if config is TwoButtonConfig {
            if let config = config as? TwoButtonConfig  {
                TwoButton(text1: config.text1,
                          text2: config.text2,
                          orientation: .vertical,
                          size: .large,
                          ratio: config.ratio,
                          actionButton1: config.actionButton1,
                          actionButton2: config.actionButton2)
            } else {
                EmptyView()
            }
        } else {
            EmptyView()
        }
    }
}

struct CTAButton_Basic_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CTAButton(type: .basic, config: OneButtonConfig(text: "button"))
            CTAButton(type: .basic, config: OneButtonConfig(text: "button", leftIcon: .init(systemName: "trash")))
            CTAButton(type: .basic, config: OneButtonConfig(text: "button", rightIcon: .init(systemName: "star")))
                  .disabled(true)
            CTAButton(type: .basic, config: OneButtonConfig(text: "button", rightIcon: .init(systemName: "star"), backgroundType: .outlined))
            
            CTAButton(type: .basic, config: TwoButtonConfig(text1: "button 1", text2: "button 2"))
            CTAButton(type: .basic, config: TwoButtonConfig(text1: "button 1", text2: "button 2", orientation: .vertical))
            CTAButton(type: .basicInvisible, config: TwoButtonConfig(text1: "button 1", text2: "button 2", leftIcon1: .init(systemName: "trash"), ratio: 1/1))
            CTAButton(type: .basic, config: TwoButtonConfig(text1: "button 1", text2: "button 2", ratio: 1/1))
                .disabled(true)
            
            CTAButton(type: .basic, config: ThreeButtonConfig(text1: "button 1", text2: "button 2", text3: "button button button 3"))
        }
        .padding()
    }
}

struct CTAButton_Fixed_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.yellow
                .edgesIgnoringSafeArea(.all)
            VStack {
                CTAButton(type: .fixed, config: OneButtonConfig(text: "button", usage: .subPage))
                CTAButton(type: .fixed, config: TwoButtonConfig(text1: "button 1", text2: "button 2", ratio: 1, usage: .clear))
                    .background(Color.red)
            }
        }
    }
}


struct CTAButton_Alert_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CTAButton(type: .alert, config: OneButtonConfig(text: "button"))
            CTAButton(type: .alert, config: TwoButtonConfig(text1: "button 1", text2: "button 2"))
        }.padding()
    }
}
