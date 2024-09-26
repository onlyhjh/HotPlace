//
//  LottieView.swift
//  gma_common
//
//  Created by 60156664 on 28/03/2023.
//

//import SwiftUI
//import Lottie
//
//public struct CommonLottieView: UIViewRepresentable {
//    let lottieFile: String
//    let isLoop: Bool = true
//    let animationView = LottieAnimationView()
//
//    public init(lottieFile: String) {
//        self.lottieFile = lottieFile
//    }
//    
//    public func makeUIView(context: Context) -> some UIView {
//        let view = UIView(frame: .zero)
//
//        animationView.animation = LottieAnimation.named(lottieFile, bundle: GMALocalBundleClass.bundle())
//        animationView.contentMode = .scaleAspectFit
//        animationView.play()
//        if isLoop {
//            animationView.loopMode = .loop
//        }
//        view.addSubview(animationView)
//
//        animationView.translatesAutoresizingMaskIntoConstraints = false
//        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
//        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//
//        return view
//    }
//
//    public func updateUIView(_ uiView: UIViewType, context: Context) {
//
//    }
//}
