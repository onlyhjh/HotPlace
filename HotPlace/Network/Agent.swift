//
//  Agent.swift
//  pluto
//
//  Created by 부리부리황 on 2022/08/24.
//

import Foundation
import Combine
import Alamofire

// 1. Error 타입 정의
enum APIError: Error {
    case badUrl
    case decodingError
    case noData
    case serverError
    case decodeError
    case badServerResponse
    case networkConnectionError
    case sessionError
    case headerMessage(_ msg: HeaderMessage, _ errorCode:String)
    case http(ErrorData)
    case unknown
}

struct HeaderMessage: Equatable {
    var addMsg: String?
    var fixedLengthVo: Bool?
    var msgId: String?
    var msgText: String?
    var msgType: String?
    var userMsg: String?
}
 
// 2. ErrorData 안에 들어갈 정보 선언
struct ErrorData: Codable {
    var code: Int
    var message: String
}
 
// 4. Resonse 선언
struct Response<T> {
    let value: T
    let response: URLResponse
}


struct Agent {
    func getPublisher<T: Decodable>(_ request: DataRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, APIError> {
        return request.validate().publishData(emptyResponseCodes: [200, 204, 205])
            .tryMap { result -> Response<T> in
                
                if let error = result.error {
                    // Http 응답으로 406 에러코드가 들어온 경우 response로 처리
                    if error.responseCode == 406, let data = result.data {
                        //let str = String(bytes: data, encoding: .utf8)
                        let value = try decoder.decode(T.self, from: data)
                        return Response(value: value, response: result.response!)
                    }
                     
                    // 서버의 오류인 경우 상세 내용 전달
                    if let errorData = result.data {
                        let value = try decoder.decode(ErrorData.self, from: errorData)
                        throw APIError.http(value)
                    }
                    // 서버의 오류가 아닌경우
                    else {
                        throw error
                    }
                }
                
                // Http 응답이 200으로 정상인 경우
                if let data = result.data {
//                    let encoding = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(0x0422))
//                    let str = String(data: data, encoding: encoding) ?? ""
//                // 응답이 성공이고 result가 있을 때
//                    //let str = String(decoding:data, as: .utf8)
//                    //Logger.log("* 응답이 성공이고 result가 있을 때 : \(str)" )
                    
                    // userInit인 경우만 웹뷰에 세션값 전달해야함
//                    if let url = result.request?.url, url.absoluteString.contains(ApiClient.ApiUrl.userInit) {
//                        if let headerFields = result.response?.allHeaderFields as? [String: String], headerFields.count > 0 {
//                                Logger.log("..... response headerFields \(headerFields)")
//                                AppConstants.sharedCookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: url)
//                            }
//                    }
                    
//                    if let cookieDict = result.response?.allHeaderFields as? [String: AnyObject] {
//                        PreferenceDataManager.setWebCookies(cookieDict: cookieDict)
//                        Logger.log("* cookieDict: \(cookieDict)")
//                    }
                    
                    let value = try decoder.decode(T.self, from: data)
                    return Response(value: value, response: result.response!)
                }
                else {
                    // 응답이 성공이고 result가 없을 때 Empty를 리턴
                    Logger.log("* 응답이 성공이고 result가 없을 때 Empty를 리턴")
                    return Response(value: Empty.emptyValue() as! T, response: result.response!)
                }
            }
            .mapError { (error) -> APIError in
                if let apiError = error as? APIError {
                    return apiError
                } else {
                    return .unknown
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
