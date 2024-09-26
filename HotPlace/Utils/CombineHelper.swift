//
//  CancelBag.swift
//  HotPlace
//
//  Created by 60192229 on 7/31/24.
//

import Foundation
import Combine
import SwiftUI

typealias Store<State> = CurrentValueSubject<State, Never>

class CancelBag {
    var subscriptions = Set<AnyCancellable>()
    
    // 해제코드
    func disposeAll(){
        subscriptions.forEach { cancel in
            cancel.cancel()
        }
    }
    
    init() {}
}

extension AnyCancellable {
    static var cancelled: AnyCancellable {
        let cancellable = AnyCancellable({ })
        cancellable.cancel()
        return cancellable
    }
    
    func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}

// Compiling failed: ambiguous use of 'subscript(_:)' 에러로 인해 주석처리 해놓음

//extension CurrentValueSubject {
//
//    subscript<T>(keyPath: WritableKeyPath<Output, T>) -> T where T: Equatable {
//        get { value[keyPath: keyPath] }
//        set {
//            var value = self.value
//            if value[keyPath: keyPath] != newValue {
//                value[keyPath: keyPath] = newValue
//                self.value = value
//            }
//        }
//    }
//
//    func bulkUpdate(_ update: (inout Output) -> Void) {
//        var value = self.value
//        update(&value)
//        self.value = value
//    }
//
//    func updates<Value>(for keyPath: KeyPath<Output, Value>) ->
//        AnyPublisher<Value, Failure> where Value: Equatable {
//        return map(keyPath).removeDuplicates().eraseToAnyPublisher()
//    }
//}

extension Subscribers.Completion {
    var error: Failure? {
        switch self {
        case let .failure(error): return error
        default: return nil
        }
    }
}
