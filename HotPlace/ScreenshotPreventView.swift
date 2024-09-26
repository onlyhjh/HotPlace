//
//  ScreenshotPreventView.swift
//  HotPlace
//
//  Created by 60192229 on 8/6/24.
//

import SwiftUI

extension View {
    @ViewBuilder func preventScreenshot(shouldPrevent: Bool = true) -> some View {
        if shouldPrevent {
            ScreenshotPreventView { self }
        } else {
            self
        }
    }
}

public struct ScreenshotPreventView<Content: View>: UIViewRepresentable {
    
    let content: () -> Content
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    public func makeUIView(context: Context) -> UIView {
        
        let secureTextField = UITextField()
        secureTextField.isSecureTextEntry = true
        secureTextField.isUserInteractionEnabled = false
        
        guard let secureView = secureTextField.layer.sublayers?.first?.delegate as? UIView else {
            return UIView()
        }
        
        secureView.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
        
        let hController = UIHostingController(rootView: content())
        hController.view.backgroundColor = .clear
        hController.view.translatesAutoresizingMaskIntoConstraints = false
        
        secureView.addSubview(hController.view)
        
        NSLayoutConstraint.activate([
            hController.view.topAnchor.constraint(equalTo: secureView.topAnchor),
            hController.view.bottomAnchor.constraint(equalTo: secureView.bottomAnchor),
            hController.view.leadingAnchor.constraint(equalTo: secureView.leadingAnchor),
            hController.view.trailingAnchor.constraint(equalTo: secureView.trailingAnchor)
        ])
        
        return secureView
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) { }
}
