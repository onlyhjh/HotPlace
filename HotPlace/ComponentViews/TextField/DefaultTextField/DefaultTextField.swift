//
//  DefaultTextField.swift
//  gma_common
//
//  Created by 60080254 on 2022/10/17.
//

import SwiftUI


/**
Textfield for search.
 - Author: Shinhan Bank
*/
public struct DefaultTextField: View {
	
	@Binding var text: String
	@Binding var errorText: String
	@Binding var requestText: String
	@State var defaultFocused: Bool = false
	@Binding var bindingFocused: Bool
	var isBindingFocus: Bool
	@ObservedObject var timer = TextFieldTimer()
	
	private var isRemainingTimeView = false
	private var labelText: String
	private var placeholder: String = ""
	private var helperText: String = ""
	private var characterCounter: Int = 0
	private var memo: String = ""
	private var requestAction: (()->())? = nil
	private var isActiveRequest: Bool
    private var dateAction: (()->())? = nil
	private var beginEditing: ()->() = {}
	private var endEditing: ()->() = {}
	private var commitAction: ()->() = {}
	private var cancelAction: ()->() = {}
	private var strokeColor = Color.black
	
	/**
	 Textfield - Helper Text Style.
	 - Parameters:
	   - text: Text already written in the textfield.
	   - errorText: Text displayed when an error occurs.
	   - labelText: Describe what the text field is for.
	   - placeholder: Placeholder.
	   - helperText: Describes extra information in the text field.
	   - commitAction: Action when confirming.
	   - cancelAction: Action when cancelled.
	*/
	public init(text: Binding<String>,
				errorText: Binding<String>,
				labelText: String = "",
				placeholder: String = "",
				helperText: String = "",
				isFocused: Binding<Bool>? = nil,
				defaultFocused: Bool = false,
				beginEditing: @escaping ()->() = {},
				endEditing: @escaping ()->() = {},
				commitAction: @escaping ()->() = {},
				cancelAction: @escaping ()->() = {} ) {
		self._text = text
		self._errorText = errorText
		self._requestText = .constant("")
		self.isActiveRequest = true
		self.labelText = labelText
		self.placeholder = placeholder
		self.helperText = helperText
		self.beginEditing = beginEditing
		self.endEditing = endEditing
		self.commitAction = commitAction
		self.cancelAction = cancelAction
		if let isFocused = isFocused {
			self._bindingFocused = isFocused
			self.isBindingFocus = true
		} else {
			self._bindingFocused = .constant(false)
			self.defaultFocused = defaultFocused
			self.isBindingFocus = false
		}
	}
	
	/**
	 Textfield - Remaining time Style.
	 - Parameters:
	   - text: Text already written in the textfield.
	   - errorText: Text displayed when an error occurs.
	   - labelText: Describe what the text field is for.
	   - placeholder: Placeholder.
	   - helperText: Describes extra information in the text field.
	   - timer: TextFieldTimer object to calculate remaining time and show it.
	   - commitAction: Action when confirming.
	   - cancelAction: Action when cancelled.
	*/
	public init(text: Binding<String>,
				errorText: Binding<String>,
				labelText: String = "",
				placeholder: String = "",
				helperText: String = "",
				timer: TextFieldTimer,
				isFocused: Binding<Bool>? = nil,
				defaultFocused: Bool = false,
				beginEditing: @escaping ()->() = {},
				endEditing: @escaping ()->() = {},
				commitAction: @escaping ()->() = {},
				cancelAction: @escaping ()->() = {} ) {
		self._text = text
		self._errorText = errorText
		self._requestText = .constant("")
		self.isActiveRequest = true
		self.timer = timer
		self.isRemainingTimeView = true
		self.labelText = labelText
		self.placeholder = placeholder
		self.helperText = helperText
		self.beginEditing = beginEditing
		self.endEditing = endEditing
		self.commitAction = commitAction
		self.cancelAction = cancelAction
		if let isFocused = isFocused {
			self._bindingFocused = isFocused
			self.isBindingFocus = true
		} else {
			self._bindingFocused = .constant(false)
			self.defaultFocused = defaultFocused
			self.isBindingFocus = false
		}
	}
	
