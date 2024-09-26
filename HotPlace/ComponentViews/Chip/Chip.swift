//
//  Chip.swift
//  gma_common
//
//  Created by 60080254 on 2023/02/17.
//

import SwiftUI

public struct Chip: View {
	@Binding public var selectedIndex : Int
	private var segments : Int
	private var labelArray : Array<String>
	private var size : ChipSize
	
	public enum ChipSize {
		case normal, small
		
		var textSize: CGFloat {
			switch self {
			case .normal: return 15
			case .small: return 11
			}
		}
		
		var height: CGFloat {
			switch self {
			case .normal: return 50
			case .small: return 28
			}
		}
	}
	
	public init(segments: Int, selectedIndex: Binding<Int>, labelArray: Array<String>, size: ChipSize = .normal) {
		self.segments = segments
		self.labelArray = labelArray
		self._selectedIndex = selectedIndex
		self.size = size
	}
	
	public var body: some View {
		ZStack {
			HStack(spacing: 0) {
				ForEach(0 ..< segments, id: \.self) { index in
					ChipDefaultItem(label: labelArray[index], index: index, segments: segments, selectedIndex: $selectedIndex, size: size)
				}
			}
		}
		.frame(height: size.height)
		.frame(maxWidth: .infinity)
	}
}

private struct ChipDefaultItem: View {
	enum locationEnum {
		case first
		case middle
		case end
	}
	
	var index : Int
	var segments: Int
	var label : String
	var location : locationEnum
	var corners : UIRectCorner
	var size : Chip.ChipSize
	@Binding var selectedIndex : Int
	
	init(label: String, index: Int, segments: Int, selectedIndex: Binding<Int>, size: Chip.ChipSize) {
		self.label = label
		self.index = index
		self.segments = segments
		self.size = size
		self._selectedIndex = selectedIndex
		
		
		if index == 0 {
			location = .first
		} else if index == segments - 1 {
			location = .end
		} else {
			location = .middle
		}
		
		switch location {
		case .first:
			corners = [.topLeft, .bottomLeft]
		case .end:
			corners = [.topRight, .bottomRight]
		case .middle:
			corners = .allCorners
		}
		if segments == 1 {
			corners = .allCorners
		}
		
	}
	
	public var body: some View {
		ZStack {
			Rectangle()
				.fill(index == selectedIndex ? Color.navy800 : Color.white)
				.borderRadius(index == selectedIndex ? Color.navy800 : Color.gray300, width: 1, cornerRadius: location == .middle ? 0 : 8, corners: corners)
				.overlay(
					Text(label)
                        .typography(size.textSize, weight: .semibold, color: index == selectedIndex ? Color.white : Color.gray500)
				)
				.onTapGesture {
					selectedIndex = index
				}
		}
	}
}


extension View {
	public func borderRadius<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat, corners: UIRectCorner) -> some View where S : ShapeStyle {
		let roundedRect = RoundedCorner(radius: cornerRadius, corners: corners)
		return clipShape(roundedRect)
			.overlay(roundedRect.stroke(content, lineWidth: width))
	}
}

struct Chip_Previews: PreviewProvider {
    static var previews: some View {
		VStack {
			Chip(segments: 2, selectedIndex: .constant(0), labelArray: ["test","test"])
			Chip(segments: 3, selectedIndex: .constant(1), labelArray: ["test","test","test"])
			Chip(segments: 4, selectedIndex: .constant(3), labelArray: ["test","test","test","test","test"], size: .small)
		}
		.padding(.horizontal)
    }
}
