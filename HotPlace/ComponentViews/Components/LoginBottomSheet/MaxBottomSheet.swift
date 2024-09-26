//
//  LoginBottomSheet.swift
//  IOS_CleanArchitecture_Sample
//
//  Created by Stan Kim on 2022/04/30.
//
/**
 참고 사이트:
 1. Simple Sample
   https://stackoverflow.com/questions/60416712/swiftui-how-to-pass-a-view-as-a-parameter-into-another-view-to-get-bottom-sheet

  2. ExytePopupView
   https://github.com/exyte/PopupView
*/

import SwiftUI

struct MaxBottomSheetModifier<PopupContent:View, Background:View>: ViewModifier {
	// MARK: - 필수 파라미터
	
	/// 보이기 감추기 플래그, binding Bool value
    @Binding var isPresented: Bool
	///  botom이 올라오는 이전의 화면 blur조정
    var blurPoint: CGFloat
	/// 상단 round coner radius
    var cornerRadius: CGFloat
	///
    var bottomSheetRatio: CGFloat
    
    private var dragToDismissThreshold: CGFloat { height * 0.2 }
    private var grayBackgroundOpacity: Double { isPresented ? (0.4 - Double(draggedOffset)/self.height) : 0 }
    
    // TODO: - add parameter
	@State private var dragToDismiss: Bool = false
    @State private var draggedOffset: CGFloat = 0
    @State private var previousDragValue: DragGesture.Value?

    private var contentView: () -> PopupContent
	//.bottom까지 확장할 백그라운드 배경 View (Gradient, Color View
	private var backgroundView: () -> Background

    private var height: CGFloat {
        screenSize.height
    }
    
	
	/// Class reference for capturing a weak reference later in dispatch work holder.
	private var isPresentedRef: ClassReference<Binding<Bool>>?
	/// Show content for lazy loading
	@State private var showContent: Bool = false
	/// Should present the animated part of popup (sliding background)
	@State private var animatedContentIsPresented: Bool = false

	// MARK: - Screen Size Related
    /// The rect and safe area of the hosting controller
    @State private var presenterContentRect: CGRect = .zero
    @State private var presenterSafeArea: EdgeInsets = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    
	/// The rect and safe area of popup content
	@State private var sheetContentRect: CGRect = .zero
	@State private var sheetSafeArea: EdgeInsets = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)


    // MARK: - Drag related
	/// Drag to dismiss gesture state
	@GestureState private var dragState = DragState.inactive

	
	/// The current offset, based on the **presented** property
	private var currentOffset: CGFloat {
		return animatedContentIsPresented ? displayedOffset : hiddenOffset
	}
	
	/// holder for autohiding dispatch work (to be able to cancel it when needed)
	private var dispatchWorkHolder = DispatchWorkHolder()
	
	/// is called on any close action
	var dismissCallback: () -> ()
	
	/// The offset when the popup is displayed
	private var displayedOffset: CGFloat {
		return 0.0
	}
	/// Last position for drag gesture
	@State private var lastDragPosition: CGFloat = 0

	private var screenHeight: CGFloat {
		screenSize.height
	}

	/// The offset when the popup is hidden
	private var hiddenOffset: CGFloat {
		return screenHeight
	}
	
    @State private var isFirstDragging:Bool = false

	
    init(isPresented: Binding<Bool>,
         blurPoint: CGFloat,
         cornerRadius: CGFloat,
         bottomSheetRatio: CGFloat,
         dismissCallback: @escaping () -> () = {},
         @ViewBuilder content: @escaping () -> PopupContent,
		 @ViewBuilder background: @escaping () -> Background
	) {
        self._isPresented = isPresented
        self.blurPoint = blurPoint
        self.cornerRadius = cornerRadius
        self.bottomSheetRatio = bottomSheetRatio
        self.contentView = content
		self.backgroundView = background
		self.dismissCallback = dismissCallback
		self.isPresentedRef = ClassReference(self.$isPresented)

        
    }
    
    func body(content: Content) -> some View {
        main(content: content)
            .onAppear {
                // 나타나기 액션
				//appearAction(sheetPresented: isPresented)
            }
            .valueChanged(value: isPresented) { newValue in
                // isPresented에 따른 감추기, 나타나기 액션 처리
                appearAction(sheetPresented: newValue)
            }
            .valueChanged(value: isFirstDragging) { newValue in
                if newValue {
// TODO: - SwiftUI 전용 hide 방법이 있는지 조사 필요. 없을 경우 UIKit의존
#if canImport(UIKit)
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
#endif
                }
            }

    }
    
    private func main(content: Content) -> some View {
        ZStack {
            content
// TODO: Blur 이팩트 임시로 막음. 향후 교정대상
//                .applyIf(showContent, apply: { view in
//					view.blur(radius: blurPoint)
//                })
                .frameGetter($presenterContentRect, $presenterSafeArea)
        }
        .overlay(
            Group {
                if showContent {
                    sheet()
						.background(fullScreenLightGrayOverlay())
                }
            }
        )
    }
    
	private func appearAction(sheetPresented: Bool) {
		if sheetPresented {
			showContent = true
			DispatchQueue.main.async {
				animatedContentIsPresented = true
			}
		} else {
			animatedContentIsPresented = false
		}
	}
}


