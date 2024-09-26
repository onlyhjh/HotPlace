//
//  BeforeLoginTopNavigation.swift
//  gma_presentation
//
//  Created by 60156664 on 17/06/2022.
//

import SwiftUI

public struct BeforeLoginTopNavigation: View {
    var logo: Image = Image("image_top_logo")
    var menuOn: Bool = true
    var onTappedMenu: () -> Void = {}
    
    public init(logo: Image? = nil,
                menuOn: Bool = true,
                onTappedMenu: @escaping () -> Void = {}) {
        self.logo = logo ?? Image("image_top_logo")
        self.menuOn = menuOn
        self.onTappedMenu = onTappedMenu
    }
    
    public var body: some View {
        HStack {
            logo
                .padding(.leading, 24)
            Spacer()
            if menuOn {
                Button(action: onTappedMenu, label: {
                    Image("image_top_menu")
                })
                .basicStyle()
                .frame(width: 24, height: 24, alignment: .trailing)
                .padding(.trailing, 20)
            }
        }
        .frame(minHeight: 64, alignment: .center)
        .background(Color.homeBG)
    }
}

struct BeforeLoginNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BeforeLoginTopNavigation(onTappedMenu: {
            })
            
            BeforeLoginTopNavigation(menuOn: false, onTappedMenu: {
            })
            
            BeforeLoginTopNavigation(logo: Image(systemName: "star"), onTappedMenu: {
            })
        }

    }
}
