//
//  CustomTextField.swift
//  gma_presentation
//
//  Created by 60156664 on 23/06/2022.
//

import SwiftUI

class CustomTextFieldCoordinator: NSObject, UITextFieldDelegate {
    @Binding private var text: String

    private let onBeginEditing: () -> Void
    private let onEndEditing: () -> Void
    private let onReturn: () -> Void
    
    init(text: Binding<String>,
         onBeginEditing: @escaping (() -> Void),
         onEndEditing: @escaping (() -> Void),
         onReturn: @escaping (() -> Void)) {
        _text = text
        self.onBeginEditing = onBeginEditing
        self.onEndEditing = onEndEditing
        self.onReturn = onReturn
        super.init()
    }
    
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        DispatchQueue.main.async { [weak self] in
            self?.text = textField.text ?? ""
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        onBeginEditing()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
		self.onEndEditing()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        returnTapped()
        return true
    }
    
    @objc
    func returnTapped() {
        onReturn()
    }
}

struct CustomTextField: UIViewRepresentable {
    @Binding var text: String
    @Binding var isFocused: Bool
	@Environment(\.isReadOnly) private var isReadOnly: Bool
	@Environment(\.keyboardType) private var keyboardType: UIKeyboardType
    @Environment(\.inActive) private var inActive: Bool

    private var foregroundColor: Color
    private let onBeginEditing: () -> Void
    private let onEndEditing: () -> Void
    private var onReturn: () -> Void

    init(text: Binding<String>,
         isFocused: Binding<Bool>,
         foregroundColor: Color,
         onBeginEditing: @escaping (() -> Void) = {},
         onEndEditing: @escaping (() -> Void) = {},
         onReturn: @escaping (() -> Void) = {}) {
        _text = text
        _isFocused = isFocused
        self.foregroundColor = foregroundColor
        self.onBeginEditing = onBeginEditing
        self.onEndEditing = onEndEditing
        self.onReturn = onReturn
    }
    
    func makeCoordinator() -> CustomTextFieldCoordinator {
        CustomTextFieldCoordinator(text: $text,
                                   onBeginEditing: onBeginEditing,
                                   onEndEditing: onEndEditing,
                                   onReturn: onReturn)
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.textColor = UIColor(foregroundColor)
        setProperties(textField: textField)
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textFieldDidChange(_:)), for: .editingChanged)
		textField.keyboardType = keyboardType
        
        return textField
    }
    
    func updateUIView(_ textField: UITextField, context: Context) {
        textField.delegate = context.coordinator
        textField.text = text
        textField.font = .systemFont(ofSize: 16, weight: .semibold)
        setProperties(textField: textField)
		if textField.keyboardType != keyboardType { // Show changed keyboard if keyboard type has changed
			textField.keyboardType = keyboardType
			if textField.isFirstResponder == true {
				hideKeyboard()
			}
		}
		if !textField.isEnabled && !isReadOnly {
			textField.textColor = UIColor(.gray400)
		} else {
			textField.textColor = UIColor(foregroundColor)
		}
		if isReadOnly == true {
			textField.isEnabled = false
		}
        
        if inActive == true {
            textField.isEnabled = false
        }
		
        if isFocused, textField.isFirstResponder == false {
            DispatchQueue.main.async {
                textField.becomeFirstResponder()
            }
        }
        
        if isFocused == false {
            if textField.isFirstResponder == true {
                hideKeyboard()
            }
        }
    }
    
    func setProperties(textField: UITextField) {
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
}
