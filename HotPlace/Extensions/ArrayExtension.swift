//
//  ArrayExtension.swift
//  HotPlace
//
//  Created by 60192229 on 7/31/24.
//

import Foundation

public
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
