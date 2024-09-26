//
//  BasicList.swift
//  gma_common
//
//  Created by 60156664 on 30/09/2022.
//

import SwiftUI


public protocol BasicListConfig {
}

public struct ThumbBasicListConfig: BasicListConfig {
    var thumbImage: Image?
    var title: String
    // optional variable
    var subTitle: String?
    var caption1: String?
    var caption2: String?
    var captionSegments: Int = 1
    var icon: Image?
    var iconOn: Bool = true
    var isBold: Bool = false
    var hiddenDivider: Bool = false

    var size: ThumbBasicListConfigSize = .medium
 
    public enum ThumbBasicListConfigSize {
        case medium
        case small
    }
    
    public init(thumbImage: Image, title: String) {
        self.thumbImage = thumbImage
        self.title = title
    }
    
    public init(thumbImage: Image,
                title: String,
                subTitle: String? = nil,
                caption1: String? = nil,
                caption2: String? = nil ,
                captionSegments: Int = 1,
                icon: Image? = nil,
                iconOn: Bool = true,
                size: ThumbBasicListConfigSize = .medium,
                isBold: Bool = false,
                hiddenDivider: Bool = false) {
        self.thumbImage = thumbImage
        self.title = title
        self.subTitle = subTitle
        self.caption1 = caption1
        self.caption2 = caption2
        self.icon = icon
        self.iconOn = iconOn
        self.captionSegments = captionSegments
        self.size = size
        self.isBold = isBold
        self.hiddenDivider = hiddenDivider
    }
    
    public init(title: String,
                subTitle: String? = nil,
                caption1: String? = nil,
                caption2: String? = nil ,
                captionSegments: Int = 1,
                icon: Image? = nil,
                iconOn: Bool = true,
                size: ThumbBasicListConfigSize = .medium,
                isBold: Bool = false,
                hiddenDivider: Bool = false) {
        self.title = title
        self.subTitle = subTitle
        self.caption1 = caption1
        self.caption2 = caption2
        self.icon = icon
        self.iconOn = iconOn
        self.captionSegments = captionSegments
        self.size = size
        self.isBold = isBold
        self.hiddenDivider = hiddenDivider
    }
}

public struct BasicList: View {
    var config: BasicListConfig
    
    public init(config: ThumbBasicListConfig) {
        self.config = config
    }
    
    public var body: some View {
        if config is ThumbBasicListConfig {
            if let config = config as? ThumbBasicListConfig {
                ThumbBasicList(config: config)
            } else {
                EmptyView()
            }
            
        } else {
            EmptyView()
        }
    }
}

struct ThumbBasicList: View {
    var config: ThumbBasicListConfig
    
    var body: some View {
        if config.size == .medium {
            VStack(spacing: 0) {
                HStack(spacing: 16) {
                    if let thumb = config.thumbImage {
                        thumb
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40, alignment: .topLeading)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(config.title)
                            .typography(.heading6, weight: config.isBold ? .heavy : .medium, color: .gray900)
                        if let subTitle = config.subTitle {
                            Text(subTitle)
                                .typography(.body3, weight: .semibold, color: .gray900)
                        }
                        
                        if config.captionSegments == 2 {
                            if let caption1 = config.caption1, let caption2 = config.caption2 {
                                HStack(spacing: 6) {
                                    Text(caption1)
                                        .typography(.body3, weight: .semibold, color: .gray600)
                                    Rectangle()
                                        .fill(Color.gray300.opacity(0.6))
                                        .frame(width: 1, height: 12)
                                    Text(caption2)
                                        .typography(.body3, weight: .semibold, color: .gray600)
                                }
                            }
                        }
                        
                        if config.captionSegments == 1 {
                            if let caption1 = config.caption1 {
                                Text(caption1)
                                    .typography(.body3, weight: .semibold, color: .gray600)
                            } else if let caption2 = config.caption2 {
                                Text(caption2)
                                    .typography(.body3, weight: .semibold, color: .gray600)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    if let icon = config.icon, config.iconOn {
                        VStack {
                            icon
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Divider
                Rectangle()
                    .fill(Color.gray300.opacity(0.6))
                    .frame(height: 1)
                    .padding(.top, 21)
                    .isHidden(config.hiddenDivider)
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
            
        } else {
            VStack {
                HStack(spacing: 12) {
                    if let thumb = config.thumbImage  {
                        thumb
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                        Text(config.title)
                            .typography(.heading6, weight: .medium, color: .gray900)
                            .frame(maxWidth: .infinity, alignment: .leading)

                    } else {
                        Text(config.title)
                            .typography(.heading6, weight: .medium, color: .gray900)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        if let icon = config.icon {
                            icon
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)

                        }
                    }
                    
                    
                }
                .padding(.top, 12)
                .padding(.bottom, 11)
                
                // Divider
                Rectangle()
                    .fill(Color.gray300.opacity(0.6))
                    .frame(height: 1)
            }
            .padding(.horizontal, 20)
        }
    }
}

struct BasicList_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BasicList(config: ThumbBasicListConfig(title: "Title"))
            BasicList(config: ThumbBasicListConfig(thumbImage: .init(systemName: "star"), title: "Title"))
            BasicList(config: ThumbBasicListConfig(thumbImage: .init(systemName: "trash"), title: "Title ", size: .small))
            BasicList(config: ThumbBasicListConfig(title: "Title", icon: .init(systemName: "trash"), size: .small))
            BasicList(config: ThumbBasicListConfig(thumbImage: .init(systemName: "star"), title: "Title", icon: .init(systemName: "trash")))
            BasicList(config: ThumbBasicListConfig(thumbImage: .init(systemName: "star"), title: "Title", subTitle: "sub title"))
            BasicList(config: ThumbBasicListConfig(thumbImage: .init(systemName: "star"), title: "Title", subTitle: "sub title", caption1: "caption 1", caption2: "caption2", captionSegments: 2, icon: .init(systemName: "trash")))
        }
      }
}
