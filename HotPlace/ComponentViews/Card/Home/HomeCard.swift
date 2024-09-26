//
//  HomeCard.swift
//  gma_common
//
//  Created by 60156664 on 22/09/2022.
//

import SwiftUI

public protocol HomeCardConfig {
}

/// Login Home Card Configuration
public struct LoginHomeCardConfig: HomeCardConfig {
    var title: String = ""
    var subTitle: String = ""
    var buttonTitle: String = "Login"
    var action: () -> Void = {}
    
    public init(title: String = "Login to SOL" ,
                subTitle: String = "Get started login\nand\n enjoy various service! ",
                buttonTitle: String = "Login",
                action: @escaping () -> Void = {}) {
        self.title = title
        self.subTitle = subTitle
        self.buttonTitle = buttonTitle
        self.action = action
    }

    static let `default` = LoginHomeCardConfig()
}

// CardHomeAccountInfo
public struct HomeCardAccountInfo {
    public enum CardHomeAccountType {
        case checking
        case savings
        case loan
        
        var fillColor: Color {
            switch self {
            case .checking: return .accountEmerald
            case .savings: return .accountMint
            case .loan: return .accountPurple
            }
        }
    }

    var accountName: String = ""
    var accountNumber: String = ""
    var icon: Image
    var balance: String = ""
    var unit: String = ""
    var accountType: CardHomeAccountType = .savings
    
    public init(accountName: String = "Account name",
                accountNumber: String = "123-456-000111",
                icon: Image? = nil,
                balance: String = "1,000,000,000",
                unit: String = "VND",
                accountType: CardHomeAccountType = .savings) {
        self.accountName = accountName
        self.accountNumber = accountNumber
        self.icon = icon ?? Image("icon_home_card")
        self.balance = balance
        self.unit = unit
        self.accountType = accountType
    }
    
    // For template
    // Account type = checking
    public static let template = HomeCardAccountInfo(accountType: .checking)
    // Account type = savings
    public static let templateSavings = HomeCardAccountInfo(icon: Image("icon_home_card_saving"), accountType: .savings)
    // Account type = loan
    public static let templateLoan = HomeCardAccountInfo(icon: Image("icon_home_card_loan"), accountType: .loan)
}

/// Account Home Card Configuration
public struct AccountHomeCardConfig: HomeCardConfig {
    public enum CardHomeAccountStyle {
        case primary
        case secondary
    }
    
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

    public init(style: AccountHomeCardConfig.CardHomeAccountStyle = .primary,
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
}

/// More Home Card Configuration
public struct MoreHomeCardConfig: HomeCardConfig {
    var icon: Image = Image("icon_hom_card_more")
    var text: String = "All accounts"
    var backgroundColor: Color = .navy100

    static let `default` = MoreHomeCardConfig()
}

/**
 Home card with account type  init function
 - Author: Shinhan Bank
*/
public struct HomeCard: View {
    var config: HomeCardConfig
    public init(config: AccountHomeCardConfig) {
        self.config = config
    }
    
    /// Home card with login type  init function
    /// - Parameters:
    ///   - config: Configuration with LoginHomeCardConfig
    ///     - title:  Title of card
    ///     - subTitle:  Sub title of card
    ///     - buttonTitle:  Title of button
    ///     - action:  Handle action of button
    public init(config: LoginHomeCardConfig) {
        self.config = config
    }
    
    /// Home card with more type  init function
    /// - Parameters:
    ///   - config: Configuration with LoginHomeCardConfig
    ///     - icon:  Left icon of card
    ///     - text:  Title of card
    ///     - backgroundColor:  Background color of card
    public init(config: MoreHomeCardConfig) {
        self.config = config
    }
    
    public var body: some View {
        if config is LoginHomeCardConfig {
            if let config = config as? LoginHomeCardConfig {
                LoginHomeCard(title: config.title, subTitle: config.subTitle, buttonTitle: config.buttonTitle, action: config.action)
            } else {
                // default
                LoginHomeCard()
            }
        
        } else if config is AccountHomeCardConfig {
            if let config = config as? AccountHomeCardConfig {
                AccountHomeCard(style: config.style, isOnBalance: config.isOnBalance, numberOfCard: config.numberOfCard, bottomOpacity: config.bottomOpacity, cardAccountInfo: config.cardAccountInfo, buttonTitle1: config.buttonTitle1, buttonTitle2: config.buttonTitle2, actionButton1: config.actionButton1, actionButton2: config.actionButton2, onCopyAccountNumber: config.onCopyAccountNumber, bottomTapAction: config.bottomTapAction)

            } else {
                // default
                AccountHomeCard()
            }
        } else {
         // is MoreHomeCardConfig
            
            if let config = config as? MoreHomeCardConfig {
                MoreHomeCard(icon: config.icon, text: config.text, backgroundColor: config.backgroundColor)
            } else {
                // default
                MoreHomeCard()
            }

        }
    }
}

struct HomeCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HomeCard(config: AccountHomeCardConfig())
                .padding()
            HomeCard(config: LoginHomeCardConfig())
                .padding()
            HomeCard(config: MoreHomeCardConfig(icon: .init(systemName: "trash"), text: "show more", backgroundColor: .gray300))
                .padding()
        }
    }
}
