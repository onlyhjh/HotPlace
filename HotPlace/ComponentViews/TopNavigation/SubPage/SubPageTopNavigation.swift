//
//  SubPageTopNavigation.swift
//  gma_presentation
//
//  Created by 60156664 on 02/08/2022.
//

import SwiftUI

/**
SubPage TopNavigation
 - Author: Shinhan Bank
*/
public struct SubPageTopNavigation: View {
    var title: String = "title"
    var expanded: Bool = true
    var backIconOn: Bool = true
    var menuIconOn: Bool = true
    var backgroundColor: Color = .subPageBG
    var backAction: () -> Void = {}
    var menuAction: () -> Void = {}
    
	/**
	 SubPage TopNavigation
	 - Parameters:
	   - title: Title of screen.
	   - backIconOn: Back icon display status, if true: display, false: hidden.
	   - menuIconOn: Menu icon display status, if true: display, false: hidden.
	   - expanded: Display with large title or not,  if true: display with large title, false: display with normal titleq.
	   - backAction: Handle action when tap to back button.
	   - menuAction: Handle action when tap to menu button.
	*/
    public init(title: String = "Title",
                backIconOn: Bool = true,
                menuIconOn: Bool = true,
                expanded: Bool = true,
                backgroundColor: Color = .subPageBG,
                backAction: @escaping () -> Void = {},
                menuAction: @escaping () -> Void = {}) {
        self.title = title
        self.backIconOn = backIconOn
        self.menuIconOn = menuIconOn
        self.expanded = expanded
        self.backgroundColor = backgroundColor
        self.backAction = backAction
        self.menuAction = menuAction
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            HStack() {
                // Button back
                if backIconOn {
                    VStack {
                        Button(action: backAction, label: {
                            Image("icon_line_arrow_left_24_black")
                                .frame(width: 24, height: 24)
                                .aspectRatio(contentMode: .fit)
                        })
                        .basicStyle()
                    }
                    .padding(.leading, 14)
                }
                
                if expanded == false {
                    
                    // Title
                    Text(title)
                        .typography(.heading5, weight: .medium, color: .gray900)
                        .frame(maxWidth: .infinity)
                } else {
                    Spacer()
                }
                
                if menuIconOn {
                    VStack {
                        Button(action: menuAction, label: {
                            Image("icon_line_menu_24_black")
                                .frame(width: 24, height: 24)
                                .aspectRatio(contentMode: .fit)
                        })
                        .basicStyle()
                    }
                    .padding(.trailing, 20)
                }
            }
            .frame(height:  expanded && backIconOn == false ? 20 : 56)
            
            // Title when expanded
            if expanded {
                Text(title)
                    .typography(.heading2, weight: .heavy, color: .gray900)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)

            }
        }
        .background(backgroundColor)
    }
}

struct SubPageNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            SubPageTopNavigation(menuIconOn: true, expanded: true)
            SubPageTopNavigation(backIconOn: false, menuIconOn: false, expanded: false)
            SubPageTopNavigation(backIconOn: false, menuIconOn: false, expanded: true)
            SubPageTopNavigation(menuIconOn: false, expanded: true)
            SubPageTopNavigation(menuIconOn: false, expanded: false)
            SubPageTopNavigation(menuIconOn: true, expanded: false)
        }
        .frame(maxWidth: .infinity)
    }
}
