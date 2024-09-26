//
//  IconButtonGroup.swift
//  gma_presentation
//
//  Created by 60156664 on 20/06/2022.
//

import SwiftUI
import UIKit

public struct IconButtonGroupItem {
    var text: String
    var icon: Image
    var textColor: Color = .gray900
    
    public init(text: String,
                icon: Image,
                textColor: Color = .gray900) {
        self.text = text
        self.icon = icon
        self.textColor = textColor
    }
}

public struct IconButtonGroup: View {

    @Binding var items: [IconButtonGroupItem]
    var segments: Int = 4
    var backgroundOn: Bool = true
    var size: LabelIconButtonConfig.IconButtonSize = .medium
    var action: ((Int) -> Void)?
    
    private var chunkItems: [[IconButtonGroupItem]] = []
    @State private var viewSize: CGSize?
    
    public init(items: Binding<[IconButtonGroupItem]>,
                segments: Int = 4,
                backgroundOn: Bool = true,
                size: LabelIconButtonConfig.IconButtonSize = .medium,
                action: ((Int) -> Void)? = nil) {
        self._items = items
        self.segments = segments
        self.backgroundOn = backgroundOn
        self.size = size
        self.action = action
        self.chunkItems = self.items.chunked(into: segments)
    }
    
    public var body: some View {
        ZStack {
            // safearea 사이즈 획득
            GeometryReader { proxy in
                Color.clear.onAppear {
                    self.viewSize = proxy.size
                }
            }
            VStack(spacing: 16) {
                ForEach(0..<chunkItems.count, id: \.self) { index in
                    // Row
                    let rows = chunkItems[index]
                    HStack(alignment: .top, spacing: 0) {
                        ForEach(0..<rows.count, id: \.self) { indexRow in
                            let item = rows[indexRow]
                            VStack() {
                                IconButton(config: LabelIconButtonConfig(icon: item.icon,
                                           text: item.text,
                                           textColor: item.textColor,
                                           backgroundOn: backgroundOn, size: size, action: {
                                    if let action = action {
                                        // index 0 -> items.count - 1
                                        let lastIndex = index > 0 ? index - 1 : 0
                                        
                                        action(index * chunkItems[lastIndex].count + indexRow)
                                    }
                                }))
                            }
                            .frame(maxWidth: (self.viewSize?.width ?? UIScreen.main.bounds.width)/4, alignment: .top)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: chunkItems.count > 1 ? .leading : .center)
                }
            }
        }
    }
}

struct IconButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            // None action
            IconButtonGroup(items: .constant([IconButtonGroupItem(text: "Account", icon: Image(systemName: "trash")),
                                    IconButtonGroupItem(text: "Tranfer Tranfer TranferTranfer", icon: Image(systemName: "star")),
                                    IconButtonGroupItem(text: "Loan", icon: Image(systemName: "star.fill")),
                                    IconButtonGroupItem(text: "Edit", icon: Image(systemName: "trash.fill"), textColor: .red),
                                    IconButtonGroupItem(text: "Help\nCenter", icon: Image(systemName: "trash")),
                                    IconButtonGroupItem(text: "Button item", icon: Image(systemName: "trash")),
                                    IconButtonGroupItem(text: "edit", icon: Image(systemName: "trash"))
                                              
                                   ]),
                            segments: 4,
                            backgroundOn: true)
            
            // With action
            IconButtonGroup(items: .constant([IconButtonGroupItem(text: "Account", icon: Image(systemName: "trash")),
                                    IconButtonGroupItem(text: "Account", icon: Image(systemName: "trash")),
                                    IconButtonGroupItem(text: "Account", icon: Image(systemName: "trash"))]),
                            segments: 3,
                            size: .small,
                            action: { index in
                    // handle with index 0 -> items.count - 1
            })
        }
        .padding(.horizontal, 20)
        .background(Color.homeBG)
    }
}
