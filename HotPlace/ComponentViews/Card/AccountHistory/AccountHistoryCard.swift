//
//  AccountHistoryCard.swift
//  gma_common
//
//  Created by 60156664 on 28/09/2022.
//

import SwiftUI

public protocol AccountHistoryCardConfig {
}

public struct PendingAccountHistoryCardConfig: AccountHistoryCardConfig {
    var text: String
    var count: String
}

/**
 AccountHistoryCard
 - Author: Shinhan Bank
*/
public struct AccountHistoryCard: View {
    var config: AccountHistoryCardConfig
    
    public init(config: PendingAccountHistoryCardConfig) {
        self.config = config
    }
    
    public var body: some View {
        if config is PendingAccountHistoryCardConfig {
            if let config = config as? PendingAccountHistoryCardConfig {
                HStack {
                    Text(config.text)
                        .typography(.body2, weight: .medium)
                        .foregroundColor(Color(hex: "128ED4", alpha: 0.1))
                        .frame(minHeight: 20)
                    Spacer()
                    Text(config.count)
                        .typography(.body2, weight: .medium)
                        .foregroundColor(Color(hex: "128ED4", alpha: 0.1))
                        .frame(minHeight: 20)
                }
                .padding(.vertical, 10)
                .padding(.leading, 24)
                .padding(.trailing, 24)
                .background(Color.yellow)
                .cornerRadius(10)
            } else {
                EmptyView()
            }
        
        } else {
            // MARK: Update when create AccountHistoryCard
            EmptyView()
        }
    }
}

struct AccountHistoryCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                AccountHistoryCard(config: PendingAccountHistoryCardConfig(text: "pending", count: "2"))
                    .padding()
                
                AccountHistoryCard(config: PendingAccountHistoryCardConfig(text: "Longe text pending Longe text pending Longe text pending Longe text pending", count: "999"))
                    .padding()
            }
        }
    }
}
