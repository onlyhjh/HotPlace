//
//  TransactionHistoryList.swift
//  gma_common
//
//  Created by 60156664 on 29/09/2022.
//

import SwiftUI

public protocol TransactionHistoryListConfig {
}

public struct PendingTransactionHistoryListConfig: TransactionHistoryListConfig {
    var memoOn: Bool = true
    var cancelButtonOn: Bool = true
    var title: String
    var status: String
    var memo: String
    var time: String
    var transactionAmount: String
    var remainingAmount: String
    var unit: String
    var cancelAction: () -> Void = {}
    
    
    /// Init function
    public init(memoOn: Bool = true, cancelButtonOn: Bool = true, title: String, status: String,  memo: String, time: String, balance: String, subBalance: String, unit: String, cancelAction: @escaping () -> Void = {}) {
        self.memoOn = memoOn
        self.cancelButtonOn = cancelButtonOn
        self.title = title
        self.status = status
        self.memo = memo
        self.time = time
        self.transactionAmount = balance
        self.remainingAmount = subBalance
        self.unit = unit
        self.cancelAction = cancelAction
    }
    
    static let `default` = PendingTransactionHistoryListConfig(memoOn: true, cancelButtonOn: true, title: "Shinhan Card withdraw", status: "Processing", memo: "Vehicle maintenance costs", time: "13:25", balance: "-891,623,000", subBalance: "1,234,567,891", unit: "VND")
}

/**
 TransactionHistoryList
 - Author: Shinhan Bank
*/

public struct TransactionHistoryList: View {
    var config: TransactionHistoryListConfig
    
    /// Init function with Pending transaction history config
    /// - config: PendingTransactionHistoryListConfig
    ///      - memoOn: Memo display or not
    ///      - cancelButtonOn: Cancel button display or not
    ///      - title: Title of transaction history
    ///      - status: Status of transaction
    ///      - memo: Memo of transaction
    ///      - time: Time of transaction
    ///      - transactionAmount: Transaction Amount
    ///      - remainingAmount: Remaining amount
    ///      - unit: Unit
    ///      - cancelAction: Cancel action handle     public init(config: PendingTransactionHistoryListConfig) {
    public init(config: PendingTransactionHistoryListConfig) {
        self.config = config
    }
    
    public var body: some View {
        if config is PendingTransactionHistoryListConfig {
            if let config = config as? PendingTransactionHistoryListConfig {
                VStack(alignment: .leading, spacing: 0) {
                    Text(config.title)
                        .typography(.body3, weight: .semibold)
                        .foregroundColor(.gray900)
                        .frame(minHeight: 20)
                    HStack {
                        Text(config.status)
                            .typography(.body3, weight: .medium)
                            .foregroundColor(.semanticInformative)
                            .frame(minHeight: 20)

                        Rectangle()
                            .fill(Color.gray300.opacity(0.6))
                            .frame(width: 1, height: 12)
                        
                        if config.memoOn {
                            Text(config.memo)
                                .typography(.body3, weight: .medium)
                                .foregroundColor(.gray500)
                        }
                    }
                    
                    HStack {
                        Text(config.time)
                            .typography(.body3, weight: .semibold)
                            .foregroundColor(.gray600)
                        Text(config.transactionAmount)
                            .typography(.heading5, weight: .heavy)
                            .foregroundColor(.gray900)
                            .frame(maxWidth: .infinity, minHeight: 24, alignment: .trailing)
                        Text(config.unit)
                            .typography(.heading5, weight: .semibold)
                            .foregroundColor(.gray900)

                    }
                    
                    let remainingAmount = config.remainingAmount
                    if !remainingAmount.isEmpty {
                        HStack {
                            Text(config.remainingAmount)
                                .typography(.body3, weight: .semibold)
                                .foregroundColor(.gray500)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            Text(config.unit)
                                .typography(.body3, weight: .semibold)
                                .foregroundColor(.gray500)
                            
                        }
                    }
                    
                    if config.cancelButtonOn {
                        HStack {
                            TextButton(text: "Cancel", type: .gray, hasUnderLine: true, size: .small, action: config.cancelAction)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.top, 15)
                    }
                    
                    HStack {
                        Rectangle()
                            .fill(Color.dividerLine3)
                            .frame(maxWidth: .infinity, maxHeight: 1)
                        
                    }
                    .padding(.top, 27)
                }
            } else {
                EmptyView()
            }
        } else {
            EmptyView()
        }
    }
}

struct TransactionHistoryList_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack {
                TransactionHistoryList(config: .default)
                TransactionHistoryList(config: PendingTransactionHistoryListConfig(memoOn: true, cancelButtonOn : true, title: "Shinhan Card withdraw", status: "Processing", memo: "Vehicle maintenance costs", time: "13:25", balance: "-891,623,000", subBalance: "1,234,567,891", unit: "VND", cancelAction: {
                    Logger.log("cancel action")
                }))
                TransactionHistoryList(config: .default)
            }
            .padding()
        }
    }
}
