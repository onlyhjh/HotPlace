//
//  Logger.swift
//  HotPlace
//
//  Created by 60192229 on 7/30/24.
//

import Foundation

class Logger {
    public
    enum  enumLogEventType: String{
        case error  = "‼️ " // 오류발생시 출력
        case info   = "ℹ️ " // 정보형 출력
        case trace  = "💬 " // 일반 trace 로그
        case hot    = "🔥 " // 중요한 로그를 확인할때 이용
    }
    
    public
    class func log(_ message: String?, logType: enumLogEventType = .trace,
                   fileName: String = #file,
                   line: Int = #line,
                   funcName: String = #function) {
        
#if DEBUG
        print("\(logType.rawValue)[\(sourceFileName(filePath: fileName))]:\(line) \(funcName) -> \(message ?? "")")
#endif
    }
    
    private
    class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}
