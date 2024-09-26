//
//  DataTable.swift
//  gma_common
//
//  Created by 60117639 on 2022/10/13.
//

import SwiftUI

public struct DataTable: View {
    var title: String?
    var itemName: String
    var data: String
    var hideDividerLine: Bool
        
    public init(title: String? = nil, itemName: String, data: String, hideDividerLine: Bool = false) {
        self.title = title
        self.itemName = itemName
        self.data = data
        self.hideDividerLine = hideDividerLine
    }
    
    public var body: some View {
        VStack() {
            if title != nil {
                Text(title ?? "")
                    .typography(.caption1, weight: .semibold, color: .gray600)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 8)
                    .padding(.top, 24)
            }
            
            HStack(alignment: .top, spacing: 16) {
                Text(itemName)
                    .typography(.body3, weight: .semibold, color: .gray600)
                    .frame(maxWidth: 86, alignment: .leading)
                    .lineSpacing(0)
                Text(data)
                    .typography(.body3, weight: .medium, color: .black)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding([.top, .bottom], 16)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.dividerLine3)
                .isHidden(hideDividerLine)
        }
        .padding([.leading, .trailing], 20)
    }
}

struct DataTable_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DataTable(title:"title", itemName: "item name", data: "Enter Data")
            DataTable(itemName: "item name", data: "Enter Data")
            DataTable(itemName: "item name", data: "Enter Data", hideDividerLine: true)
        }
    }
}
