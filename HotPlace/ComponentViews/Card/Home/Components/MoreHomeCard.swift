//
//  MoreHomeCard.swift
//  gma_presentation
//
//  Created by 60156664 on 21/06/2022.
//

import SwiftUI

struct MoreHomeCard: View {
    var icon: Image = Image("icon_hom_card_more")
    var text: String = "All accounts"
    var backgroundColor: Color = .navy100
    
    init(icon: Image = Image("icon_hom_card_more"),
                text: String = "All accounts",
                backgroundColor: Color = .navy100) {
        self.icon = icon
        self.text = text
        self.backgroundColor = backgroundColor
    }
        
    public var body: some View {
        HStack (spacing: 12) {
            ZStack(alignment: .center) {
                Circle()
                    .fill(Color.navy400.opacity(0.3))
                    .frame(width: 36, height: 36, alignment: .center)
                icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20, alignment: .center)
            }
            
            Text(text)
                .typography(.heading6, weight: .medium, color: .navy900)
            Spacer()
            Image("icon_hom_card_arrow_right")
        }
        .padding([.leading, .trailing], 24)
        .frame(maxWidth: .infinity, minHeight: 80)
        .background(backgroundColor)
        .cornerRadius(16)
    }
}

struct CardHomeMore_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MoreHomeCard()
                .padding()
            MoreHomeCard(text: "More example", backgroundColor: .blue400)
                .padding()
        }
    }
}
