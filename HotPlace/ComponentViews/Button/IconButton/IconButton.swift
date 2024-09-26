//
//  IconButton.swift
//  IOS_CleanArchitecture_Sample
//
//  Created by 60156664 on 15/06/2022.
//

import SwiftUI

public protocol IconButtonConfig {
}

public struct CardIconButtonConfig: IconButtonConfig {
    public enum BackgroundType {
        case colors
        case `default`
        
        var textColor: Color {
            switch self {
            case .colors:
                return .white
            case .default:
                return .gray900
            }
        }
    }
    
    public enum BackgroundColor {
        case emerald
        case blue
        case mustard
        case mint
        case purple
        case orange
        case pink
        case coral
        case rose
        case brown
        
        var gradientColors: [Color] {
            switch self {
            case .emerald:
                return [Color(hex: "#0C8593"), Color(hex: "#17BED9")]
            case .blue:
                return [Color(hex: "#1E59CF"), Color(hex: "#4F8BF4")]
            case .mustard:
                return [Color(hex: "#F68A31"), Color(hex: "#FFC947")]
            case .mint:
                return [Color(hex: "#008359"), Color(hex: "#2EB086")]
            case .purple:
                return [Color(hex: "#4536AD"), Color(hex: "#6A66CE")]
            case .orange:
                return [Color(hex: "#E04F0E"), Color(hex: "#F78812")]
            case .pink:
                return [Color(hex: "#CF2A6F"), Color(hex: "#E6689E")]
            case .coral:
                return [Color(hex: "#F14232"), Color(hex: "#FF6A63")]
            case .rose:
                return [Color(hex: "#B8405E"), Color(hex: "#E45B7C")]
            case .brown:
                return [Color(hex: "#714E29"), Color(hex: "#A08063")]
            }
        }
    }
    
    var id = UUID()
    var isEasyMode: Bool = false
    var text: String
    var icon: Image
    var backgroundType: BackgroundType = .default
    var backgroundColor: BackgroundColor = .blue
    
    public init(isEasyMode: Bool = false, text: String, icon: Image, backgroundType: BackgroundType = .default, backgroundColor: BackgroundColor = .blue) {
        self.isEasyMode = isEasyMode
        self.text = text
        self.icon = icon
        self.backgroundType = backgroundType
        self.backgroundColor = backgroundColor
    }
}

public struct LabelIconButtonConfig: IconButtonConfig {
    public enum IconButtonSize {
        case huge
        case medium
        case small
        
        var iconSize: CGFloat {
            switch self {
            case .huge:
                return 50.0
            case .medium:
                return 40.0
            case .small:
                return 32.0
             }
         }
        
        var textSize: CGFloat {
            switch self {
            case .huge:
                return 12.0
            case .medium:
                return 13.0
            case .small:
                return 13.0
             }
         }
         
         var backgroundSize: CGFloat {
             switch self {
             case .huge:
                 return 74.0
             case .medium:
                 return 64.0
             case .small:
                 return 56.0
             }
         }
     }
         
     var icon: Image
     var text: String
     var lineLimit: Int = 3
     var size: IconButtonSize = .medium
     var textColor: Color = .gray900
     var backgroundColor: Color = .white
     var backgroundOn: Bool = false
     var maxWidth: CGFloat = 0
     var shadowOn: Bool = false
     var action: () -> Void = {}
     
     public init(icon: Image,
                 text: String,
                 lineLimit: Int = 3,
                 size: IconButtonSize = .medium,
                 backgroundOn: Bool = false,
                 action: @escaping () -> Void = {}) {
         self.icon = icon
         self.text = text
         self.lineLimit = lineLimit
         self.size = size
         self.backgroundOn = backgroundOn
         self.action = action
     }
     
     public init(icon: Image,
                 text: String,
                 lineLimit: Int = 3,
                 textColor: Color = .gray900,
                 backgroundColor: Color = .white,
                 backgroundOn: Bool = false,
                 shadowOn: Bool = false,
                 maxWidth: CGFloat = 0,
                 size: IconButtonSize = .medium,
                 action: @escaping () -> Void = {}) {
         self.icon = icon
         self.text = text
         self.lineLimit = lineLimit
         self.size = size
         self.backgroundColor = backgroundColor
         self.shadowOn = shadowOn
         self.backgroundOn = backgroundOn
         self.textColor = textColor
         self.action = action
         self.maxWidth = maxWidth
     }
}

public struct GhostIconButtonConfig: IconButtonConfig {
    var icon: Image
    var size: CGFloat = 32
}

/**
 IconButton
 - Author: Shinhan Bank
*/