fileprivate
extension MaxBottomSheetModifier {
	private enum DragState {
		case inactive
		case dragging(translation: CGSize)

		var translation: CGSize {
			switch self {
			case .inactive:
				return .zero
			case .dragging(let translation):
				return translation
			}
		}

		var isDragging: Bool {
			switch self {
			case .inactive:
				return false
			case .dragging:
				return true
			}
		}
	}
	
	
    func registerDismiss() {
        // if needed, dispatch autohide and cancel previous one
            dispatchWorkHolder.work?.cancel()
            
            // Weak reference to avoid the work item capturing the struct,
            // which would create a retain cycle with the work holder itself.
            
            let block = dismissCallback
            dispatchWorkHolder.work = DispatchWorkItem(block: { [weak isPresentedRef] in
                isPresentedRef?.value.wrappedValue = false
                showContent = false
                block()
            })
        
        // isPresented값이 false로 바뀌면 닫힘
            if !isPresented, let work = dispatchWorkHolder.work {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: work)
            }
    }
    
	/// This is the builder for the sheet content
 func sheet() -> some View {

     // ispresent false값이 설정되면 자동 닫기 수행
	 registerDismiss()

	 let sheet = ZStack {
		 self.contentView()
			 .frameGetter($sheetContentRect, $sheetSafeArea)
	 }
		 .offset(x: 0, y: currentOffset)
		 // TODO: - 애니메이션 파라미터로 받도록 교정대상
		 //.animation(.spring())
		 .animation(.interactiveSpring(response: 0.3))


	 let drag = DragGesture()
		 .updating($dragState) { drag, state, _ in
			 state = .dragging(translation: drag.translation)
             if isFirstDragging == false {
                 DispatchQueue.main.async {
                     isFirstDragging = true
                 }
                 
             }
		 }
		 .onEnded(onDragEnded)

	 return sheet
		 .applyIf(dragToDismiss) {
			 $0.offset(y: dragOffset())
				 .simultaneousGesture(drag)
		 }
	
 }
	
	func dragOffset() -> CGFloat {
		if dragState.translation.height > 0 {
			return dragState.translation.height
		}
		return lastDragPosition
	}

	private func onDragEnded(drag: DragGesture.Value) {
		let reference = sheetContentRect.height / 3
		if drag.translation.height > reference {
			lastDragPosition = drag.translation.height
			withAnimation {
				lastDragPosition = 0
			}
			dismiss()
		}
        
        isFirstDragging = false
	}
	
	private func dismiss() {
		//dispatchWorkHolder.work?.cancel()
		isPresented = false
	}
}

fileprivate
extension MaxBottomSheetModifier {
	
	final class DispatchWorkHolder {
	 var work: DispatchWorkItem?
 }

 private final class ClassReference<T> {
	 var value: T
	 
	 init(_ value: T) {
		 self.value = value
	 }
 }

}

fileprivate
extension MaxBottomSheetModifier {
    @ViewBuilder
    func fullScreenLightGrayOverlay() -> some View {
        Color
            .black
            .opacity(grayBackgroundOpacity)
            .edgesIgnoringSafeArea(.all)
           // .animation(.interactiveSpring())
            //.onTapGesture { self.isPresented = false }
    }
    
    var screenSize: CGSize {
        #if os(iOS) || os(tvOS)
        return UIScreen.main.bounds.size
        #elseif os(watchOS)
        return WKInterfaceDevice.current().screenBounds.size
        #else
        return NSScreen.main?.frame.size ?? .zero
        #endif
    }

}

struct DemoBottomSheetView: View {
    @State var isPresented: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("welcome to bottom sheet")
                Button(action: {
                    self.isPresented.toggle()
                }){
                    Text("Click Me")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .basicStyle()
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)

		.maxBottomSheet(isPresented: $isPresented, content: {
//			LoginScreen()
		}, background: {
//			LoginGradientView()
		})
    }
}

private
extension View {

    @ViewBuilder
    func applyIf<T: View>(_ condition: Bool, apply: (Self) -> T) -> some View {
        if condition {
            apply(self)
        } else {
            self
        }
    }
}


struct MyBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DemoBottomSheetView(isPresented: false)
        }
    }
}
