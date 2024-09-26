//
//  ViewExtension.swift
//  HotPlace
//
//  Created by 60192229 on 7/30/24.
//

import SwiftUI

public extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner, ignoringSafeArea: Edge.Set) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners)).edgesIgnoringSafeArea(ignoringSafeArea)
    }
    
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        self.opacity(hidden ? 0 : 1)
            //.transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
            // TODO: Animation disable/enable
            //.animation(.easeIn)
     }

    // TODO: - add hidden with no animation
    @ViewBuilder func isHiddenNoAnimation(_ hidden: Bool, remove: Bool = false) -> some View {
        self.opacity(hidden ? 0 : 1)
            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
     }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

