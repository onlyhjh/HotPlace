//
//  BasicDropDown.swift
//  gma_common
//
//  Created by 60156664 on 29/03/2023.
//

import SwiftUI

public struct BasicDropDown: View {
    
    @Binding var selectionText: String
    @Binding var isSelected: Bool
    var label: String = ""
    var selectAction: () -> Void = {}
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.isReadOnly) private var isReadOnly: Bool
    @Environment(\.isError) private var isError: Bool

    public init(selectionText: Binding<String>,
                isSelected: Binding<Bool>,
                label: String = "",
                selectAction: @escaping () -> Void = {}) {
        self._selectionText = selectionText
        self._isSelected = isSelected
        self.label = label
        self.selectAction = selectAction
    }
    
    public var body: some View {
        HStack {
            VStack {
                Text(label)
                    .typography(16, weight: .semibold, color: Color.gray500)
                    .lineSpacing(6)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.top, (isSelected || !selectionText.isEmpty) ? 16 : 12)

                if !selectionText.isEmpty && isEnabled == true {
                    Spacer()
                        .frame(height: 2)
                    Text(selectionText)
                        .typography(16, weight: .medium, color: Color.gray900)
                        .lineSpacing(8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                }
            }
            .padding(.bottom, (isSelected && selectionText.isEmpty) ? 40 : (selectionText.isEmpty ? 16 : 14))

            Image(isSelected ? "icon_line_arrow_up_24_gray" : "icon_line_arrow_down_24_gray")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .padding(.trailing, 18)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke((isSelected && !isError && isEnabled && isReadOnly == false) ? Color.borderFocused : (isError && !isReadOnly && isEnabled) ? .borderError : .borderDefault, lineWidth: 1)
        )
        .background(RoundedRectangle(cornerRadius: 10).fill(isEnabled ? (isReadOnly ? .gray50 : .white) : Color.gray200))

        .onTapGesture {
            if isEnabled && isReadOnly == false {
                selectAction()
            }
        }
    }
}

struct BasicDropDown_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BasicDropDown(selectionText: .constant("Selection"), isSelected: .constant(false))
                .disabled(false)
                .readOnly(true)
            
            BasicDropDown(selectionText: .constant(""), isSelected: .constant(false))
                .disabled(false)
                .readOnly(true)
            
            BasicDropDown(selectionText: .constant(""), isSelected: .constant(true))
                .disabled(false)
                .readOnly(false)

        }
    }
}
