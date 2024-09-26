//
//  ToastOverlay.swift
//  gma_presentation
//
//  Created by 60156664 on 27/06/2022.
//

import SwiftUI

/**
 A component that appears briefly in the center of the screen and then disappears to send a message to the user after an action is taken.
 - Author: Shinhan Bank
 - Parameters:
   - textColor: The color of the text.
   - backgroundColor: The color of the background.
   - duration: The time it takes from existence to disappearance.
   - icon: Icon image on the left.
   - message: The text of the message displayed to the user.
   - isDisplay: Display or not.
*/
public struct ToastOverlay: ViewModifier {
    public struct Config {
        let textColor: Color
        let backgroundColor: Color
        let duration: TimeInterval // default = 3s
        let bottomPadding: CGFloat
        init(textColor: Color = .white,
             backgroundColor: Color = Color.black.opacity(0.9),
             duration: TimeInterval = 3,
             bottomPadding: CGFloat = 200) {
            self.textColor = textColor
            self.backgroundColor = backgroundColor
            self.duration = duration
            self.bottomPadding = bottomPadding
        }
    }
    
    var icon: Image?
    var message: String
    @Binding var isDisplay: Bool
    var config: Config = Config()
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            toastView
        }
    }
    
    private var toastView: some View {
        VStack {
            Spacer()
            if isDisplay {
                Group {
                    HStack(spacing: 9) {
                        if let icon = icon {
                            icon
                                .resizable()
                                .frame(width: 24, height: 24)
                                
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(config.textColor)
                        }
                        Text(message)
                            .multilineTextAlignment(.center)
                            .typography(.body3, weight: .medium, color: config.textColor)

                    }.padding(.leading, icon != nil ? 16 : 20)
                     .padding(.trailing, 20)
                     .padding([.top, .bottom], 12)

                }
                .background(config.backgroundColor)
                .cornerRadius(8)
                .onTapGesture {
                    isDisplay = false
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, config.bottomPadding)
        .animation(.linear(duration: 0.3), value: isDisplay)
        .transition(.opacity)
        .onChange(of: isDisplay, perform: { newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + config.duration) {
                    isDisplay = false
                }
            }
        })

    }
}


public extension View {
    func toastOverlay(icon: Image,
                      message: String,
                      isDisplay: Binding<Bool>) -> some View {
        self.modifier(ToastOverlay(icon: icon,
                                   message: message,
                                 isDisplay: isDisplay))
    }
    
    func toastOverlay(message: String,
                      isDisplay: Binding<Bool>) -> some View {
        self.modifier(ToastOverlay(message: message,
                                 isDisplay: isDisplay))
    }
    
    func toastOverlay(icon: Image?,
                      message: String,
                      isDisplay: Binding<Bool>,
                      config: ToastOverlay.Config) -> some View {
        self.modifier(ToastOverlay(icon: icon,
                                   message: message,
                                   isDisplay: isDisplay,
                                   config: config))
    }
    
    func toastOverlay(icon: Image?,
                      message: String,
                      isDisplay: Binding<Bool>,
                      duration: TimeInterval,
                      bottomPadding: CGFloat = 200) -> some View {
        self.modifier(ToastOverlay(icon: icon,
                                   message: message,
                                   isDisplay: isDisplay,
                                   config: .init(duration: duration,
                                                 bottomPadding: bottomPadding)))
    }
}

struct ToastOverlay_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Rectangle()
                .fill(Color.navy400)
                .frame(height: 300, alignment: .center)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.homeBG.ignoresSafeArea())
            .toastOverlay(icon: Image("image_profile_sol"), message: "Show message", isDisplay: .constant(true))
    }
}
