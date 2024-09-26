//
//  TermsView.swift
//  HotPlace
//
//  Created by 60192229 on 8/1/24.
//

import SwiftUI

struct TermsView: View {
    
    @StateObject var vm = TermsViewModel()
    
    var completion: () -> Void = {}
    
    var body: some View {
        ZStack {
            ScrollView {
                Text("dsafda")
            }
            Spacer()
            OneButton(text: "Agree",
                      size: .medium,
                      backgroundType: .filled) {
                completion()
            }
        }
    }
}

#Preview {
    TermsView()
}
