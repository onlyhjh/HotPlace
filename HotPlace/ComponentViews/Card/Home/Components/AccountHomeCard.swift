//
//  HomeCard.swift
//  gma_presentation
//
//  Created by 60156664 on 17/06/2022.
//
import SwiftUI
import UniformTypeIdentifiers

struct AccountHomeCard: View {
    var style: AccountHomeCardConfig.CardHomeAccountStyle = .primary
    @State var isOnBalance: Bool = true
    var bottomOpacity: CGFloat

    var numberOfCard = 3 // maximum = 3
    var cardAccountInfo: HomeCardAccountInfo = HomeCardAccountInfo.template
    var buttonTitle1: String = ""
    var buttonTitle2: String = ""

    var actionButton1: (() -> Void)?
    var actionButton2: (() -> Void)?
    var onCopyAccountNumber: (() -> Void)?
    var bottomTapAction: (() -> Void)?

    var noneButton: Bool = false
    
    // Init for primary style, two button
    init(style: AccountHomeCardConfig.CardHomeAccountStyle = .primary,
                isOnBalance: Bool = true,
                numberOfCard: Int = 3,
                bottomOpacity: CGFloat = 1,
                cardAccountInfo: HomeCardAccountInfo = HomeCardAccountInfo.template,
                buttonTitle1: String = "Button",
                buttonTitle2: String = "Button",
                actionButton1: (() -> Void)? = nil,
                actionButton2: (() -> Void)? = nil,
                onCopyAccountNumber: (() -> Void)? = nil,
                bottomTapAction: (() -> Void)? = nil) {

        self.style = style
        self.isOnBalance = isOnBalance
        self.cardAccountInfo = cardAccountInfo
        self.numberOfCard = numberOfCard
        self.bottomOpacity = bottomOpacity
        self.buttonTitle1 = buttonTitle1
        self.buttonTitle2 = buttonTitle2
        self.actionButton1 = actionButton1
        self.actionButton2 = actionButton2
        self.onCopyAccountNumber = onCopyAccountNumber
        self.bottomTapAction = bottomTapAction
    }
    
    // Init for primary style, two button
    init(style: AccountHomeCardConfig.CardHomeAccountStyle = .primary,
                isOnBalance: Bool = true,
                numberOfCard: Int = 3,
                bottomOpacity: CGFloat = 1,
                cardAccountInfo: HomeCardAccountInfo = HomeCardAccountInfo.template,
                onCopyAccountNumber: (() -> Void)? = nil,
                bottomTapAction: (() -> Void)? = nil) {
        self.style = style
        self.isOnBalance = isOnBalance
        self.cardAccountInfo = cardAccountInfo
        self.numberOfCard = numberOfCard
        self.bottomOpacity = bottomOpacity
        self.onCopyAccountNumber = onCopyAccountNumber
        self.bottomTapAction = bottomTapAction
    }
    
    // Init for secondary style, one button
    init(style: AccountHomeCardConfig.CardHomeAccountStyle = .secondary,
                isOnBalance: Bool = true,
                cardAccountInfo: HomeCardAccountInfo = HomeCardAccountInfo.template,
                buttonTitle: String = "Button",
                action: @escaping () -> Void ) {
        
        self.style = style
        self.isOnBalance = isOnBalance
        self.cardAccountInfo = cardAccountInfo
        self.numberOfCard = 1 // style secondary default number of card = 1
        self.buttonTitle1 = buttonTitle
        self.actionButton1 = action
        self.bottomOpacity = 1
    }

