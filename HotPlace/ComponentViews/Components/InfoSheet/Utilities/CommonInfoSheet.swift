//
//  CommonInfoSheet.swift
//  IOS_CleanArchitecture_Sample
//
//  Created by Su Jin Kim on 2022/06/20.
//

import Foundation

public
protocol CommonInfoSheet {
	/// singlton environment 에 저장된 환경 객체
	var commonInfoSheet: InfoSheetViewModel? {get}
	/// 오류 수행, 파라미터는 resVo에서 변환된 entity
    func doCommonError(msg: CommonInfoSheetMessage, errorCode: String)
	// MARK: - you must implements
	///  custom 메시지가 도착하면 출력할 코드 호출을 구현. Server 오류 처리
    func doCustomInfoSheet(msg: CommonInfoSheetMessage, errorCode: String)
    func doCommonError(msg: String, errorCode: String)
    func doCommonError(msg: String, type: String, errorCode: String)
}

public 
extension CommonInfoSheet {
    func doCommonError(msg: String, type: String, errorCode: String) {
        doCommonError(msg: CommonInfoSheetMessage(msgText: msg, msgType: type), errorCode: errorCode)
    }
    
	func doCommonError(msg: String, errorCode: String) {
		doCommonError(msg: CommonInfoSheetMessage(msgText: msg, msgType: errorCode), errorCode: errorCode)
	}
	
	// API 공통 오류 창 처리 함수
    func doCommonError(msg: CommonInfoSheetMessage, errorCode: String){
		DispatchQueue.main.async {
			// 초기화
			self.commonInfoSheet?.resetModel()
			
			self.commonInfoSheet?.title  = nil
			self.commonInfoSheet?.description = (msg.msgText ?? "" ) + " " + errorCode
			//  I, M, E, W, C
			switch msg.msgType {
			case "I":
				self.commonInfoSheet?.imageType = .info
				self.commonInfoSheet?.isPresented = true // 청색 계열 느낌표 아이콘
				self.commonInfoSheet?.button1Title = "Login"
                self.commonInfoSheet?.button1Action = {
                    // 로그아웃을 수행한후 로그인
                    // TODO: - 로그아웃을 수행하고 로그인
//                    RouteUtility.showLogin(shouldLogout: true) { bLoginSuccess in
//                        Logger.log("\(bLoginSuccess)")
//                    }
                }
			case "M":
				self.commonInfoSheet?.imageType = .info  // 청색 계열 느낌표 아이콘
				self.commonInfoSheet?.isPresented = true
				self.commonInfoSheet?.button1Title = "Home"
//				RouteUtility.moveToHome()
				
			case "E", "W":
				self.commonInfoSheet?.imageType = .warning // 노란색 느낌표 아이콘
				self.commonInfoSheet?.button1Title = "Confirm"
				self.commonInfoSheet?.isPresented = true
			case "C":
				doCustomInfoSheet(msg: msg, errorCode: errorCode)
			default:
				()
			}
		}
	}
	
}
