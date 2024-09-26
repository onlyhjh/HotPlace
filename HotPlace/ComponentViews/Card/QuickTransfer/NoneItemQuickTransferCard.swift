//
//  NoneItemRecentRecipientsCard.swift
//  gma_common
//
//  Created by 60156664 on 04/10/2022.
//

import SwiftUI

public struct NoneItemQuickTransferCard: View {
    private let maxHeight: CGFloat = 188
    private var title: String = "Quick transfer"
    var subTitle: String = "Add recipients to Quick\nTransfer to expedite your next transfer process"
    var buttonTitle: String = "Add"
    var noneItemAction: () -> Void = {}

    public init(title: String = "Quick transfer",
                buttonTitle: String = "Add",
                subTitle: String = "Add recipients to Quick\nTransfer to expedite your next transfer process",
                noneItemAction: @escaping () -> Void = {}) {
        self.noneItemAction = noneItemAction
        self.title = title
        self.buttonTitle = buttonTitle
        self.subTitle = subTitle
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .frame(minHeight: maxHeight)

            VStack(alignment: .leading, spacing: 25 ) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .typography(.heading5
                                    , weight: .heavy, color: .navy900)
                        .padding(.vertical, 8)
                    Text(subTitle)
                        .typography(.body3, weight: .medium, color: .navy900)
                        .lineSpacing(4)
                        .padding(.trailing, 100)
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

                VStack {
                    FilledButton(text: buttonTitle,
                                 rightIcon: Image("icon_line_plus_12_black"),
                                 size: .small,
                                 type: .gray,
                                 action: noneItemAction)
                }.padding(.bottom, 22)

            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding([.leading, .top], 20)

            Image("image_card_area")
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .bottomTrailing)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct NoneItemRecentRecipientsCard_Previews: PreviewProvider {
    static var previews: some View {
        NoneItemQuickTransferCard()
    }
}
