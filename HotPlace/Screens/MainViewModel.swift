//
//  MainViewModel.swift
//  HotPlace
//
//  Created by 60192229 on 7/30/24.
//

import Foundation


enum FullScreenCoverType {
    case web
    case photo
}

class MainViewModel: ObservableObject {

    
    @Published var appScreenState: AppScreenState = .launching
    @Published var sheetState: SheetState? = nil
    @Published var isShowPhotoPicker = false
    @Published var isShowFullScreenCover = false
    
    var fullScreenCoverType: FullScreenCoverType = .web
    var webUrlStr: String = ""
    let cancelBag = CancelBag()
    
    func requestLaunch(successCompletion: @escaping () -> Void, failureCompletion: @escaping () -> Void) {
        var isSuccess = false
        AppEnvironmentSingleton.shared.appContainer.loadingVM.isPresented = true
        
        Logger.log("")
        ApiUseCases().launch()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                let alert = AppEnvironmentSingleton.shared.appContainer.alertVM
                switch completion {
                case .failure(let error):
                    switch error {
                    case .http(let errorData):
                        Logger.log("..... failure > http error code: \(errorData.code), message: \(errorData.message)")
                        alert.description = "\(errorData.message)\n#(\(errorData.code)"
                    case .badUrl:
                        Logger.log("..... failure > badUrl error")
                        alert.description = "badUrl error"
                    case .headerMessage(let headMessage, let errorCode):
                        Logger.log("..... failure > badUrl error code: \(errorCode), message: \(headMessage)")
                        alert.description = "\(headMessage)\n#(\(errorCode)"
                    case .unknown:
                        Logger.log("..... failure > unkonwn error")
                        alert.description = "unkonwn error"
                    default:
                        Logger.log("..... failure > unkonwn error")
                        alert.description = "unkonwn error"
                    }
                case .finished:
                    Logger.log("..... finished!! isSuccess:\(isSuccess)")
                }
                //  finish이후에 action
                if isSuccess {
                    successCompletion()
                }
                else {
                    DispatchQueue.main.async {
                        alert.resetModel()
                        alert.imageType = .warning
                        alert.title = "안내"
                        alert.button1Title = "확인"
                        alert.button1Action = failureCompletion
                        alert.isPresented = true
                    }
                }
                
                AppEnvironmentSingleton.shared.appContainer.loadingVM.isPresented = false
            }, receiveValue: { data in
                Logger.log(data?.appLatestVer)
                isSuccess = true
            })
            .store(in: self.cancelBag)
    }
}
