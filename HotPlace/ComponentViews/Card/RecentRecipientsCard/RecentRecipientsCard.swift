//
//  RecentRecipientsCard.swift
//  gma_common
//
//  Created by 60156664 on 04/10/2022.
//

import SwiftUI

public struct RecentRecipientsCard: View {
    public struct RecentRecipientsCardItem {
        var thumb: Image
        var title: String
        var subTitle: String
        var acNo: String = ""
        
        public static let `default` = RecentRecipientsCardItem(thumb: Image("sol_logo"), title: "Toss vivarepublica Corp.", subTitle: "Shinhan Cambodia 1234567891012 ")
    }

    var items: [RecentRecipientsCardItem] = []
    var padding: CGFloat = 20
    var spacing: CGFloat = 8
    var action: (RecentRecipientsCardItem) -> Void = {_ in }

    private var cardItems: [[RecentRecipientsCardItem]] {
        items.chunked(into: 3)
    }
    
    static let cardHeight: CGFloat = 282
    static let rowHeight: CGFloat = 94
    
    public init(items: [RecentRecipientsCardItem] = [],
                padding: CGFloat = 20,
                spacing: CGFloat = 8,
                action: @escaping (RecentRecipientsCardItem) -> Void = {_ in }) {
        self.items = items
        self.padding = padding
        self.spacing = spacing
        self.action = action
    }

    public var body: some View {
        VStack {
            PagingView(config: .init(margin: padding, spacing: spacing)) {
                Group {
                    ForEach(cardItems.indices, id: \.self) { index in
                        RecentRecipientsCardView(items: cardItems[index], isPaging: items.count > 3) { item in
                            action(item)
                        }
                    }
                }
                .background(Color.white)
                .mask(RoundedRectangle(cornerRadius: 12))
                .cornerRadius(12)
            }
        }
        .frame(height: items.count > 3 ? RecentRecipientsCard.cardHeight : RecentRecipientsCard.rowHeight * CGFloat(items.count))
    }
}


private struct RecentRecipientsCardView: View {
    var items: [RecentRecipientsCard.RecentRecipientsCardItem] // max item = 3
    var isPaging: Bool = false
    var action: (RecentRecipientsCard.RecentRecipientsCardItem) -> Void = {_ in }

    var body: some View {
        VStack(spacing: 0) {
            ForEach(items.indices, id: \.self) { index in
                RecentRecipientsCardRow(item: items[index], hiddenDivider: (isPaging && index == 2) || (!isPaging && index == items.count - 1 ), action: { item in
                    action(item)
                })
            }
        }
        .frame(maxHeight: isPaging ? RecentRecipientsCard.cardHeight : (RecentRecipientsCard.rowHeight * CGFloat(items.count)), alignment: .top)
    }
}


private struct RecentRecipientsCardRow: View {
    var item: RecentRecipientsCard.RecentRecipientsCardItem = .default
    var hiddenDivider: Bool
    var action: (RecentRecipientsCard.RecentRecipientsCardItem) -> Void = {_ in }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                let thumb = item.thumb
                    thumb
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40, alignment: .topLeading)
              
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(item.title)
                        .typography(.heading6, weight: .medium, color: .gray900)
                        .frame(minHeight: 22, alignment: .leading)
                        .lineLimit(1)
                    let subTitle = item.subTitle 
                        Text(subTitle)
                            .typography(.body3, weight: .semibold, color: .gray900)
                            .frame(minHeight: 20, alignment: .leading)
                            .lineLimit(1)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            // Divider
            Rectangle()
                .fill(Color.gray300.opacity(0.6))
                .frame(height: 1)
                .padding(.top, 25)
                .isHidden(hiddenDivider)
        }
        .padding(.top, 26)
        .padding(.horizontal, 26)
        .onTapGesture {
            action(item)
        }
    }
}

struct RecentRecipientsCard_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack {
                RecentRecipientsCard(items: [])
                RecentRecipientsCard(items: [.default])
                RecentRecipientsCard(items: [.default, .default])
                RecentRecipientsCard(items: [.default,
                                             .default,
                                             .default,
                                             .default,
                                             .default,
                                             .default])
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.homeBG.ignoresSafeArea())
        }
    }
}
