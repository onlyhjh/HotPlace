//
//  ApiUseCases.swift
//  pluto
//
//  Created by 부리부리황 on 2022/08/24.
//

import Foundation
import Combine
import EventKit
import Alamofire

class ApiUseCases {
    
    let agent = Agent()
    let headers = HTTPHeaders(["Accept":"application/json", "Content-Type":"application/json", "Device-Type":"DEVICE_TYPE_IOS", "X-AUTH-TOKEN":""])
    let ntiuspHeaders = HTTPHeaders(["Accept":"text/json", "Content-Type":"text/json", "Device-Type":"DEVICE_TYPE_IOS", "X-AUTH-TOKEN":""])
}

extension ApiUseCases: LaunchUseCaseProtocol {
    
    func launch() -> AnyPublisher<ApiResponses.Launch?, APIError> {
        guard let url = ServerConstants.pathURL(path: .appLaunch) else {
            return Fail<ApiResponses.Launch?, APIError>(error: .badUrl).eraseToAnyPublisher()
        }
        Logger.log("..... url: \(url)")

        let parameters: Parameters
        let request = AF.request(url, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers)
        
        return agent.getPublisher(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }

    
        /*
    static func authBioCreateRegis(deviceId: String, os: String, regisWayCd: String, authTypeCd: String) -> AnyPublisher<ApiResponses.AuthBioCreateRegis, APIError> {
        let parameters: [String: Any] = [
            ApiRequestParameters.AuthBioCreateRegis.deviceId: deviceId,
            ApiRequestParameters.AuthBioCreateRegis.os: os,
            ApiRequestParameters.AuthBioCreateRegis.regisWayCd: regisWayCd,
            ApiRequestParameters.AuthBioCreateRegis.authTypeCd: authTypeCd
        ]
        
        let url = URL(string: ApiUrl.base + ApiUrl.authBioCreateRegis)!
        Logger.log("..... url: \(url)")
        Logger.log("..... paramters: \(parameters)")
        
        if let cookies = AppConstants.sharedCookies {
            Logger.log("..... set Alamofire cookies: \(cookies)")
            for c in cookies {
                AF.session.configuration.httpCookieStorage?.setCookie(c)
            }
        }
        
        let request = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: self.headers)

        return agent.getPublisher(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
         */
}