    var body: some View {
        ZStack {
            if style == .primary {
                HomeCardPrimaryBackgroundShape(numberOfCard: numberOfCard, bottomOpacity: bottomOpacity, bottomTapAction: {
                    if let bottomTapAction = bottomTapAction {
                        bottomTapAction()
                    }
                })
            } else {
                HomeCardSecondaryBackgroundShape(fillColor: cardAccountInfo.accountType.fillColor)
            }
            
            VStack(alignment: .leading) {
                HStack(alignment: .top, spacing: 12) {
                    // Top icon
                    ZStack(alignment: .center) {
                        Circle()
                            .fill(Color.gray900.opacity(0.4))
                            .frame(width: 36, height: 36, alignment: .center)
                        cardAccountInfo.icon
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20, alignment: .center)
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(cardAccountInfo.accountName)
                            .typography(.body2, weight: .medium, color: .white.opacity(0.4))
                        Button(action: {
                            UIPasteboard.general.setValue(cardAccountInfo.accountNumber,
                                                          forPasteboardType: UTType.plainText.identifier)
                            if let onCopyAccountNumber = onCopyAccountNumber {
                                onCopyAccountNumber()
                            }
                        }, label: {
                            Text(cardAccountInfo.accountNumber)
                                .underline()
                                .typography(.body2, weight: .medium, color: .white)
                        })
                        .basicStyle()
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Button(action: {
                            isOnBalance.toggle()
                        }, label: {
                            if isOnBalance {
                                Image("icon_eye_show")
                                    .foregroundColor(.white)
                            } else {
                                Image("icon_eye_hide")
                                    .foregroundColor(.white)
                            }
                        })
                        .frame(width: 20, height: 20)
                        .basicStyle()
                    }
                    
                }
                
                Spacer()
                
                if isOnBalance {
                    CardHomeAccountBalance(balance: cardAccountInfo.balance, unit: cardAccountInfo.unit)
                } else {
                    Text("Hide balance")
                        .typography(23, weight: .heavy, color: .gray900.opacity(0.2))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Spacer()

                HStack {
                    if let actionButton1 = actionButton1 {
                        Button(action: {
                            actionButton1()
                        }, label: {
                            Text(buttonTitle1)
                                .typography(.body2, weight: .medium, color: .white)
                                .frame(maxWidth: .infinity, maxHeight: 45)
                        })
                        .basicStyle()
                    }

                    if let actionButton2 = actionButton2 {
                        Rectangle()
                            .fill(Color.gray900.opacity(0.2))
                            .frame(width: 1, height: 12, alignment: .center)

                        Button(action: actionButton2, label: {
                            Text(buttonTitle2)
                                .typography(.body2, weight: .medium, color: .white)
                                .frame(maxWidth: .infinity, maxHeight: 45)
                        })
                        .basicStyle()
                    }
                }.frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.white.opacity(0.15))
                    .cornerRadius(8)
                
                Spacer()

            }
            .padding(.leading, 24)
            .padding(.trailing, 24)
            .padding(.top, 22)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct HomeCardPrimaryBackgroundShape: View {
    var numberOfCard: Int
    var bottomOpacity: CGFloat
    var bottomTapAction: (() -> Void)?
    
    var body: some View {
        ZStack {
            if numberOfCard >= 3 {
                HomeCardShape(gradientStart: Color(hex: "A2BAEB"), gradientEnd: Color(hex: "ADADF6")) .offset(y: 12).padding([.leading, .trailing], 16).opacity(bottomOpacity)
                    .onTapGesture {
                        if let bottomTapAction = bottomTapAction {
                            bottomTapAction()
                        }
                    }
                HomeCardShape(gradientStart: Color(hex: "759BE9"), gradientEnd: Color(hex: "8E8EEB"))
                    .offset(y: 6).padding([.leading, .trailing], 6).opacity(bottomOpacity)
                    .onTapGesture {
                        if let bottomTapAction = bottomTapAction {
                            bottomTapAction()
                        }
                    }
            } else if numberOfCard == 2 {
                HomeCardShape(gradientStart: Color(hex: "759BE9"), gradientEnd: Color(hex: "8E8EEB")).offset(y: 6).padding([.leading, .trailing], 6).opacity(bottomOpacity)
                    .onTapGesture {
                        if let bottomTapAction = bottomTapAction {
                            bottomTapAction()
                        }
                    }
            }

            HomeCardShape(gradientStart: Color.gradientStart, gradientEnd: Color.gradientEnd)
        }
    }
}

struct HomeCardSecondaryBackgroundShape: View {
    var fillColor: Color

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(fillColor)
                .frame(minHeight: 209)
        }
    }
        
}

struct HomeCardShape: View {
    
    var gradientStart: Color
    var gradientEnd: Color
    
    private var maxHeight: CGFloat = 209
    
    init(gradientStart: Color,
                gradientEnd: Color) {
        self.gradientStart = gradientStart
        self.gradientEnd = gradientEnd
    }

    var body: some View {
        
        RoundedRectangle(cornerRadius: 16)
            .fill(
                LinearGradient(gradient: Gradient(colors: [gradientStart, gradientEnd]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing))
            .frame(minHeight: maxHeight)
    }
    
}

struct CardHomeAccountBalance: View {
    var balance: String
    var unit: String
    
    var body: some View {
        HStack {
            Text(balance)
                .typography(24, weight: .heavy, color: .white)
            Text(unit)
                .typography(23, weight: .medium, color: .white)
        }.frame(maxWidth: .infinity, alignment: .center)

    }
    
}

// Template and preview
struct CardHomeAccount_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack {
                AccountHomeCard(actionButton1: {
                    
                }, actionButton2: {
                    
                }).padding()
                
                AccountHomeCard(style: .secondary,
                                isOnBalance: true,
                                cardAccountInfo: HomeCardAccountInfo.template,
                                buttonTitle: "Checking" ) {
                }.padding()
                
                AccountHomeCard(style: .secondary,
                                isOnBalance: true,
                                cardAccountInfo: HomeCardAccountInfo.templateSavings,
                                buttonTitle: "Savings" ) {
                }.padding()
                
                AccountHomeCard(style: .secondary,
                                isOnBalance: true,
                                cardAccountInfo: HomeCardAccountInfo.templateLoan,
                                buttonTitle: "Loan" ) {
                }.padding()
            }
        }
    }
}
