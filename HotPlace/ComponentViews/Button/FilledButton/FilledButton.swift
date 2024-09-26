//
//  FilledButton.swift
//  gma_common
//
//  Created by 60156664 on 26/09/2022.
//

import SwiftUI

public struct FilledButton: View {
    public enum FilledButtonSize {
        case medium
        case small
        case xsmall
        case tiny
    
        var oneButtonSize: OneButtonSize {
            switch self {
            case .medium: return .medium
            case .small: return .small
            case .xsmall: return .xsmall
            case .tiny: return .tiny
            }
        }
    }
    
    public enum FilledButtonType {
        case primary
        case gray
        
        var oneButtonColorType: OneButtonFilledColorType {
            switch self {
            case .primary:
                return .primary
            case .gray:
                return .gray
            }
        }
    }
    
    var text: String?
    var leftIcon: Image?
    var rightIcon: Image?
    var size: FilledButtonSize = .small
    var type: FilledButtonType = .primary
    var action: () -> Void = {}
    
    public init(text: String?,
                leftIcon: Image? = nil,
                rightIcon: Image? = nil,
                size: FilledButtonSize = .small,
                type: FilledButtonType = .primary,
                action: @escaping () -> Void = {}) {
        self.text = text
        self.leftIcon = leftIcon
        self.rightIcon = rightIcon
        self.size = size
        self.type = type
        self.action = action
    }

    public init(text: String?,
                size: FilledButtonSize = .small,
                type: FilledButtonType = .primary,
                action: @escaping () -> Void = {}) {
        self.text = text
        self.size = size
        self.type = type
        self.action = action
    }

    public var body: some View {
        OneButton(text: text, leftIcon: leftIcon, rightIcon: rightIcon, colorType: type.oneButtonColorType, size: size.oneButtonSize, backgroundType: .filled, action: action)
    }
}

struct FilledButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            FilledButton(text: "Button")
            FilledButton(text: "Button", leftIcon: .init(systemName: "trash"))
            FilledButton(text: "Button", rightIcon: .init(systemName: "star"))

            FilledButton(text: "Button", size: .xsmall)
            FilledButton(text: "Button", leftIcon: .init(systemName: "trash"), size: .tiny)
            
            FilledButton(text: "Button", size: .xsmall, type: .gray)
            FilledButton(text: "Button", leftIcon: .init(systemName: "trash"), size: .tiny, type: .gray)

        }.padding()
    }
}
