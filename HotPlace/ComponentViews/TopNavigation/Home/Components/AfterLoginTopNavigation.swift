//
//  AfterLoginTopNavigation.swift
//  gma_presentation
//
//  Created by 60156664 on 17/06/2022.
//

import SwiftUI

struct AfterLoginTopNavigation: View {
    var avatar: Image = Image("image_top_avatar")
    @Binding var badgeImage: Image
    var name: String = "Welcome Shinhan Kim"
    var menuOn: Bool = true
    var newAlarmOn: Bool = true

    var onTappedAlarm: () -> Void = {}
    var onTappedMenu: () -> Void = {}
    var onTappedAvatar: () -> Void = {}

    init(avatar: Image? = nil,
                flagImage: Binding<Image>,
                name: String = "Shinhan Kim",
                menuOn: Bool = true,
                newAlarmOn: Bool = true,
                onTappedAlarm: @escaping () -> Void = {},
                onTappedMenu: @escaping () -> Void = {},
                onTappedAvatar: @escaping () -> Void = {}) {
        self.avatar = avatar ?? Image("image_top_avatar")
        self._badgeImage = flagImage
        self.name = name
        self.menuOn = menuOn
        self.newAlarmOn = newAlarmOn
        self.onTappedAlarm = onTappedAlarm
        self.onTappedMenu = onTappedMenu
        self.onTappedAvatar = onTappedAvatar
    }
    
    var body: some View {
        HStack {
            Profile(badgeImage: $badgeImage, badgeOn: true, profileSize: 36, badgeSize: 16)
                .padding(.leading, 24)
                .onTapGesture {
                    // Handle action when tap profile view
                    onTappedAvatar()
                }

            Text("Welcome " + name).typography(.body2,
                                     weight: .medium,
                                     color: .gray900)
            
            Spacer()
            HStack(spacing: menuOn ? 16 : 0) {
            Button(action: onTappedAlarm, label: {
                VStack(alignment: .center, spacing: 0) {
                    if newAlarmOn {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 6, height: 6, alignment: .trailing)
                            .offset(x: 11, y: 1)
                    }
                    Image("image_top_alarm")
                        .frame(width: 18, height: 20, alignment: .center)
                }
                
            })
            .basicStyle()
            .frame(height: 32)

            if menuOn {
                Button(action: onTappedMenu, label: {
                    Image("image_top_menu")
                })
                .basicStyle()
                .frame(width: 24, height: 24, alignment: .trailing)
            }
            }.padding(.trailing, 24)
        }
        .frame(minHeight: 64)
        .background(Color.homeBG)
    }
}

struct AfterLoginNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AfterLoginTopNavigation(flagImage: .constant(Image(systemName: "start")))
        }

    }
}
