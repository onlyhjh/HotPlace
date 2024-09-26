//
//  CheckBox.swift
//  gma_common
//
//  Created by 60117639 on 2022/10/17.
//

import SwiftUI

public struct CheckBox: View {
    @Binding var checked: Bool
    var iconOnly: Bool
    var size: CheckBoxSize
    var labelText: String
    var onChange: (_ newValue: Bool) -> Void = { _ in }
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    var enableColor = Color.gray700
    var disableColor = Color.gray400
    
    public enum CheckBoxSize: CGFloat {
        case small = 24
        case large = 28
        
        func getIconName(check: Bool, enable: Bool) -> String {
            switch(self) {
            case .small:
                if enable {
                    return check ? "icon_checkbox_selected_enable_24":"icon_checkbox_deselected_enable_24"
                } else {
                    return check ? "icon_checkbox_selected_disable_24":"icon_checkbox_deselected_disable_24"
                }
            case .large:
                if enable {
                    return check ? "icon_checkbox_selected_enable_28":"icon_checkbox_deselected_enable_28"
                } else {
                    return check ? "icon_checkbox_selected_disable_28":"icon_checkbox_deselected_disable_28"
                }
            }
        }
    }

    public init(iconOnly: Bool = false,
                size: CheckBoxSize = .large,
                checked: Binding<Bool>,
                labelText: String = "",
                enableColor: Color = Color.gray900,
                disableColor: Color = Color.gray400,
                onChange: @escaping (_ newValue: Bool) -> Void = { _ in }) {
        self.iconOnly = iconOnly
        self.size = size
        self.disableColor = disableColor
        self.enableColor = enableColor
        self._checked = checked
        self.labelText = labelText
        self.onChange = onChange
    }
    
    public var body: some View {
        HStack(spacing: iconOnly ? 0 : 8) {
            Button(action: {
                checked.toggle()
            }, label: {
                Image(size.getIconName(check: checked, enable: isEnabled))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
            })
            .basicStyle()
            .frame(width: size.rawValue, height: size.rawValue)
            .onChange(of: checked) { newValue in
                self.onChange(newValue)
            }
            
            if !iconOnly {
                Text(labelText)
                    .typography(size == .small ? .body3 :.heading6,
                                weight: size == .small ? .semibold : .medium,
                                color: isEnabled ? enableColor:disableColor)
                    .onTapGesture {
                        checked.toggle()
                    }
            }
        }
    }
}

struct CheckBox_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            VStack(spacing:20) {
                CheckBox(iconOnly: true, size: .small, checked: .constant(true), labelText: "Label")
                CheckBox(size: .small, checked: .constant(true), labelText: "Label")
                CheckBox(size: .small, checked: .constant(true), labelText: "Label")
                    .disabled(true)
                CheckBox(checked: .constant(true), labelText: "Label")
                CheckBox(checked: .constant(true), labelText: "Label", onChange: { newValue in
                })
                .disabled(true)
            }
            HStack(spacing:20) {
                CheckBox(size: .small, checked: .constant(false), labelText: "Label")
                CheckBox(size: .small, checked: .constant(false), labelText: "Label")
                    .disabled(true)
                CheckBox(checked: .constant(false), labelText: "Label")
                CheckBox(checked: .constant(false), labelText: "Label", onChange: { newValue in
                })    
                .disabled(true)
            }
        }
    }
}
