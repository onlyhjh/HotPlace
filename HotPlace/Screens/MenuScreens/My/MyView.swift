//
//  MyView.swift
//  HotPlace
//
//  Created by 60192229 on 7/30/24.
//

import SwiftUI

struct MyView: View {
    @State var inputStr = ""
    
    var body: some View {
        Text("MyView")
        Spacer()
        TextField("my name", text: $inputStr)
    }
}

#Preview {
    MyView()
}
