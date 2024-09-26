//
//  Switch.swift
//  gma_presentation
//
//  Created by 60156664 on 16/06/2022.
//

import SwiftUI 

/**
GMA Switch
 - Author: Shinhan Bank
*/
public struct Switch: View {
    @Binding var isOn: Bool
    var onColor = Color.blue700
    var offColor = Color.gray400
    var onTap: (_ newValue: Bool) -> Void = { _ in }
    var onChange: (_ newValue: Bool) -> Void = { _ in }
    @Environment(\.isEnabled) private var isEnabled: Bool

	/**
	GMA Switch
	 - Parameters:
	   - isOn: Whether the switch is on or off, if true: switch on, false: switch off.
	   - onColor: Left part color when switch is on.
	   - offColor: The right part color when the switch is off.
	   - onTap: When tapped on switch (value isOn not change when tapped).
	   - onChange: When value isOn Change.
	*/
    public init(isOn: Binding<Bool>,
                onColor: Color = Color.blue700,
                offColor: Color = Color.gray400,
                onTap: @escaping (_ newValue: Bool) -> Void = {_ in},
                onChange: @escaping (_ newValue: Bool) -> Void = { _ in }) {
        self._isOn = isOn
        self.onColor = onColor
        self.offColor = offColor
        self.onTap = onTap
        self.onChange = onChange
    }
    
    public var body: some View {
        Button(action: {
            onTap(!isOn)
        }) {
            RoundedRectangle(cornerRadius: 12, style: .circular)
                .fill(isEnabled ? (isOn ? onColor : offColor) : Color.gray300)
                .frame(width: 34, height: 20)
                .overlay(
                    ZStack {
                        Circle()
                            .fill(isEnabled ? .white : .gray200)
                            .shadow(color: Color.switchShadow, radius: 4, x: isOn ? -2 : 2, y: 0)
                            .padding(2)
                            .offset(x: isOn ? 7 : -7)
                    }
                )
        }
        .basicStyle()
        .onChange(of: isOn) { newValue in
            self.onChange(newValue)
        }
    }
}

struct Switch_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Switch(isOn: .constant(true), onChange: { value in
            })
            Switch(isOn: .constant(true), onChange: { value in
            })
            Switch(isOn: .constant(false), onChange: { value in
            }).disabled(true)
            Switch(isOn: .constant(false), onChange: { value in
            }).disabled(true)
        }
    }
}
