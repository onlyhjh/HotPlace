//
//  View+ValueChanged.swift
//  IOS_CleanArchitecture_Sample
//
//  Created by Su Jin Kim on 2022/04/30.
//

import SwiftUI
import Combine

extension View {
    
    @ViewBuilder
    func valueChanged<T: Equatable>(value: T, onChange: @escaping (T) -> Void) -> some View {
        if #available(iOS 14.0, tvOS 14.0, macOS 11.0, watchOS 7.0, *) {
            self.onChange(of: value, perform: onChange)
        } else {
            self.onReceive(Just(value)) { value in
                onChange(value)
            }
        }
    }
}
