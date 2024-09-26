//
//  Typography.swift
//  IOS_CleanArchitecture_Sample
//
//  Created by Dai FPT on 14/06/2022.
//

import SwiftUI

public struct Typography: ViewModifier {
    public enum Style {
        // Heading
        case heading1, heading2, heading3, heading4,
             // TODO: - 가이드에 존재하지 않음, 향후 제거대상
             heading5, heading6
        // Body
        case body1, body2, body3
        // Caption
        case caption1, caption2, caption3
        
        var size:CGFloat {
            var size: CGFloat = 11
            
            switch self {
            // Heading
            case .heading1:
                size = 22
            case .heading2:
                size = 20
            case .heading3:
                size = 17
            case .heading4:
                size = 16
            
            // TODO: - 가이드에 존재하지 않음, 향후 제거대상
            // ---8<--- 제거 혹은 추가 대상, 가이드 오면 점검대상
            case .heading5:
                size = 16
            case .heading6:
                size = 16
            // --->8---
                
            // Body
            case .body1:
                size = 16
            case .body2:
                size = 15
            case .body3:
                size = 13
                
            // Caption
            case .caption1:
                size = 13
            case .caption2:
                size = 12
            case .caption3:
                size = 11
            }
            
            return size
        }
    }
    
    /// 글머리 기호
    public enum BulletPoint {
        case dot   // .
        case dash  // -
        
        func getView() -> some View {
            switch self {
            case .dot:
                return Rectangle()
                    .frame(width: 4, height: 4)
                    .cornerRadius(2)
                    .padding(.trailing, 4)
            case .dash:
                return Rectangle()
                    .frame(width: 6, height: 1)
                    .cornerRadius(1)
                    .padding(.trailing, 2)
            }
        }
    }
    
    var style: Style
    var weight: Font.Weight
    
    public func body(content: Content) -> some View {
        return content
            .modifier(FontStyle(size: style.size, weight: weight, relativeTo: .body))
    }
}

extension View {
    public func typography(_ style: Typography.Style, weight: Font.Weight) -> some View {
        self
            .modifier(Typography(style: style, weight: weight))
    }
    
    public func typography(_ style: Typography.Style, weight: Font.Weight, color: Color) -> some View {
        self
            .modifier(Typography(style: style, weight: weight))
            .foregroundColor(color)
    }
    
    public func typography(_ size: CGFloat, weight: Font.Weight, color: Color) -> some View {
        self
            .modifier(FontStyle(size: size, weight: weight, relativeTo: .body))
            .foregroundColor(color)
    }

    /// font 및 글머리 기호를 설정합니다.
    /// - Parameters:
    ///   - size: font size
    ///   - weight: font weight
    ///   - color: font 및 글머리 기호 color
    ///   - bullet: 글머리 기호 타입
    /// - Returns: font 및 글머리기 기호가 적용된 view
    public func typography(_ size: CGFloat, weight: Font.Weight, color: Color, bullet: Typography.BulletPoint) -> some View {
        HStack(alignment: .top, spacing: 4) {
            bullet.getView()
                .padding(.top, size/2)
            self
                .font(.system(size: size, weight: weight))
                .foregroundColor(color)
        }
        .foregroundColor(color)
    }
    
    public func typography(_ style: Typography.Style, weight: Font.Weight, color: Color, bullet: Typography.BulletPoint) -> some View {
        HStack(alignment: .top, spacing: 4) {
            bullet.getView()
                .padding(.top, style.size/2)
            self
                .font(.system(size: style.size, weight: weight))
                .foregroundColor(color)
        }
        .foregroundColor(color)
    }
}

struct FontStyle: ViewModifier {
    let size: CGFloat
    let weight: Font.Weight
    var relativeTo: Font.TextStyle = .body
    
    func getFont(languageCode: String) -> Font {
        if languageCode == "km" {
            switch weight {
            case .black:
                return  Font.custom("Battambang-Black", size: size, relativeTo: relativeTo)
            case .heavy:
                return  Font.custom("Battambang-Black", size: size, relativeTo: relativeTo)
            case .heavy:
                return  Font.custom("Battambang-Bold", size: size, relativeTo: relativeTo)
            case .semibold:
                return  Font.custom("Battambang-Bold", size: size, relativeTo: relativeTo)
            case .medium:
                return  Font.custom("Battambang-Regular", size: size, relativeTo: relativeTo)
            case .semibold:
                return  Font.custom("Battambang-Regular", size: size, relativeTo: relativeTo)
            case .regular:
                return  Font.custom("Battambang-Light", size: size, relativeTo: relativeTo)
            case .ultraLight:
                return  Font.custom("Battambang-Light", size: size, relativeTo: relativeTo)
            case .thin:
                return  Font.custom("Battambang-Thin", size: size, relativeTo: relativeTo)
            default:
                return  Font.custom("Battambang-Regular", size: size, relativeTo: relativeTo)
            }
        } else {
            return Font.system(size: size, weight: weight)
        }
    }
    
   // var selectedLanguage: String = UserDefaults.standard.selectedLanguage
    
    @State var language: String?
    
    func body(content: Content) -> some View {
        content
            .font(
                self.getFont(languageCode: language ?? AppConstants.languageCode)
            )
            .onReceive(NotificationCenter.default.publisher(for: AppConstants.changeLanguageNotiName)) { _ in
                language = AppConstants.languageCode
            }
    }
}


extension View {
    func fontStyle(
        size: CGFloat,
        weight: Font.Weight = .semibold,
        relativeTo: Font.TextStyle = .body
    ) -> some View {
        modifier(FontStyle(size: size, weight: weight, relativeTo: relativeTo))
    }
}


// MARK: - Preview Code Here!
struct Typography_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            Group {
                Text("Heading 1\nHeading 1").typography(.heading1, weight: .heavy, color: .blue)
                Text("Heading 2\nHeading 2").typography(.heading2, weight: .heavy, color: .blue)
                Text("Heading 3\nHeading 3").typography(.heading3, weight: .heavy, color: .blue)
                Text("Heading 4\nHeading 4").typography(.heading4, weight: .medium, color: .blue)
                Text("Heading 5\nHeading 5").typography(.heading5, weight: .medium, color: .blue)
                Text("Heading 6\nHeading 6").typography(.heading6, weight: .medium, color: .blue)
            }
            
            Group {
                Text("Body 1\nBody 1").typography(.body1, weight: .heavy)
                Text("Body 2\nBody 2").typography(.body2, weight: .medium)
                Text("Body 3\nBody 3").typography(.body3, weight: .semibold)
            }
            
            Group {
                Text("Caption 1\nCaption 1").typography(.body1, weight: .semibold)
                Text("Caption 2\nCaption 2").typography(.body2, weight: .semibold)
                Text("Caption 3\nCaption 3").typography(.body3, weight: .semibold)
            }
            
            Group {
                Text("Bullet Point dot\nBullet Point dot")
                    .typography(13, weight: .heavy, color: .gray, bullet: .dot)
                Text("Bullet Point dash\nBullet Point dash")
                    .typography(13, weight: .heavy, color: .gray, bullet: .dash)
            }
        }
    }
}
