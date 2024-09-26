//
//  ColorExtension.swift
//  HotPlace
//
//  Created by 60192229 on 7/30/24.
//

import SwiftUI

public extension Color {
    
    // Blue - Japan
    static let blue900 = Color(hex: "000C4C")
    static let blue800 = Color(hex: "0A1967")
    static let blue700 = Color(hex: "102694")
    static let blue600 = Color(hex: "1D36B4")
    static let blue500 = Color(hex: "2A46D3")
    static let blue400 = Color(hex: "5369DB")
    static let blue300 = Color(hex: "7B8CE4")
    static let blue200 = Color(hex: "A4B0EC")
    static let blue100 = Color(hex: "CCD3F5")
    static let blue50  = Color(hex: "ECF0FB")
    
    // Gold - Japan
    static let gold600 = Color(hex: "9D7F4E")
    static let gold500 = Color(hex: "B49664")
    static let gold300 = Color(hex: "D9CAB1")
    static let gold50 = Color(hex: "F6F2FB")
    
    // Navy
    static let navy900 = Color(hex: "2C3B4E")
    static let navy800 = Color(hex: "3F5067")
    static let navy700 = Color(hex: "4E637D")
    static let navy600 = Color(hex: "5F7795")
    static let navy500 = Color(hex: "6E86A7")
    static let navy400 = Color(hex: "8398B6")
    static let navy300 = Color(hex: "98ACC7")
    static let navy200 = Color(hex: "B4C4DB")
    static let navy100 = Color(hex: "CDDCEF")
    static let navy50 = Color(hex: "E9F0FF")
    
    // Gray - Japan
    static let gray900 = Color(hex: "121619")
    static let gray800 = Color(hex: "21272A")
    static let gray700 = Color(hex: "343A3F")
    static let gray600 = Color(hex: "565C63")
    static let gray500 = Color(hex: "6C747E")
    static let gray400 = Color(hex: "B9C1C9")
    static let gray300 = Color(hex: "D6DBE1")
    static let gray200 = Color(hex: "EBEFF5")
    static let gray100 = Color(hex: "F3F6FB")
    static let gray50  = Color(hex: "F8F9FC")
    
    // Account - ASIS
    static let accountMint = Color(hex: "14AEC6")
    static let accountEmerald = Color(hex: "2EB086")
    static let accountPurple = Color(hex: "42B971")
    static let accountBrown = Color(hex: "896646")
    static let accountCoral = Color(hex: "FF6A63")
    static let accountDark = Color(hex: "303841")
    static let accountMustard = Color(hex: "FFC947")
    static let accountOrange = Color(hex: "F78812")
    static let accountPink = Color(hex: "E6689E")
    static let accountRose = Color(hex: "B8405E")
    
    // TODO: - 실제 컬러값 지정되면 컬러테이블 교정 대상
    // Account - Japan
    static let accountChecking = Color(hex: "FF6A63")
    static let accountForeign = Color(hex: "FFC947")
    static let accountSaving = Color(hex: "E6689E")
    static let accountLoan = Color(hex: "B8405E")
    // Semantic - Japan
    static let semanticInformative = Color(hex: "128ED4")
    static let semanticNegative = Color(hex: "F94D49")
    static let semanticNotice = Color(hex: "FEC42D")
    static let semanticPositive = Color(hex: "42B971")
    static let semanticWithdrawal = Color(hex: "D61111")
    static let semanticDeposit = Color(hex: "102694")
    
    // Background
    static let homeBG = Color(hex: "EAEDF5")
    static let subPageBG = Color(hex: "F8F8FA")
    static let bottomSheetBG = Color(hex: "FFFFFF")
    
    // Gradient
    static let gradientStart =  Color(hex: "5F6700")
    static let gradientEnd = Color(hex: "5F60F9")
    
    // Divider
    static let dividerLine1 = gray500
    static let dividerLine2 = gray300
    static let dividerLine3 = gray300.opacity(0.6)
    
    // Border
    static let borderDefault = gray300
    static let borderFocused = gray500
    static let borderError = semanticNegative
    
    // Shadow
    static let switchShadow = Color(hex: "0F1625", alpha: 0.14)
    static let bottomSheetShadow = gray900.opacity(0.16) // #222428
}

extension Color {
    
    init(hex: String, alpha: CGFloat? = nil) {
        let normalizedHexString: String = Color.normalize(hex)
        var ccc: CUnsignedLongLong = 0
        Scanner(string: normalizedHexString).scanHexInt64(&ccc)
        var resultAlpha: CGFloat {
            switch alpha {
            case nil: return ColorMasks.alphaValue(ccc)
            default: return alpha!
            }
        }
        self.init(CGColor(red: ColorMasks.redValue(ccc),
                          green: ColorMasks.greenValue(ccc),
                          blue: ColorMasks.blueValue(ccc),
                          alpha: resultAlpha))
    }

    func hexDescription(_ includeAlpha: Bool = false) -> String {
        guard let cgColor = self.cgColor else {
            return "Problem with cgColor"
        }
        guard cgColor.numberOfComponents == 4 else {
            return "Color not RGB."
        }
        guard let components = cgColor.components else {
            return "Problem with cgColor.components"
        }
        let aaa = components.map({ Int($0 * CGFloat(255)) })
        let color = String.init(format: "%02x%02x%02x", aaa[0], aaa[1], aaa[2])
        if includeAlpha {
            let alpha = String.init(format: "%02x", aaa[3])
            return "\(color)\(alpha)"
        }
        return color
    }

    fileprivate enum ColorMasks: CUnsignedLongLong {
        case redMask    = 0xff000000
        case greenMask  = 0x00ff0000
        case blueMask   = 0x0000ff00
        case alphaMask  = 0x000000ff

        static func redValue(_ value: CUnsignedLongLong) -> CGFloat {
            return CGFloat((value & redMask.rawValue) >> 24) / 255.0
        }

        static func greenValue(_ value: CUnsignedLongLong) -> CGFloat {
            return CGFloat((value & greenMask.rawValue) >> 16) / 255.0
        }

        static func blueValue(_ value: CUnsignedLongLong) -> CGFloat {
            return CGFloat((value & blueMask.rawValue) >> 8) / 255.0
        }

        static func alphaValue(_ value: CUnsignedLongLong) -> CGFloat {
            return CGFloat(value & alphaMask.rawValue) / 255.0
        }
    }

    fileprivate static func normalize(_ hex: String?) -> String {
        guard var hexString = hex else {
            return "00000000"
        }
        if hexString.hasPrefix("#") {
            hexString = String(hexString.dropFirst())
        }
        if hexString.count == 3 || hexString.count == 4 {
            hexString = hexString.map { "\($0)\($0)" } .joined()
        }
        let hasAlpha = hexString.count > 7
        if !hasAlpha {
            hexString += "ff"
        }
        return hexString
    }
}
