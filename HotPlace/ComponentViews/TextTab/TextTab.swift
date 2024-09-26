//
//  TextTab.swift
//  gma_presentation
//
//  Created by 60156664 on 23/06/2022.
//

import SwiftUI

/**
 A component that provides a textual horizontal list of tab-selectable lists by the user.
 - Author: Shinhan Bank
*/
public struct TextTab: View {
    @Binding var items: [String]
    @Binding var selectedIndex: Int
    @State var isMoving: Bool = true
    private var animationDuration: CGFloat = 0.3

    private var onSelectedTab: (Int)->() = {_ in }
    private var textColor: Color = .gray500
    private var selectedTextColor: Color = .white
    private var widthLastItem: CGFloat = 0

    private let fontSize: CGFloat = 16
    private let tabHorizontalPadding: CGFloat = 20
    private let horizontalTextPadding: CGFloat = 16
    private let tabSpacing: CGFloat = 8

	/**
	 A component that provides a textual horizontal list of tab-selectable lists by the user.
	 - Parameters:
	   - items: Text Lists.
	   - selectedIndex: Index of the list selected by the user.
	   - isScrolling: Is scrollable. f true: possible, false: impossible.
	*/
    public init(items:Binding<[String]>,
                selectedIndex: Binding<Int>) {
        self._items = items
        self._selectedIndex = selectedIndex
        self.widthLastItem = getWidthLastItem()
    }

	/**
	 A component that provides a textual horizontal list of tab-selectable lists by the user.
	 - Parameters:
	   - items: Text Lists.
	   - selectedIndex: Index of the list selected by the user.
	   - isScrolling: Is scrollable. f true: possible, false: impossible.
	   - onSelectedTab: Action when tapping.
	*/
    public init(items: Binding <[String]>,
                selectedIndex: Binding<Int>,
                onSelectedTab: @escaping (Int)->() = {_ in }) {
        self._items = items
        self._selectedIndex = selectedIndex
        self.onSelectedTab = onSelectedTab
        self.widthLastItem = getWidthLastItem()
    }
    
	/**
	 A component that provides a textual horizontal list of tab-selectable lists by the user.
	 - Parameters:
	   - items: Text Lists.
	   - selectedIndex: Index of the list selected by the user.
	   - isScrolling: Is scrollable. f true: possible, false: impossible.
	   - onSelectedTab: Action when tapping.
	   - textColor: Defualt Text Color.
	   - selectedTextColor: The text color of the selected text.
	*/
    public init(items: Binding<[String]>,
                textColor: Color = .gray400,
                selectedTextColor: Color = .gray900,
                selectedIndex: Binding<Int>,
                onSelectedTab: @escaping (Int)->() = {_ in }) {
        self._items = items
        self.textColor = textColor
        self.selectedTextColor = selectedTextColor
        self._selectedIndex = selectedIndex
        self.onSelectedTab = onSelectedTab
        self.widthLastItem = getWidthLastItem()

    }
    
    public var body: some View {
        ZStack(alignment: .trailing) {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [GridItem()], spacing: tabSpacing) {
                        ForEach(0..<items.count, id: \.self) { index in
                            VStack {
                                Spacer()
                                Text(items[index])
                                    .typography(fontSize, weight: index == selectedIndex ? .heavy : .semibold, color: index == selectedIndex ? selectedTextColor : textColor)
                                Spacer()
                            }
                            .id(index)
                            .onTapGesture {
                                if selectedIndex != index {
                                    selectedIndex = index
                                    onSelectedTab(index)
                                }
                            }
                            .padding(.horizontal, horizontalTextPadding)
                            .frame(height: 34)
                            .background(index == selectedIndex ? Color.blue700 : Color.white)
                            .cornerRadius(30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(index == selectedIndex ? .blue700 : Color.gray300, lineWidth: 1)
                            )
                            .padding(.leading, index == 0 ? tabHorizontalPadding : 0)
                        }
                        Spacer().frame(width: tabHorizontalPadding)
                            .id(items.count)
                    }
                    .frame(height: 36, alignment: .leading)
                    .onAppear {
                        DispatchQueue.main.async {
                            proxy.scrollTo(selectedIndex, anchor: UnitPoint.init(x: 20/UIScreen.main.bounds.width, y: 0))
                        }
                    }
                    .onChange(of: selectedIndex, perform: { newValue in
                        if #available(iOS 15.0, *) {
                            withAnimation(.easeIn(duration: animationDuration), {
                                scrollToIndex(index: newValue, proxy: proxy)
                            })
                        } else {
                            if isMoving {
                                withAnimation(.easeIn(duration: animationDuration), {
                                    isMoving = false
                                    scrollToIndex(index: newValue, proxy: proxy)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration, execute: {
                                        isMoving = true
                                    })
                                })
                                
                            } else {
                                scrollToIndex(index: newValue, proxy: proxy)
                            }
                        }
                    })
                }
            }
        }
    }
    
    func scrollToIndex(index: Int, proxy: ScrollViewProxy) {
        var value = index
        var anchor = UnitPoint.init(x: tabHorizontalPadding / (UIScreen.main.bounds.width - self.getWidth(string: items[index])) , y: 0)
        if checkNeedToScroll(scrollIndex: index) == false {
            value = items.count
            anchor =  UnitPoint.init(x: 1, y: 0)
        }
        proxy.scrollTo(value, anchor: anchor)
    }
    
    func getWidth(string: String) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize, weight: .heavy)
        return string.size(OfFont: font).width + horizontalTextPadding * 2 /* padding */
    }
    
    private func getWidthLastItem() -> CGFloat {
        guard let lastItemString = $items.wrappedValue.last else {
            return 0
        }
        return getWidth(string: lastItemString)
    }
    
    private func checkNeedToScroll(scrollIndex: Int) -> Bool {
        var remainWidth: CGFloat = tabHorizontalPadding * 2
        for (index, item) in items.enumerated() {
            if index >= scrollIndex {
                remainWidth += getWidth(string: item)
                if index != items.count - 1 {
                    remainWidth += tabSpacing
                }
            }
        }
        
        return remainWidth >= UIScreen.main.bounds.width
    }
}

struct TextTab_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TextTab(items: .constant(["Label 1", "To sdsds3 d bank 2", "To internal bank 3", "Label 4", "Label 5", "Label 6", "Label 7"]), selectedIndex: .constant(2))
            
            TextTab(items: .constant(["Accounts", "To internal bank", "Product Center"]), selectedIndex: .constant(1), onSelectedTab: { index in
                // selected index
            })
            
            TextTab(items: .constant(["Accounts", "To internal bank", "Product Center"]), textColor: .yellow, selectedTextColor: .red, selectedIndex: .constant(0))
        }
    }
}

fileprivate extension String {
    func size(OfFont font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
    }
}
