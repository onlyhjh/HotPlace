//
//  BasicListHeader.swift
//  gma_common
//
//  Created by 60156664 on 28/09/2022.
//

import SwiftUI


/**
 BasicListHeader
 - Author: Shinhan Bank
*/
public struct BasicListHeader: View {
    public enum BasicListHeaderSize {
        case medium
        case small
        
        var fontStyle: Typography.Style {
            switch self {
            case .medium:
                return .heading5
            case .small:
                return .body2
            }
        }
        
        var fontWeight: Font.Weight {
            switch self {
            case .medium:
                return .heavy
            case .small:
                return .medium
            }
        }
        
        var textColor: Color {
            switch self {
            case .medium:
                return .navy900
            case .small:
                return .gray600
            }
        }
    }
    
    var title: String
    var icon: Image?
    var iconOn: Bool = true
    var size: BasicListHeaderSize = .medium
    
    /// Init function
    /// - Parameters:
    ///   - title: Title of header
    ///   - icon: Right icon of header, optional parameter
    ///   - iconOn: Display icon or not
    ///   - size: Medium and small size, default is medium size. with small size title display and hidden icon
    public init(title: String,
                iconOn: Bool = true,
                icon: Image? = nil,
                size: BasicListHeaderSize = .medium) {
        self.title = title
        self.icon = icon
        self.iconOn = iconOn
        self.size = size
    }
    
    public var body: some View {
        HStack(spacing: 16) {
            Text(title)
                .typography(size.fontStyle, weight: size.fontWeight)
                .foregroundColor(size.textColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            if let icon = icon, iconOn, size != .small {
                VStack {
                    icon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
            }
        }
        .padding(.leading, 20)
        .padding(.trailing, icon != nil ? 18 : 20)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct BasicListHeader_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BasicListHeader(title: "medium title with icon", icon: .init(systemName: "trash"), size: .medium)
            BasicListHeader(title: "medium title")
            BasicListHeader(title: "small title", size: .small)
            BasicListHeader(title: "medium title", size: .medium)
        }
    }
}
