//
//  HomeTopNavigation.swift
//  gma_presentation
//
//  Created by 60156664 on 17/06/2022.
//

import SwiftUI

/**
  Home Top Navigation
  - Author: Shinhan Bank
*/
public struct HomeTopNavigation: View {
    var isLoggedIn: Bool
    var logo: Image = Image("image_top_logo")
    var avatar: Image = Image("image_top_avatar")
    var name: String = ""
    @Binding var flagImage: Image
    var menuOn: Bool = true
    var newAlarmOn: Bool = true

    /// Handle action
    var onTappedAlarm: () -> Void = {}
    var onTappedMenu: () -> Void = {}
    var onTappedAvatar: () -> Void = {}
    
	/**
	 Home Top Navigation
	  - Parameters:
	    - isLoggedIn: Login status, if true: logged in, false: not logged in.
	    - logo: Logo image.
	    - avatar: Avatar image.
	    - flagImage: Image of flag indicating current language.
	    - name: Name of customer display on home screen.
	    - menuOn: Menu button display state, if true: display, false: hidden.
	    - newAlarmOn: Alarm icon display state, if true: display, false: hidden.
	    - onTappedAlarm: Handle action when tap to alarm button.
	    - onTappedMenu: Handle action when tap to menu button.
	    - onTappedAvatar: Handle action when tap to avatar image
	*/
    public init(isLoggedIn: Bool = false,
                logo: Image = Image("image_top_logo"),
                avatar: Image? = nil,
                flagImage: Binding<Image>,
                name: String = "",
                menuOn: Bool = true,
                newAlarmOn: Bool = true,
                onTappedAlarm: @escaping () -> Void = {},
                onTappedMenu: @escaping () -> Void = {},
                onTappedAvatar: @escaping () -> Void = {}) {
        self.isLoggedIn = isLoggedIn
        self.logo = logo
        self.avatar = avatar ?? Image("image_top_avatar")
        self._flagImage = flagImage
        self.name = name
        self.menuOn = menuOn
        self.newAlarmOn = newAlarmOn
        self.onTappedAlarm = onTappedAlarm
        self.onTappedMenu = onTappedMenu
        self.onTappedAvatar = onTappedAvatar
    }

    public var body: some View {
        if isLoggedIn {
            AfterLoginTopNavigation(avatar: avatar,
                                    flagImage: $flagImage,
                                    name: name,
                                    menuOn: menuOn,
                                    newAlarmOn: newAlarmOn,
                                    onTappedAlarm: onTappedAlarm, onTappedMenu: onTappedMenu, onTappedAvatar: onTappedAvatar)
        } else {
            BeforeLoginTopNavigation(logo: logo, menuOn: menuOn, onTappedMenu: onTappedMenu)
        }
    }
    
}

struct HomeTopNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HomeTopNavigation(isLoggedIn: false, flagImage: .constant(Image(systemName: "start")))
            
            HomeTopNavigation(isLoggedIn: true, flagImage: .constant(Image(systemName: "start")))
        }
    }
}