	/**
	 Textfield - Character Counter Style.
	 - Parameters:
	   - text: Text already written in the textfield.
	   - errorText: Text displayed when an error occurs.
	   - labelText: Describe what the text field is for.
	   - placeholder: Placeholder.
	   - characterCounter: Maximum Number of Inputs Available.
	   - commitAction: Action when confirming.
	   - cancelAction: Action when cancelled.
	*/
	public init(text: Binding<String>,
				errorText: Binding<String>,
				labelText: String = "",
				placeholder: String = "",
				characterCounter: Int,
				isFocused: Binding<Bool>? = nil,
				defaultFocused: Bool = false,
				beginEditing: @escaping ()->() = {},
				endEditing: @escaping ()->() = {},
				commitAction: @escaping ()->() = {},
				cancelAction: @escaping ()->() = {} ) {
		self._text = text
		self._errorText = errorText
		self._requestText = .constant("")
		self.isActiveRequest = true
		self.labelText = labelText
		self.placeholder = placeholder
		self.characterCounter = characterCounter
		self.beginEditing = beginEditing
		self.endEditing = endEditing
		self.commitAction = commitAction
		self.cancelAction = cancelAction
		if let isFocused = isFocused {
			self._bindingFocused = isFocused
			self.isBindingFocus = true
		} else {
			self._bindingFocused = .constant(false)
			self.defaultFocused = defaultFocused
			self.isBindingFocus = false
		}
	}
	
	/**
	 Textfield - Request Code Style.
	 - Parameters:
	   - text: Text already written in the textfield.
	   - errorText: Text displayed when an error occurs.
	   - labelText: Describe what the text field is for.
	   - placeholder: Placeholder.
	   - characterCounter: Maximum Number of Inputs Available.
	   - requestText: request button text
	   - requestAction: Action when click request button
	   - commitAction: Action when confirming.
	   - cancelAction: Action when cancelled.
	*/
	public init(text: Binding<String>,
				errorText: Binding<String>,
				labelText: String = "",
				placeholder: String = "",
				isFocused: Binding<Bool>? = nil,
				defaultFocused: Bool = false,
				requestText: Binding<String>,
				isActiveRequest: Bool = true,
				beginEditing: @escaping ()->() = {},
				endEditing: @escaping ()->() = {},
				requestAction: @escaping ()->(),
				commitAction: @escaping ()->() = {},
				cancelAction: @escaping ()->() = {} ) {
		self._text = text
		self._errorText = errorText
		self._requestText = requestText
		self.isActiveRequest = isActiveRequest
		self.labelText = labelText
		self.placeholder = placeholder
		self.requestAction = requestAction
		self.beginEditing = beginEditing
		self.endEditing = endEditing
		self.commitAction = commitAction
		self.cancelAction = cancelAction
		if let isFocused = isFocused {
			self._bindingFocused = isFocused
			self.isBindingFocus = true
		} else {
			self._bindingFocused = .constant(false)
			self.defaultFocused = defaultFocused
			self.isBindingFocus = false
		}
	}
	
    /**
     Textfield - Request Code Style.
     - Parameters:
       - text: Text already written in the textfield.
       - errorText: Text displayed when an error occurs.
       - labelText: Describe what the text field is for.
       - placeholder: Placeholder.
       - characterCounter: Maximum Number of Inputs Available.
       - dateAction: Action when click request button
       - commitAction: Action when confirming.
       - cancelAction: Action when cancelled.
    */
    public init(text: Binding<String>,
                errorText: Binding<String>,
                labelText: String = "",
                placeholder: String = "",
				isFocused: Binding<Bool>? = nil,
				defaultFocused: Bool = false,
				beginEditing: @escaping ()->() = {},
				endEditing: @escaping ()->() = {},
                dateAction: @escaping ()->(),
                commitAction: @escaping ()->() = {},
                cancelAction: @escaping ()->() = {}) {
        self._text = text
        self._errorText = errorText
        self.labelText = labelText
        self.placeholder = placeholder
        self.dateAction = dateAction
		self.beginEditing = beginEditing
		self.endEditing = endEditing
        self.commitAction = commitAction
        self.cancelAction = cancelAction
        self._requestText = .constant("")
		self.isActiveRequest = true
		if let isFocused = isFocused {
			self._bindingFocused = isFocused
			self.isBindingFocus = true
		} else {
			self._bindingFocused = .constant(false)
			self.defaultFocused = defaultFocused
			self.isBindingFocus = false
		}
    }
    
	// TODO: Memo, Select 형식 init및 View 만들기
	@Environment(\.isEnabled) private var isEnabled: Bool
	@Environment(\.isReadOnly) private var isReadOnly: Bool
	@Environment(\.isError) private var isError: Bool
	@Environment(\.maxLength) private var maxLength: Int
    @Environment(\.inActive) private var inActive: Bool