public struct IconButton: View {
    var config: IconButtonConfig
    
    
    /// Init function with Ghost icon button config
    /// - Parameter config: GhostIconButtonConfig
    public init(config: GhostIconButtonConfig) {
        self.config = config
    }
    
    /// Init function with Card icon button config
    /// - Parameter config: CardIconButtonConfig
    public init(config: CardIconButtonConfig) {
        self.config = config
    }
    
    /// Init function with Label icon button config
    /// - Parameter config: LabelIconButtonConfig
    public init(config: LabelIconButtonConfig) {
        self.config = config
    }

    public var body: some View {
        if config is CardIconButtonConfig {
        // Card icon button
            if let config = config as? CardIconButtonConfig {
                CardIconButton(config: config)
            } else {
                EmptyView()
            }
        } else if config is LabelIconButtonConfig {
        // Label icon button
            if let config = config as? LabelIconButtonConfig {
                LabelIconButton(config: config)
            } else {
                EmptyView()
            }
        } else {
        // Ghost
            if let config = config as? GhostIconButtonConfig {
                config.icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: config.size, height: config.size)
            } else {
                EmptyView()
            }
        }
    }
}

struct CardIconButton: View {
    var config: CardIconButtonConfig
    public var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Group {
                    Text(config.text)
                        .typography(config.isEasyMode ? 17 : 15, weight: .semibold, color: config.backgroundType.textColor)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                        .lineSpacing(5)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.leading, config.isEasyMode ? 16 : 12)
                .padding(.trailing, config.isEasyMode ? 25.5 : 13.67)
                .padding(.top, config.isEasyMode ? 15 : 12)
                
                Group {
                    config.icon
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: config.isEasyMode ? 56 : 48 , height: config.isEasyMode ? 56 : 48 )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding([.trailing, .bottom], config.isEasyMode ? 8 : 6)
            }
        }
        .frame(height: 104)
        .background(LinearGradient(colors: config.backgroundType == .default ? [.white] : config.backgroundColor.gradientColors, startPoint: .leading, endPoint: .trailing))
        .cornerRadius(16)
        .shadow(color: Color(hex: "162542").opacity(0.06), radius: 8, x: 0, y: 0)
    }
}

struct LabelIconButton: View {
    var config: LabelIconButtonConfig
    var body: some View {
        Button(action: config.action, label: {
            VStack(alignment: .center, spacing: 10) {
                ZStack {
                    if config.backgroundOn {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(config.backgroundColor)
                            .frame(width: config.size.backgroundSize, height: config.size.backgroundSize)
                        
                    }
                    config.icon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: config.size.iconSize, height: config.size.iconSize)
                }
                Text(config.text)
                    .typography(config.size.textSize, weight: config.size == .huge ? .semibold : .medium, color: config.textColor)
                    .lineLimit(config.lineLimit)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: config.maxWidth == 0 ? config.size.backgroundSize + 4 : config.maxWidth)
            }
        }).iconStyle(shadowOn: config.shadowOn)
    }
}

// Icon Button style
struct IconButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    var shadowOn: Bool
    
    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        configuration.label
            .typography(13, weight: .medium, color: isEnabled ? .gray900 : .gray400)
            .background(Color.clear)
            .cornerRadius(10)
            .shadow(color: shadowOn ? .gray900.opacity(0.25) : .clear , radius: 1, x: 0, y: 0)
    }
}

// MARK: - Usage
extension Button {
    func iconStyle(shadowOn: Bool = false) -> some View {
        self.buttonStyle(IconButtonStyle(shadowOn: shadowOn))
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            VStack {
                IconButton(config: GhostIconButtonConfig(icon: Image("image_area_80"), size: 40))
                IconButton(config: CardIconButtonConfig(text: "Card icon", icon: Image("icon_fill_overseas_48"), backgroundType: .colors, backgroundColor: .orange))
                IconButton(config: CardIconButtonConfig(text: "Card icon button", icon: Image("icon_fill_account_32"), backgroundType: .default, backgroundColor: .purple))

                IconButton(config: LabelIconButtonConfig(icon: Image(systemName: "star"),
                                                         text: "Button Button A ad a ad ad ",
                                                         lineLimit: 1,
                                                         size: .medium,
                                                         backgroundOn: true))
                IconButton(config: LabelIconButtonConfig(icon: Image(systemName: "star"),
                                                         text: "Button A",
                                                         size: .medium,
                                                         backgroundOn: false))
                IconButton(config: LabelIconButtonConfig(icon: Image(systemName: "star"),
                                                         text: "Button Button A",
                                                         backgroundColor: .gray200,
                                                         backgroundOn: true,
                                                         shadowOn: true,
                                                         size: .medium))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.white)
    }
}
