//
//  StringExtension.swift
//  HotPlace
//
//  Created by 60192229 on 7/31/24.
//

import Foundation

extension String {
    func fixServerCRLF()->String{
        return self
            .replacingOccurrences(of: "\\n", with:"\n")
            .replacingOccurrences(of: "\\r", with:"\n")
            .replacingOccurrences(of: "<br/>", with: "\n")
            .replacingOccurrences(of: "</br>", with: "\n")
            .replacingOccurrences(of: "<br>", with: "\n")
    }
}
