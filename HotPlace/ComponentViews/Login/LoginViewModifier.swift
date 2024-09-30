//
//  LoginViewModifier.swift
//  UIBank
//
//  Created by 60156664 on 17/02/2023.
//

import SwiftUI

public struct LoginViewModifier: ViewModifier {
    
    @ObservedObject public var vm: InfoSheetViewModel
    @State var isPresent: Bool = false
    
    public
    func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            content
    
            if isPresent {
                LoginView(vm: vm)
            }
        }
        .ignoresSafeArea()
        .onReceive(vm.$isPresented, perform: { newValue in
            isPresent = newValue
        })
    }
}


public struct LoginView: View {
    
    @ObservedObject var vm: InfoSheetViewModel
    @State var inputStr = ""

    public var body: some View {
        ZStack {
            Color
                .black
                .opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                
                VStack {
                    Text("login")
                    
                    TextField("my name", text: $inputStr)
                        .padding(20)
                    
                    CTAButton(type: .basic, config: OneButtonConfig(text: vm.button1Title, colorType: .primary, backgroundType: .filled, action: {
                        if let action = vm.button1Action {
                            action()
                        }
                    }))
                }
                .padding(20)
                .background{
                    Color.white
                }
                
                
            }
        }
//        .edgesIgnoringSafeArea(.all)
//        .ignoresSafeArea(.keyboard)

        .onAppear{
            hideKeyboard()
        }
    }
}
