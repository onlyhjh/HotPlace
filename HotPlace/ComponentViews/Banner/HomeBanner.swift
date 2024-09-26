//
//  HomeEventCard.swift
//  gma_presentation
//
//  Created by 60156664 on 20/06/2022.
//

import SwiftUI

/**
Banner used at the bottom of the home screen
 - Author: Shinhan Bank
*/
public struct HomeBanner: View {
    public enum HomeBannerOrientation {
        case vertical
        case horizontal
    }
    
    public enum HomeBannerSize: CGFloat {
        case tiny = 80
        case small = 122
        case medium = 190
        case large = 312
        
        var orientation: HomeBannerOrientation {
            switch self {
            case .tiny, .small, .medium:
                return .horizontal
            case .large:
                return .vertical
            }
        }
        
        public var height: CGFloat {
            switch self {
            case .tiny:
                return 80
            case .small:
                return 122
            case .medium:
                return 190
            case .large:
                return 312
            }
        }
        
        var imageHeight: CGFloat {
            switch self {
            case .tiny:
                return 80
            case .small:
                return 122
            case .medium:
                return 190
            case .large:
                return 200
            }
        }
        
        var labelLeadingPadding: CGFloat {
            switch self {
            case .tiny:
                return 0
            case .small:
                return -20
            case .medium:
                return -30
            case .large:
                return 20
            }
        }
        
        var labelTopPadding: CGFloat {
            switch self {
            case .tiny:
                return 18
            case .small:
                return 16
            case .medium:
                return 24
            case .large:
                return 20
            }
        }

    }
    
    @Binding var image: Image
    var url: String = ""
    var title: String = ""
    var subTitle: String = ""
    var fillColor: Color = .white
    var size: HomeBannerSize = .medium
    
    var titleColor: Color = .white
    var subTitleColor: Color = .gray600
    
    var action: () -> Void = {}
    
	/**
	Banner used at the bottom of the home screen
	 - Parameters:
	   - image: Image on the left.
	   - title: The text of the top title.
	   - subTitle: The text of the lower subtitle.
	   - fillColor: background color.
	   - action: Action taken when the banner is clicked.
	*/
    public init(image: Binding<Image>,
                title: String = "",
                subTitle: String = "",
                size: HomeBannerSize = .medium,
                fillColor: Color = .white,
                action: @escaping () -> Void = {}) {
        self._image = image
        self.title = title
        self.subTitle = subTitle
        self.size = size
        self.fillColor = fillColor
        self.action = action
    }
    
	/**
	Banner used at the bottom of the home screen
	 - Parameters:
	   - image: Image on the left.
	   - title: The text of the top title.
	   - subTitle: The text of the lower subtitle.
	   - fillColor: background color.
	   - titleColor: The color of the text in the top title.
	   - subTitleColor: The color of the text in the lower subtitle.
	   - action: Action taken when the banner is clicked.
	*/
    public init(image: Binding<Image>,
                title: String = "",
                subTitle: String = "",
                size: HomeBannerSize = .medium,
                fillColor: Color = .blue300,
                titleColor: Color = .white,
                subTitleColor: Color = .white,
                action: @escaping () -> Void = {}) {
        self._image = image
        self.title = title
        self.subTitle = subTitle
        self.size = size
        self.fillColor = fillColor
        self.titleColor = titleColor
        self.subTitleColor = subTitleColor
        self.action = action
    }
        
    public var body: some View {
        ZStack {
            Button(action: {
                action()

            }, label: {
                if size == .large {
                    VStack(spacing: 0) {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: size.imageHeight)
                            .frame(maxWidth: .infinity)

                        VStack(spacing: 8) {
                            Text(title)
                                .typography(17, weight: .heavy, color: .navy900)
                                .lineLimit(2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)

                            Text(subTitle)
                                .typography(.caption2, weight: .semibold, color: subTitleColor)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)

                        }
                        .padding(.vertical, 20)
                        .padding(.horizontal, 20)
                        .frame(maxHeight: .infinity, alignment: .top)
                        
                    }
                    .frame(height: size.height, alignment: .top)
                } else {
                    HStack(spacing: 0) {
                        ZStack(alignment: .trailing) {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: size.imageHeight, height: size.imageHeight,  alignment: .bottomLeading)
                            
                            Rectangle()
                                .fill(LinearGradient(colors: [.white.opacity(0), .white.opacity(1)], startPoint: .leading, endPoint: .trailing))
                                .frame(width: size.imageHeight * 0.6, height: size.imageHeight)

                        }
                        
                        ZStack {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(title)
                                    .typography(size == .tiny ? 16 : 17, weight: .heavy, color: .navy900)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .lineLimit(2)
                                    .multilineTextAlignment(.leading)

                                if size != .tiny {
                                    Text(subTitle)
                                        .typography(.caption2, weight: .semibold, color: subTitleColor)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .lineLimit(size == .small ? 2 : nil)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                        }
                        .padding(.top, size.labelTopPadding)
                        .padding(.leading, size.labelLeadingPadding)
                        .padding(.trailing, 20)
                        .frame(height: size.imageHeight, alignment: .top)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            })
        }
        .background(fillColor)
        .cornerRadius(16)
        .basicStyle()
    }
}

struct HomeEventCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HomeBanner(image: .constant(Image("")), title: "Install\nthe Shinhan SOL!",
                       subTitle: "If you pass the diary and find a lovely character, you’ll be chosen!",
                       size: .tiny,
                       fillColor: .white)
            HomeBanner(image: .constant(Image("")),
                       title: "Install\nthe Shinhan SOL!",
                       subTitle: "If you pass the diary and find a lovely character, you’ll be chosen!",
                       size: .small,
                       fillColor: .white)
            HomeBanner(image: .constant(Image("")),
                       title: "Install\nthe Shinhan SOL!",
                       subTitle: "If you pass the diary and find a lovely character, you’ll be chosen!, lovely character, you’ll be chosen, lovely character, you’ll be chosen, lovely character, you’ll be chosen, lovely character, you’ll be chosen",
                       size: .medium,
                       fillColor: .white)
            HomeBanner(image: .constant(Image("")),
                       title: "Install the Shinhan SOL!",
                       subTitle: "If you pass the diary and find a lovely character, you’ll be chosen!, lovely character, you’ll be chosen",
                       size: .large,
                       fillColor: .white)
        }.padding()
            .background(Color.homeBG)
    }
}
