//
//  OutlinedButton.swift
//  gma_common
//
//  Created by 60156664 on 26/09/2022.
//

import SwiftUI

public struct OutlinedButton: View {
    public enum OutlinedButtonSize {
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
    
    var text: String?
    var leftIcon: Image?
    var rightIcon: Image?
    var size: OutlinedButtonSize = .small
    var action: () -> Void = {}
    
    public init(text: String?,
                leftIcon: Image? = nil,
                rightIcon: Image? = nil,
                size: OutlinedButtonSize = .small,
                action: @escaping () -> Void = {}) {
        self.text = text
        self.leftIcon = leftIcon
        self.rightIcon = rightIcon
        self.size = size
        self.action = action
    }
    
    public init(text: String?,
                size: OutlinedButtonSize = .small,
                action: @escaping () -> Void = {}) {
        self.text = text
        self.size = size
        self.action = action
    }

    public var body: some View {
        OneButton(text: text, leftIcon: leftIcon, rightIcon: rightIcon, colorType: .primary, size: size.oneButtonSize, backgroundType: .outlined, action: action)
    }
}

struct OutlinedButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            OutlinedButton(text: "Button")
            OutlinedButton(text: "Button", leftIcon: .init(systemName: "trash"))
            OutlinedButton(text: "Button", rightIcon: .init(systemName: "star"))

            OutlinedButton(text: "Button", size: .xsmall)
            OutlinedButton(text: "Button", leftIcon: .init(systemName: "trash"), size: .tiny)
        }.padding()
    }
}
