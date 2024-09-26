//
//  TwoButton.swift
//  IOS_CleanArchitecture_Sample
//
//  Created by 60156664 on 15/06/2022.
//

import SwiftUI

struct TwoButton: View {
    var text1: String
    var text2: String
	var leftIcon1: Image?
	var rightIcon1: Image?
	var leftIcon2: Image?
	var rightIcon2: Image?
    var orientation: TwoButtonConfig.TwoButtonOrientation
    var size: TwoButtonConfig.TwoButtonSize = .xlarge
    /*
     * ratio of button1 width/ button2 width:
     * ratio 1:1 : 1
     * ratio 1:2 : 0.5
     */
    var ratio: CGFloat = 0.5
    var actionButton1: () -> Void
    var actionButton2: () -> Void
	var isInvisible: Bool
    
    init(text1: String,
         text2: String,
		 leftIcon1: Image? = nil,
		 rightIcon1: Image? = nil,
		 leftIcon2: Image? = nil,
		 rightIcon2: Image? = nil,
         orientation: TwoButtonConfig.TwoButtonOrientation = .horizon,
         size: TwoButtonConfig.TwoButtonSize = .xlarge,
         ratio: CGFloat = 0.5,
		 isInvisible: Bool = false,
         actionButton1: @escaping () -> Void,
         actionButton2: @escaping () -> Void) {
        self.text1 = text1
        self.text2 = text2
		self.leftIcon1 = leftIcon1
		self.rightIcon1 = rightIcon1
		self.leftIcon2 = leftIcon2
		self.rightIcon2 = rightIcon2
        self.orientation = orientation
        self.size = size
        self.ratio = ratio
		self.isInvisible = isInvisible
        self.actionButton1 = actionButton1
        self.actionButton2 = actionButton2
    }
    
    var body: some View {
        if orientation == .horizon {
            Group {
                GeometryReader { geometry in
                    
                    HStack(spacing: 8) {
                        OneButton(text: text1,
								  leftIcon: leftIcon1,
								  rightIcon: rightIcon1,
                                  size: size.oneButtonSize,
								  backgroundType: isInvisible ? .outlinedInvisible : .outlined,
                                  action: actionButton1)
                        .frame(maxWidth: (geometry.size.width - 8) / (1 + 1 / ratio))
                        OneButton(text: text2,
								  leftIcon: leftIcon2,
								  rightIcon: rightIcon2,
                                  size: size.oneButtonSize,
                                  backgroundType: .filled,
                                  action: actionButton2)
                    }
                }
                .frame(height: size.height)
            }
        } else {
            VStack(spacing: 1) {
                OneButton(text: text1,
						  leftIcon: leftIcon1,
						  rightIcon: rightIcon1,
                          size: size.oneButtonSize,
                          backgroundType: .filled,
                          action: actionButton1)
                OneButton(text: text2,
						  leftIcon: leftIcon2,
						  rightIcon: rightIcon2,
                          size: size.oneButtonSize,
                          backgroundType: .ghost,
                          action: actionButton2)
            }
        }
    }
}

struct TwoButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TwoButton(text1: "Button 1",
                      text2: "Button 2",
                      orientation: .vertical,
                      size: .large,
                      ratio: 1,
                      actionButton1: {},
                      actionButton2: {})
            
            TwoButton(text1: "Button 1",
                      text2: "Button 2",
                      orientation: .horizon,
                      size: .large,
                      ratio: 1,
					  isInvisible: true,
                      actionButton1: {},
                      actionButton2: {})
            
            TwoButton(text1: "Button 1",
                      text2: "Button 2",
                      orientation: .horizon,
                      size: .large,
                      ratio: 1,
                      actionButton1: {},
                      actionButton2: {})
        }
        .background(Color.yellow)
    }
}
