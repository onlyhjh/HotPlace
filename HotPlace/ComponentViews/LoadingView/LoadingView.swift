//
//  LoadingView.swift
//  gma_common
//
//  Created by 60156664 on 28/03/2023.
//

import SwiftUI


public struct LoadingViewModifier: ViewModifier {
    
    @ObservedObject var vm: LoadingViewModel
    @State var isPresent: Bool = false
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            content
               
            if isPresent {
                LoadingView(vm: vm)
            }
        }
        .onReceive(vm.$isPresented, perform: { newValue in
            isPresent = newValue
        })
    }
}


public struct LoadingView: View {
    
    @ObservedObject var vm: LoadingViewModel
    @State private var isAnimating = false
    
    var foreverAnimation: Animation {
       Animation.linear(duration: 2.0)
           .repeatForever(autoreverses: false)
   }

    public var body: some View {
        ZStack {
            Color
                .black
                .opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            Image("img_loading_bar")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 72, height: 72)
                .rotationEffect(Angle(degrees: self.isAnimating ? 360 : 0.0))
                .animation(self.isAnimating ? foreverAnimation : .default)
                .onAppear { self.isAnimating = true }
                .onDisappear { self.isAnimating = false }
        }
        //.edgesIgnoringSafeArea(.all)
        .ignoresSafeArea(.keyboard)

		.onAppear{
			hideKeyboard()
		}
    }
}
