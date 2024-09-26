//
//  PinView.swift
//  gma_presentation
//
//  Created by 60156664 on 05/07/2022.
//

import SwiftUI

/**
Password input window
 - Author: Shinhan Bank
*/
public struct PinView: View {
    @Binding var pinText: String
    @Binding var isFocused: Bool
    var pinCount: Int
    var focusBackgroundColor: Color
    var backgroundColor: Color
	var foregroundColor: Color
    var pinRoundColor: Color
	var isFilter: Bool = true
    // 오류 발생했을때 item round 처리
    var isError: Bool = false

	/**
	Password input window
	 - Parameters:
	   - pinText: Text visible as you type.
	   - isFocused: Whether focus function.
	   - pinCount: Total number of texts entered.
    - focusBackgroundColor: Focused Item Background color.
	   - backgroundColor: Background Color.
	*/
    public init(pinText: Binding<String>,
                isFocused: Binding<Bool>,
                pinCount: Int,
                focusBackgroundColor: Color = .white,
                backgroundColor: Color = .white.opacity(0.15),
				foregroundColor: Color = .navy900,
                pinRoundColor: Color = .clear,
				isFilter: Bool = true,
                isError: Bool = false) {
        self._pinText = pinText
        self._isFocused = isFocused
        self.pinCount = pinCount
        self.focusBackgroundColor = focusBackgroundColor
        self.backgroundColor = backgroundColor
		self.foregroundColor = foregroundColor
        self.pinRoundColor = pinRoundColor
		self.isFilter = isFilter
        self.isError = isError
    }
    
    public var body: some View {
        ZStack {
            HStack {
                //Text("pinCount = \(pinCount)")
                ForEach(0..<pinCount, id: \.self) { index in
					if pinText.count > 0 && index < pinText.count {
						PinItemView(isFocused: isFocused, isFilled: true, isFilter: isFilter, text: //String(pinText[String.Index(encodedOffset: index)]), backgroundColor: backgroundColor, foregroundColor: foregroundColor, isError: isError)
                                    String(pinText[String.Index(utf16Offset: index, in: pinText)]), focusBackgroundColor:focusBackgroundColor,
                                    backgroundColor: backgroundColor, foregroundColor: foregroundColor, isError: isError)
					} else {
                        PinItemView(isFocused: isFocused, isFilled: false, isFilter: isFilter, text: "", focusBackgroundColor: focusBackgroundColor , backgroundColor: backgroundColor, pinRoundColor:pinRoundColor, isError: isError)
					}
                }
            }
        }
    }
}

public struct PinItemView: View {
    var isFocused: Bool
    var isFilled: Bool
	var isFilter: Bool
	var text: String
    var focusBackgroundColor: Color = .white
    var backgroundColor: Color = .white.opacity(0.15)
	var foregroundColor: Color = .navy900
    var pinRoundColor: Color = .clear
    // Error Round option
    var isError:Bool = false
    
    // MARK: - private
    private let width = 38.0
    private let height = 44.0
    private let errorRoundColor: Color = .semanticNegative

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                //.fill(isFocused ? Color.white : Color.white.opacity(0.15))
                .fill(isFocused ? focusBackgroundColor : backgroundColor)
                .frame(width: width, height: height)
            
            if isFilled {
				if isFilter {
					Circle()
						.fill(foregroundColor)
						.frame(width: 12, height: 12)
				} else {
					Text(text)
						.font(.system(size: 24))
						.foregroundColor(foregroundColor)
				}
            }
            // Error Round
            if isError {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(errorRoundColor)
                    .frame(width: width, height: height)
            }
            else {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(pinRoundColor)
                    .frame(width: width, height: height)
            }
            

        }
    }
}

struct PinView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PinView(pinText: .constant("**"), isFocused: .constant(true), pinCount: 6)
            PinView(pinText: .constant("**"), isFocused: .constant(true), pinCount: 6, isError: true)
            
			PinView(pinText: .constant("1234"), isFocused: .constant(true), pinCount: 6, backgroundColor: .blue, foregroundColor: Color(hex: "BEC1C6"), isFilter: false, isError: false)

            // Focused Color, unFocused Color. Focus true
            PinView(pinText: .constant("1234"), isFocused: .constant(true), pinCount: 6, focusBackgroundColor: .gray200, backgroundColor: .blue, foregroundColor: Color(hex: "BEC1C6"), isFilter: false, isError: true)
            // Focused Color, unFocused Color. Focus false
            PinView(pinText: .constant("1234"), isFocused: .constant(false), pinCount: 6, focusBackgroundColor: .gray200, backgroundColor: .blue, foregroundColor: Color(hex: "BEC1C6"), isFilter: false, isError: true)

        }
        .frame(width: 300, height: 500)
        .background(Color.yellow)
    }
}

struct PinViewItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PinItemView(isFocused: false, isFilled: true, isFilter: false, text: "1", isError: false)
            PinItemView(isFocused: false, isFilled: true, isFilter: false, text: "1", isError: true)
            
            PinItemView(isFocused: true, isFilled: true, isFilter: false, text: "9", isError: false)
            PinItemView(isFocused: true, isFilled: true, isFilter: false, text: "9", isError: true)
            
            PinView(pinText: .constant("**"), isFocused: .constant(true), pinCount: 6, isError: true)
            
            PinView(pinText: .constant("**"), isFocused: .constant(true), pinCount: 6, backgroundColor:.gray200, isError: true)


        }
        .frame(width: 300, height: 500)
        .background(Color.green)
    }
}



struct RoundColor_Previews: PreviewProvider {
    static var previews: some View {
        let pinColor = Color(hex: "D9D9D9")
        VStack {
            // D9D9D9 컬러
            PinItemView(isFocused: false, isFilled: true, isFilter: false, text: "1", pinRoundColor: pinColor, isError: false)
            
            PinItemView(isFocused: false, isFilled: true, isFilter: false, text: "1", isError: true)
            
            PinItemView(isFocused: true, isFilled: true, isFilter: false, text: "9", isError: false)
            PinItemView(isFocused: true, isFilled: true, isFilter: false, text: "9", isError: true)
            PinView(pinText: .constant("**"), isFocused: .constant(true), pinCount: 6, isError: true)

        }
        .frame(width: 300, height: 500)
        .background(Color.white)
    }
}