	public var body: some View {
		let isFocused = Binding<Bool>(
			get: {
				if isBindingFocus {
					return bindingFocused
				} else {
					return defaultFocused
				}
			},
			set: {
				if isBindingFocus {
					bindingFocused = $0
				} else {
					defaultFocused = $0
				}
			}
		)
		VStack(spacing: 0) {
			HStack(spacing: 0) {
				BaseTextField(text: $text, labelText: labelText, placeholder: placeholder, isFocused: isBindingFocus ? $bindingFocused : $defaultFocused,
							  onBeginEditing: {
					isFocused.wrappedValue = true
					beginEditing()
				}, onEndEditing: {
					// textField가 focus잡힌 상태에서 disable 되면 뷰 변경과 DidEndEditing이 동시에 일어나면서 isFocused값 변화가 뷰에 반영되지 않는 문제 해결
					DispatchQueue.main.async {
						isFocused.wrappedValue = false
					}
					endEditing()
				}, onReturn: {
					hideKeyboard()
					isFocused.wrappedValue = false
					commitAction()
				})
				.maxLength(characterCounter > 0 ? characterCounter : maxLength)
				.onTapGesture {
					if isEnabled && !isReadOnly {
						dateAction?()
					}
				}
				
				
				if requestAction != nil{
					OutlinedButton(text: requestText != "" ? requestText : "Request", action: requestAction!)
						.disabled(!isEnabled || !isActiveRequest)
						.padding(.trailing, 18)
                } else if dateAction != nil {
					Button(action: (isEnabled && !isReadOnly) ? dateAction! : {}, label: {
                        Image("icon_line_calendar_24_gray")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                    })
                    .basicStyle()
                    .padding(.trailing, 18)
				} else if isRemainingTimeView {
					if isEnabled && !isReadOnly {
						Text(timer.remainingTimeString)
							.typography(.caption1, weight: .semibold, color: .gray500)
							.padding(.trailing, 28)
					}
				}
				else {
					if isEnabled && !isReadOnly {
						if (isFocused.wrappedValue && !text.isEmpty) || isError {
							Button(action: {
								text = ""
								cancelAction()
							}){
								Image("icon_fill_delete_24_gray")
							}
							.frame(width: 20, height: 20, alignment: .center)
							.padding(.trailing, 28)
                            .basicStyle()
						}
					}
				}
			}
			.overlay(
				RoundedRectangle(cornerRadius: 10)
					.stroke((isError && isEnabled) ? Color.borderError : (!isEnabled || isReadOnly) ? Color.borderDefault : isFocused.wrappedValue ? Color.borderFocused : .borderDefault, lineWidth: 1)
			)
			.background(RoundedRectangle(cornerRadius: 10).fill(isEnabled ? (isReadOnly ? .gray50 : .white) : Color.gray200))
			
			HStack(spacing: 0) {
				if isError && isEnabled {
					if !errorText.isEmpty {
						Text(errorText)
							.typography(.caption3, weight: .semibold, color: .borderError)
							.frame(height: 16)
							.padding(.top, 6)
					}
				} else if !isReadOnly && isEnabled {
					if !helperText.isEmpty {
						Text(helperText)
							.typography(.caption3, weight: .semibold, color: .gray500)
							.frame(height: 16)
							.padding(.top, 6)
					}
				}
				
				Spacer()
				
				if !isError && characterCounter > 0 {
					Text("\(String(text.count))/\(String(characterCounter))bytes")
						.typography(.caption3, weight: .semibold, color: .gray500)
						.frame(height: 16)
						.padding(.top, 6)
				}
			}
			.padding(.horizontal, 20)
		}
		.onTapGesture {} // onTapGesture를 통해 키보드를 내려가게 설정한 경우, TextField를 선택했을 때에도 키보드가 내려가는 현상 방지
	}
}

struct DefaultTextField_Previews: PreviewProvider {
	static var previews: some View {
		VStack(spacing: 30) {
			DefaultTextField(text: .constant(""), errorText: .constant("ErrorText"), labelText: "Default", placeholder: "설명")
			DefaultTextField(text: .constant("Sample text"), errorText: .constant("ErrorText"), labelText: "Helper Text", placeholder: "설명", helperText: "It's HelperText")
			DefaultTextField(text: .constant("137343"), errorText: .constant("You’ve entered the wrong code. (1/5)"), labelText: "Remaining time", placeholder: "설명", helperText: "HelperText", timer: TextFieldTimer(180))
				.error(true)
				.keyboardType(keyboardType: .numberPad)
			DefaultTextField(text: .constant("very loooooooong text"), errorText: .constant("ErrorText"), labelText: "Character Counter", placeholder: "설명", characterCounter: 35)
				.readOnly(true)
			DefaultTextField(text: .constant("Disabled TextField"), errorText: .constant("ErrorText"), labelText: "Character Counter", placeholder: "설명", characterCounter: 30)
				.disabled(true)
			DefaultTextField(text: .constant(""), errorText: .constant("ErrorText"), labelText: "Character Counter", placeholder: "설명", requestText: .constant("Custom"), requestAction: {})
				.error(true)
            
            DefaultTextField(text: .constant("text"),
                             errorText: .constant(""),
                             labelText: "label",
                             placeholder: "place holder",
                             dateAction: {
                
            })

		}.padding(30)
	}
}
