//
//  StoreTitleView.swift
//  HotPlace
//
//  Created by 60192229 on 9/26/24.
//

import SwiftUI

struct StoreTitleView: View {
    
    var store: HotStore?
    
    var body: some View {
        HStack {
            Image(store?.imagePath ?? "")
                .resizable()
                .frame(width: 30, height: 30)
                .padding(.trailing, 2)
            Text(store?.name ?? "")
                .bold()
            Spacer()
        }
    }
}

#Preview {
    StoreTitleView(store: HotStore(name: "Store111", imagePath: "store_default"))
}
