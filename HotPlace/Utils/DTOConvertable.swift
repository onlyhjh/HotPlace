//
//  DTOConvertable.swift
//  IOS_CleanArchitecture_Sample
//
//  Created by 60029474 on 2022/04/28.
//

/**
   DTO 데이터를 Entity 데이터로 변환하기 위한 프로토콜 형
 */
protocol DTOConvertable {
    associatedtype DataTransferObject
    static func convert(from dto:DataTransferObject)->Self
}

