//
//  SearchTextField.swift
//  gma_presentation
//
//  Created by 60156664 on 22/06/2022.
//

import SwiftUI


/**
Textfield for search.
 - Author: Shinhan Bank
*/
public struct SearchTextField: View {
    public enum SearchTextFieldSize {
        case small
        case medium
        case large
        
        var height: CGFloat {
            switch self {
            case .small: return 40
            case .medium: return 48
            case .large: return 56
            }
        }
    }
    
    @Binding var text: String
    @Binding private var isEditing: Bool

    var size: SearchTextFieldSize = .large
    var placeholder: String = "Search here"
    var cancelText: String = "cancel"
    var commitAction: ()->() = {}
    var cancelAction: ()->() = {}

	/**
	Textfield for search.
	 - Parameters:
	   - text: Text already written in the textfield.
	   - size: SearchTextfield size. (small, large)
	   - backgroundOn: Textfield background or not.
	   - placeholder: Placeholder.
	*/
    public init(text: Binding<String>,
                isFocused: Binding<Bool>,
                size: SearchTextFieldSize = .large,
                placeholder: String = "Search here",
                cancelText: String = "Cancel") {
        self._text = text
        self.size = size
        self.placeholder = placeholder
        self.cancelText = cancelText
        self._isEditing = isFocused
    }
    
	/**
	Textfield for search.
	 - Parameters:
	   - text: Text already written in the textfield.
	   - size: SearchTextfield size. (small, large)
	   - backgroundOn: Textfield background or not.
	   - placeholder: Placeholder.
	   - commitAction: Action when confirming.
	*/
    public init(text: Binding<String>,
                isFocused: Binding<Bool>,
                size: SearchTextFieldSize = .large,
                placeholder: String = "Search here",
                cancelText: String = "Cancel",
                commitAction: @escaping ()->() = {}) {
        self._text = text
        self.size = size
        self.placeholder = placeholder
        self.cancelText = cancelText
        self.commitAction = commitAction
        self._isEditing = isFocused
    }
    
	/**
	Textfield for search.
	 - Parameters:
	   - text: Text already written in the textfield.
	   - size: SearchTextfield size. (small, large)
	   - placeholder: Placeholder.
	   - commitAction: Action when confirming.
	   - cancelAction: Action when cancelled.
	*/
    public init(text: Binding<String>,
                isFocused: Binding<Bool>,
                size: SearchTextFieldSize = .large,
                placeholder: String = "Search here",
                cancelText: String = "Cancel",
                commitAction: @escaping ()->() = {},
                cancelAction: @escaping ()->() = {} ) {
        self._text = text
        self._isEditing = isFocused
        self.size = size
        self.placeholder = placeholder
        self.cancelText = cancelText
        self.commitAction = commitAction
        self.cancelAction = cancelAction
    }
    
    public var body: some View {
        HStack {
            TextField("", text:  $text, onEditingChanged: { (editingChanged) in
                isEditing = editingChanged
            })
            .placeholder(isShow: text.isEmpty, placeholder: {
                Text(placeholder)
                    .typography(.body2, weight: .semibold, color: .gray400)
            })
            .frame(height: size.height)
            .padding(.leading, 46)
            .padding(.trailing, 36)
            .background(Color.gray200)
            .cornerRadius(8)
            .overlay(
                HStack {
                    Image("icon_line_search_24_gray900")
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                    if isEditing && !text.isEmpty {
                        Button(action: {
                            text = "          " // put dummy text instead of japanese
                            if !isEditing {
                                self.isEditing = true
                            }
                            // clear 0.5sec later
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                text = ""
                            }
                        }, label: {
                            Image("icon_fill_delete_24_gray")
                                .frame(width: 20, height: 20)
                                .padding(.trailing, 14)
                        })
                        .basicStyle()
                    }
                }
            )
            
            if isEditing || (isEditing == false && !text.isEmpty) {
                Button(action: {
                    text = "          " // put dummy text instead of japanese
                    isEditing = false
                    DispatchQueue.main.async {
                        hideKeyboard()
                        cancelAction()
                    }
                    // clear 0.5sec later
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        text = ""
                    }
                }) {
                    Text(cancelText)
                        .typography(.body2, weight: .semibold, color: .gray600)
                }
                .basicStyle()
            }
        }
    }
}

struct SearchTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SearchTextField(text: .constant(""), isFocused: .constant(true), size: .small)
            SearchTextField(text: .constant(""), isFocused: .constant(true), size: .large)
        }
        .frame(maxHeight: .infinity)
        .background(Color.subPageBG)
    }
}
