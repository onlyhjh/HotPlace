//
//  CommonInfoSheetMessage.swift
//  HotPlace
//
//  Created by 60192229 on 7/30/24.
//

import Foundation
/// 공통 정보창 파라미터 전달을 위한 Entity

public
struct CommonInfoSheetMessage: Equatable {
    public var addMsg: String?
    public var fixedLengthVo: Bool?
    public var msgId: String?
    public var msgText: String?
    public var msgType: String?
    public var userMsg: String?
    
    public init(addMsg: String? = nil, fixedLengthVo: Bool? = nil, msgId: String? = nil, msgText: String? = nil, msgType: String? = nil, userMsg: String? = nil) {
        self.addMsg = addMsg
        self.fixedLengthVo = fixedLengthVo
        self.msgId = msgId
        self.msgText = msgText
        self.msgType = msgType
        self.userMsg = userMsg
    }
}

extension CommonInfoSheetMessage: DTOConvertable {
    public static func convert(from dto: ResMsgVo) -> CommonInfoSheetMessage {
        return CommonInfoSheetMessage(addMsg: dto.addMsg,
                                      fixedLengthVo: dto.fixedLengthVo,
                                      msgId: dto.msgId,
                                      msgText: dto.msgText?.fixServerCRLF(),
                                      msgType: dto.msgType,
                                      userMsg: dto.userMsg)
    }
    
    public typealias DataTransferObject = ResMsgVo
    
}

public
class ResMsgVo: Codable {
    public var addMsg: String?
    public var fixedLengthVo: Bool?
    public var msgId: String?
    public var msgText: String?
    public var msgType: String?
    public var userMsg: String?
}
