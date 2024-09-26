//
//  InfoSheetViewModel.swift
//  IOS_CleanArchitecture_Sample
//
//  Created by 60029474 on 2022/06/10.
//

import Foundation
import SwiftUI

/**
 InfoSheet 화면의 타이틀, 본문, 아이콘, 클릭 액션을 지정하는 ViewModel
 */
public
class InfoSheetViewModel: ObservableObject {
	
	// MARK: - Type Defines
    public typealias function = () -> Void
	
	/// 아이콘 유형
    public 
	enum ImageType {
		case info
		case warning
		case error
		case success
        case faceId
        case touchId

		var name: String {
			switch self {
			case .info:
				return "image_alret_informative"
			case .warning:
				return "image_alret_notice"
			case .error:
				return "image_alret_negative"
			case .success:
				return "image_alret_positive"
            case .faceId:
                return "image_alret_faceID"
            case .touchId:
                return "image_alret_finger"
			}
		}
        
        public
        var alertType: AlertType {
            switch self {
            case .info:
                return .information
            case .warning:
                return .warning
            case .error:
                return .error
            case .success:
                return .success
            case .faceId:
                return .faceId
            case .touchId:
                return .touchId

            }
        }
	}
	
	// MARK: - Variables
	// bottom sheet와 결합할때 플래그로 이요
	@Published public var isPresented: Bool = false {
		willSet {
			if newValue == true {
				// InfoSheet 나오는 경우 Keyboard Hide
				hideKeyboard()
			}
		}
	}
    @Published public var imageType: ImageType? = .none
	@Published public var title: String?
	@Published public var description: String
    @Published public var caption: String?
    @Published public var captionBold: Bool = false
    @Published public var textAlignment: TextAlignment?

	@Published public var button1Title: String?
	@Published public var button2Title: String?
    @Published public var hasCloseButton: Bool = false
	
	@Published public var image: Image?
	@Published public var right_image: Bool = false

	/// do action
	@Published public var button1Action: function?
    @Published public var button2Action: function?

	/// do close action - button x
	@Published public var closeAction: function?
	
	// MARK: - Default button title
	// TODO: - Label 지정
	// 기본값, 확인버튼
	private let defaultbutton1Title = "Confirm"
	
	// TODO: - Label 지정
	// 기본값, 확인버튼
	private let defaultbutton2Title = "I'll do it next time"
	
	// MARK: - Constructor
    public
    init() {
        self.imageType = .none
		self.title = nil
		self.description = ""
        self.caption = caption
        self.captionBold = false
        self.button1Title = nil
		self.button2Title = nil
		self.button1Action = nil
		self.button2Action = nil
        self.closeAction = nil
        self.hasCloseButton = false
	}
	
    public
    init(type: ImageType? = .none,
		 title: String? = nil,
		 description: String,
         caption: String? = nil,
         captionBold: Bool = false,
         hasCloseButton: Bool = false,
		 button1Title: String? = nil,
		 button2Title: String? = nil,
         button1Action: (() -> Void)? = nil,
         button2Action: (() -> Void)? = nil,
         closeAction:  (() -> Void)? = nil) {
		self.imageType = type
		self.title = title
		self.description  = description
        self.caption = caption
        self.captionBold = captionBold
        self.hasCloseButton = hasCloseButton
		// titles
		self.button1Title = button1Title
		self.button2Title = button2Title
		self.button1Action = button1Action
		self.button2Action = button2Action
        self.closeAction = closeAction
	}
    
    public
    init(type: ImageType? = .none,
         title: String? = nil,
         description: String,
         caption: String? = nil,
         captionBold: Bool = false,
         hasCloseButton: Bool = false,
         buttonTitle: String? = nil,
         buttonAction: (() -> Void)? = nil,
         closeAction: (() -> Void)? = nil) {
        Logger.log("")
        self.imageType = type
        self.title = title
        self.description  = description
        self.caption = caption
        self.captionBold = captionBold
        self.hasCloseButton = hasCloseButton
        // titles
        self.button1Title = buttonTitle
        self.button1Action = buttonAction
        self.closeAction = closeAction
    }
    

	public
	init(right_image: Bool = true,
		 title: String = "",
		 description: String = "",
		 image: Image,
		 button1Title: String,
		 button1Action: @escaping (() -> Void),
		 button2Title: String? = nil,
		 button2Action: (() -> Void)? = nil) {
		Logger.log("")
		self.right_image = true
		self.hasCloseButton = false
		self.title = title
		self.description = description
		self.caption = ""
		self.image = image
		self.button1Title = button1Title
		self.button1Action = button1Action
		self.button2Title = button2Title
		self.button2Action = button2Action
		self.closeAction = nil
	}
	
    public
    func resetModel() {
        self.imageType = .none
        self.title = nil
        self.description = ""
        self.caption = nil
        self.button1Title = nil
        self.button2Title = nil
        self.button1Action = nil
        self.button2Action = nil
        self.closeAction = nil
        self.hasCloseButton = false
    }
}
