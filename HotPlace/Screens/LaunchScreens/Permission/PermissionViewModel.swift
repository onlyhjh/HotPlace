//
//  PermissionViewModel.swift
//  HotPlace
//
//  Created by 60192229 on 7/30/24.
//

import Foundation
import AVFoundation
import AppTrackingTransparency
import Photos

class PermissionViewModel: ObservableObject {
    @Published var permission: Bool = false
    @Published var isCameraPermission:Bool = false

    deinit {
        
    }
    
    init() {
        
    }
    
    func requestAllPermission(completion: @escaping () -> Void) {
        Task {
            await requestAppTracking()
            let _ = await requestCameraPermission()
            completion()
        }
    }
    
    func requestCameraPermission(completion: @escaping (Bool) -> Void) {
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
           // Already Authorized
            completion(true)
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted :Bool) -> Void in
                completion(granted)
            })
        }
    }
    
    func requestCameraPermission() async -> Bool {
        await withCheckedContinuation { continuation in
            requestCameraPermission { grant in
                continuation.resume(returning: grant)
            }
        }
    }
    
    func requestAppTracking() async {
        await withCheckedContinuation { continuation in
            ATTrackingManager.requestTrackingAuthorization { _ in
                continuation.resume()
            }
        }
    }
}
