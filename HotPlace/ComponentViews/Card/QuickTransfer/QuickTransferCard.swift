//
//  QuickTransferCard.swift
//  gma_common
//
//  Created by 60156664 on 28/09/2022.
//

import SwiftUI

/**
  QuickTransferCard Component
  - Author: Shinhan Bank
*/
public struct QuickTransferCard: View {
    public struct QuickTransferCardItem {
        var icon: Image
        var nickName: String
        var id = UUID()
        
        public init(icon: Image, nickName: String) {
            self.icon = icon
            self.nickName = nickName
        }
        
        public static let `default` = QuickTransferCardItem(icon: Image("image_profile_sol"), nickName: "Jackg")
    }

    var items: [QuickTransferCardItem]
    var isShowBox: Bool = true
    var action: (Int) -> Void = {_ in}
    
    private let cardHeight: CGFloat = 120
    private let itemWidth: CGFloat = 52

    /// Init function
    /// - Parameters:
    ///   - items: Display Items
    ///   - action: Handle action when tapped transfer item with index selected
    public init(items: [QuickTransferCardItem],
                isShowBox: Bool = true,
                action: @escaping (Int) -> Void = {_ in}) {
        self.items = items
        self.isShowBox = isShowBox
        self.action = action
    }
     
    public var body: some View {
        ZStack {
            
            Group {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(items.indices, id: \.self) { index in
                            let item = items[index]
                            Button(action: {
                                action(index)
                            }, label: {
                                VStack(spacing: 4) {
                                    Profile(profileImage: item.icon, badgeOn: false, profileSize: 52, showBorder: false)
                                    Text(item.nickName)
                                        .typography(.caption2, weight: .semibold)
                                        .foregroundColor(isShowBox ? .gray600 : .white)
                                        .lineLimit(1)
                                        .frame(maxWidth: itemWidth)
                                }
                            })
                            .basicStyle()
                        }
                    }
                    .padding(.leading, 20)
                }
            }
            
            .frame(minHeight: isShowBox ? cardHeight : 70)
            .background(isShowBox ? Color.white : .clear)
            .cornerRadius(isShowBox ? 16 : 0)
            
            if isShowBox {
                // Shadow view
                Group {
                    Rectangle()
                        .fill(LinearGradient(colors: [.white, .white.opacity(0)], startPoint: .leading, endPoint: .trailing))
                        .frame(width: 20, height: cardHeight)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .cornerRadius(16, corners: [.topLeft, .bottomLeft])
                
                Group {
                    Rectangle()
                        .fill(LinearGradient(colors: [.white, .white.opacity(0)], startPoint: .trailing, endPoint: .leading))
                        .frame(width: 20, height: cardHeight)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .cornerRadius(16, corners: [.topRight, .bottomRight])
                
            }
            
        }
    }
}

struct QuickTransferCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray300.edgesIgnoringSafeArea(.all)
            
            VStack {
                QuickTransferCard(items: [.default,
                                          .default,
                                          .default,
                                          .default,
                                          .default,
                                          .default,
                                          .default,
                                          .default,
                                          .default,
                                          .default])
                
                QuickTransferCard(items: [.default,
                                          .default,
                                          .default,
                                          .default,
                                          .default,
                                          .default,
                                          .default,
                                          .default,
                                          .default,
                                          .default],
                                  isShowBox: false)

            }
        }
    }
}
