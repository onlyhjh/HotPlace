//
//  LoginHomeCard.swift
//  gma_presentation
//
//  Created by 60156664 on 16/06/2022.
//

import SwiftUI

struct LoginHomeCard: View {
    
    var title: String = ""
    var subTitle: String = ""
    var buttonTitle: String = "Login"
    var action: () -> Void = {}
    
    private let maxHeight: CGFloat = 207
    
    init(title: String = "Login to SOL" ,
                subTitle: String = "Get started login\nand enjoy various service!",
                action: @escaping () -> Void = {}) {
        self.title = title
        self.subTitle = subTitle
        self.action = action
    }
    
    init(title: String = "Login to SOL" ,
                subTitle: String = "Get started login\nand\n enjoy various service! ",
                buttonTitle: String = "Login",
                action: @escaping () -> Void = {}) {
        self.title = title
        self.subTitle = subTitle
        self.buttonTitle = buttonTitle
        self.action = action
    }

    var body: some View {
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
                        .typography(.heading3, weight: .heavy, color: .white)
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
                    })
                        .frame(minHeight: 45)
                        .padding(.horizontal, 15)
                        .background(Color.white.opacity(0.15))
                        .cornerRadius(8)
                        .basicStyle()
                }.padding(.bottom, 28)
                    
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding([.leading, .top], 24)
            
            Image("image_login_card")
                .frame(maxWidth: .infinity,
                       maxHeight: maxHeight,
                       alignment: .bottomTrailing)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct CardHomeLogin_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LoginHomeCard(action: {
            }).padding()
            LoginHomeCard(subTitle: "Get started login", action: {
            }).padding()
        }
    }
}
