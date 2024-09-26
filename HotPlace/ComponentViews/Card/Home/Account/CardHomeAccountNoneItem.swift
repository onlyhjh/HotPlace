//
//  CardHomeAccountNoneItem.swift
//  gma_presentation
//
//  Created by 60156664 on 14/07/2022.
//

import SwiftUI

public struct CardHomeAccountNoneItem: View {
    
    var title: String = ""
    var subTitle: String = ""
    var buttonTitle: String = "Browse products"
    var action: () -> Void
    
    private let maxHeight: CGFloat = 207
    
    public init(title: String = "Welcome to SOL" ,
                subTitle: String = "You don't own any accounts",
                action: @escaping () -> Void) {
        self.title = title
        self.subTitle = subTitle
        self.action = action
    }
    
    public init(title: String = "Login to SOL" ,
                subTitle: String = "You don't own any accounts",
                buttonTitle: String = "Browse products",
                action: @escaping () -> Void) {
        self.title = title
        self.subTitle = subTitle
        self.buttonTitle = buttonTitle
        self.action = action
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color.gradientStart, Color.gradientEnd]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing))
                .frame(minHeight: maxHeight)
            
            VStack(alignment: .leading, spacing: 25 ) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .typography(.heading3, weight: .bold, color: .white)
                        .padding(.vertical, 8)
                    Text(subTitle)
                        .typography(.body2, weight: .medium, color: .white.opacity(0.9))
                        .lineSpacing(4)
                        .padding(.trailing, 100)
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
                VStack {
                    Button(action: action, label: {
                        Text(buttonTitle)
                            .typography(.body2, weight: .medium, color: .white)
                            .padding(.horizontal, 10)

                    })
                        .frame(minWidth: 72, minHeight: 45)
                        .background(Color.white.opacity(0.15))
                        .cornerRadius(8)
                }
                .padding(.bottom, 28)
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding([.leading, .top], 24)
            
            Image("image_card_01_154")
                .frame(maxWidth: .infinity,
                       maxHeight: maxHeight,
                       alignment: .bottomTrailing)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct CardHomeAccountNoneItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CardHomeAccountNoneItem(action: {
            }).padding()
            CardHomeAccountNoneItem(subTitle: "Get started login", action: {
            }).padding()
        }
    }
}
