//
//  AlertViewModifier.swift
//  UIBank
//
//  Created by 60156664 on 17/02/2023.
//

import SwiftUI

public struct AlertViewModifier: ViewModifier {
    
    @ObservedObject public var vm: InfoSheetViewModel
    @State var isPresent: Bool = false
    
    public
    func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            content
    
            if isPresent {
                AlertView(vm: vm)
            }
        }
        .onReceive(vm.$isPresented, perform: { newValue in
            isPresent = newValue
        })
    }
}


public struct AlertView: View {
    
    @ObservedObject var vm: InfoSheetViewModel

    public var body: some View {
        ZStack {
            Color
                .black
                .opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                Text(vm.title ?? "no title")
                Text(vm.description)
                
                CTAButton(type: .basic, config: OneButtonConfig(text: vm.button1Title, colorType: .primary, backgroundType: .filled, action: {
                    if let action = vm.button1Action {
                        action()
                    }
                }))
                .padding(.horizontal, 20)
                
            }
        }
        //.edgesIgnoringSafeArea(.all)
        .ignoresSafeArea(.keyboard)

        .onAppear{
            hideKeyboard()
        }
    }
}
