//
//  CustomTextFieldContainer.swift
//  gma_common
//
//  Created by 60080254 on 2022/11/02.
//

import SwiftUI



struct ReadOnlyEnvironmentKey : EnvironmentKey {
	static var defaultValue: Bool = false
}

struct InactiveEnvironmentKey : EnvironmentKey {
    static var defaultValue: Bool = false
}

struct ErrorEnvironmentKey : EnvironmentKey {
	static var defaultValue: Bool = false
}

struct KeyboardTypeEnvironmentKey : EnvironmentKey {
	static var defaultValue: UIKeyboardType = .default
}

struct MaxLengthEnvironmentKey : EnvironmentKey {
	static var defaultValue: Int = 0
}

public extension EnvironmentValues {
    var inActive: Bool {
        get { self[InactiveEnvironmentKey.self] }
        set { self[InactiveEnvironmentKey.self] = newValue }
    }

    var isReadOnly: Bool {
		get { self[ReadOnlyEnvironmentKey.self] }
		set { self[ReadOnlyEnvironmentKey.self] = newValue }
	}
    var isError: Bool {
		get { self[ErrorEnvironmentKey.self] }
		set { self[ErrorEnvironmentKey.self] = newValue }
	}
    var keyboardType: UIKeyboardType {
		get { self[KeyboardTypeEnvironmentKey.self] }
		set { self[KeyboardTypeEnvironmentKey.self] = newValue }
	}
    var maxLength: Int {
		get { self[MaxLengthEnvironmentKey.self] }
		set { self[MaxLengthEnvironmentKey.self] = newValue }
	}
}

public extension View
{
    func inActive(_ inActive: Bool) -> some View
    {
        environment(\.inActive, inActive)
    }
    func readOnly(_ isReadOnly: Bool) -> some View
	{
		environment(\.isReadOnly, isReadOnly)
	}
    func error(_ isError: Bool) -> some View
	{
		environment(\.isError, isError)
	}
    func keyboardType(keyboardType: UIKeyboardType) -> some View
	{
		environment(\.keyboardType, keyboardType)
	}
    func maxLength(_ maxLength: Int) -> some View
	{
		environment(\.maxLength, maxLength)
	}
}
