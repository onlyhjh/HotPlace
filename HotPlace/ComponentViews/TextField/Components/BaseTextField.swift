//
//  BaseTextField.swift
//  gma_common
//
//  Created by 60080254 on 2022/10/20.
//

import SwiftUI
import Combine

/**
Base Textfield.
 - Author: Shinhan Bank
*/

public struct BaseTextField: View {
	
	@Binding var text: String
	@Binding var isFocused: Bool
	
	var labelText: String
	var placeholder: String = ""
	private let onBeginEditing: () -> Void
	private let onEndEditing: () -> Void
	private let onReturn: () -> Void
	

	/**
	Textfield - Default Style.
	 - Parameters:
	   - text: Text already written in the textfield.
	   - labelText: Describe what the text field is for.
	   - placeholder: Placeholder.
	*/
	public init(text: Binding<String>,
				labelText: String = "",
				placeholder: String = "",
				isFocused: Binding<Bool> = .constant(false),
				onBeginEditing: @escaping (() -> Void) = {},
				onEndEditing: @escaping (() -> Void) = {},
				onReturn: @escaping (() -> Void) = {}) {
		self._text = text
		self.labelText = labelText
		self.placeholder = placeholder
		self._isFocused = isFocused
		self.onBeginEditing = onBeginEditing
		self.onEndEditing = onEndEditing
		self.onReturn = onReturn
	}
	
	func textLimitMaxLength(_ maxLength: Int) {
		if maxLength > 0, text.count > maxLength {
			text = String(text.prefix(maxLength))
		}
	}
	
	
	@Environment(\.isEnabled) private var isEnabled: Bool
	@Environment(\.isReadOnly) private var isReadOnly: Bool
	@Environment(\.maxLength) private var maxLength: Int
    @Environment(\.inActive) private var inActive: Bool

	public var body: some View {
		VStack(spacing: 0) {
			HStack(spacing: 0) {
				VStack(alignment: .leading, spacing: 0){
					if (isFocused || !text.isEmpty) { // TextField 활성화 시 Label값 위로 옮겨짐
						Text(labelText)
							.frame(height: 18)
							.padding(.top, 12)
							.typography(.caption3, weight: .semibold, color: .gray500)
					}
					
					CustomTextField(text: $text,
									isFocused: $isFocused,
                                    foregroundColor: isEnabled ? .gray900 : (isReadOnly ? .gray900 : .gray500),
									onBeginEditing: onBeginEditing,
									onEndEditing: onEndEditing,
									onReturn: onReturn)
						.placeholder(isShow: text.isEmpty, placeholder: {
							Text((isFocused || !text.isEmpty) ? placeholder : labelText)
								.typography(.body2, weight: .semibold, color: isFocused ? .gray400 : .gray500)
						})
						.onReceive(Just(text), perform: { _ in
							textLimitMaxLength(maxLength)
						})
                        .disabled(isReadOnly)
				}
				.padding(.top,    (isFocused || !text.isEmpty) ? 2  : 16)
				.padding(.bottom, (isFocused || !text.isEmpty) ? 14 : 16)
				.padding(.leading, 20)
			}
		}
	}
}

struct BaseTextField_Previews: PreviewProvider {
	static var previews: some View {
		VStack(spacing: 30) {
			BaseTextField(text: .constant(""), labelText: "Default", placeholder: "설명")
			BaseTextField(text: .constant("SampleText"), labelText: "Default", placeholder: "설명")
			BaseTextField(text: .constant("Disabled Text"), labelText: "Default", placeholder: "설명")
				.readOnly(true)
				.background(Color.gray200) // disabled시 background Color는 해당 컴포넌트를 사용하는 View에서 지정해줘야 합니다. (Text Color는 자동으로 gray400으로 변경)
		}.padding(30)
	}
}
