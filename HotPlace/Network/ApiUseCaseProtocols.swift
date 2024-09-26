//
//  ApiUseCaseProtocols.swift
//  HotPlace
//
//  Created by 60192229 on 7/31/24.
//

import Foundation
import Combine

protocol LaunchUseCaseProtocol {
    func launch() -> AnyPublisher<ApiResponses.Launch?, APIError>
}
