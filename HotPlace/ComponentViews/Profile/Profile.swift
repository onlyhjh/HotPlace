//
//  Profile.swift
//  gma_presentation
//
//  Created by 60156664 on 22/06/2022.
//

import SwiftUI

/**
  Profile Component
  - Author: Shinhan Bank
*/
public struct Profile: View {
    var profileImage: Image
    @Binding var badgeImage: Image
    var badgeOn: Bool
    var profileSize: CGFloat = 56
    var badgeSize: CGFloat = 28
    var showBorder: Bool = true
    var tapBadgeAction: () -> Void = {}
	/**
	 Profile Component
	 - Parameters:
	   - profileImage: Image for profile.
	   - badgeImage: Badge image related to alram in the lower right.
	   - badgeOn: Whether to use badge.
	   - size: Profile Size. (small, medium, large)
	*/
    public init(profileImage: Image = Image("image_profile_sol"),
                badgeImage: Binding<Image> = .constant(.init(systemName: "50.square.fill")),
                badgeOn: Bool = true,
                profileSize: CGFloat = 52,
                badgeSize: CGFloat = 28,
                showBorder: Bool = true,
                tapBadgeAction: @escaping () -> Void = {}) {
        self.profileImage = profileImage
        self._badgeImage = badgeImage
        self.badgeOn = badgeOn
        self.profileSize = profileSize
        self.badgeSize = badgeSize
        self.showBorder = showBorder
        self.tapBadgeAction = tapBadgeAction
    }
    
    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
            profileImage
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: profileSize, height: profileSize, alignment: .center)
                .cornerRadius(profileSize/2)
//                .overlay(RoundedRectangle(cornerRadius: profileSize/2)
//                            .stroke(.white, lineWidth: showBorder ? 1 : 0))
            if badgeOn {
                badgeImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: badgeSize, height: badgeSize, alignment: .center)
                    .cornerRadius(badgeSize/2)
//                    .overlay(RoundedRectangle(cornerRadius: badgeSize/2)
//                        .stroke(.white, lineWidth: showBorder ? 1 : 0))
                    .offset(x: 4, y: 2)
                    .onTapGesture {
                        tapBadgeAction()
                    }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Profile(badgeImage: .constant(Image(systemName: "36.square.fill")))
            
            Profile(profileImage: Image(systemName: "50.square.fill"),
                    badgeImage: .constant(Image(systemName: "36.square.fill")),
                    badgeOn: false)
            
            Profile(profileImage: Image(systemName: "50.square.fill"),
                    badgeImage: .constant(Image(systemName: "36.square.fill")))
            
        }.background(Color.gray200)
    }
}
