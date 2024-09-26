//
//  TextSwitch.swift
//  gma_common
//
//  Created by 60156664 on 19/10/2023.
//

import SwiftUI

public struct TextSwitch: View {
    @Binding var selectedIndex: Int
    var items: [String] = []
    var didSelected: (_ index: Int) -> Void = { _ in }
    
    @State var widthList: [CGFloat] = []

    private var switchHeight: CGFloat = 42.0
    public init(selectedIndex: Binding<Int>,
                items: [String] = [],
                didSelected: @escaping (_ index: Int) -> Void = {_ in}){
        self._selectedIndex = selectedIndex
        self.items = items
        self.didSelected = didSelected
    }
    
    func getWidthOfShape() -> CGFloat {
        if items.count - 1 >= selectedIndex {
            return items[selectedIndex].widthOfString(usingFont: .systemFont(ofSize: 17, weight: .bold)) + 12 * 2
        }
        
        return 0
    }
    
    
    func getOffsetOfShape() -> CGFloat {
        var offset: CGFloat = 0
        for index in 0..<items.count {
            if selectedIndex > index {
                offset += items[index].widthOfString(usingFont: .systemFont(ofSize: 17, weight: .bold)) + 12 * 2
            }
        }
        
        return offset

    }
    
    public var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: getWidthOfShape(), height: 34)
                .shadow(color: Color(red: 0.09, green: 0.15, blue: 0.26).opacity(0.08), radius: 3, x: 0, y: 2)
                .offset(x: getOffsetOfShape() )

            HStack(alignment: .center, spacing: 0) {
                
                ForEach(0..<items.count, id: \.self) { index in
                    let item = items[index]
                    Button(action: {
                        withAnimation {
                            selectedIndex = index
                        }
                        didSelected(index)
                    }, label: {
                        Group {
                            TextSwitchTab(isSelected: index == selectedIndex, text: item)
                        }
                    })
                    .basicStyle()
                }
            }
        }
        .padding(.horizontal, 4)
        .frame(height: switchHeight)
        .background(Color.init(hex: "E7EBEE"))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black.opacity(0.01), lineWidth: 4)
                .shadow(color: Color.black.opacity(0.08),
                        radius: 2, x: 0, y: 2)
        )
        .cornerRadius(20)
    }
     
    struct TextSwitchTab : View {
        var isSelected: Bool = false
        var text: String
        
        var body: some View {
            HStack {
                Text(text)
                    .typography( 17, weight: isSelected ? .heavy : .regular, color: isSelected ? .blue700 : .gray500)
            }
            .frame(height: 36)
            .padding(.horizontal, 12)
            .overlay(GeometryReader { geo in
                ZStack {
                    Color.clear
                }
            })
        }
    }
    
}

fileprivate extension String {
   func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

struct TextSwitch_Previews: PreviewProvider {
    @State static var index: Int = 1
    static var previews: some View {
        VStack {
            TextSwitch(selectedIndex: $index, items: ["UI", "イージー"])
            TextSwitch(selectedIndex: .constant(0), items: ["UI", "イージー"])
        }
    }
}
