//
//  PermissionView.swift
//  HotPlace
//
//  Created by 60192229 on 7/30/24.
//

import SwiftUI

struct PermissionView: View {
    public static let id = String(describing: Self.self)
    
    @StateObject var vm: PermissionViewModel = PermissionViewModel()

    var completion: () -> Void = {}
    
    var body: some View {
        VStack(spacing: 0) {
            Text("test")
                .typography(.heading1, weight: .heavy, color: .gray900)
                .padding(.top, 16)
                .padding(.bottom, 32)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("test222")
                            .typography(.heading4, weight: .heavy, color: .gray900)
                        Spacer().frame(height: 12)
                        Text("test333")
                            .typography(.body2, weight: .regular, color: .gray700)
                    }
                    Spacer().frame(height: 16)
                    
                    HStack(alignment: .top, spacing: 16) {
                        Image("Icon_filled_40_rightcamera")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("test444")
                                .typography(13, weight: .heavy, color: .gray700)
                            
                            Text("test55")
                                .typography(13, weight: .regular, color: .gray700)
                                .minimumScaleFactor(0.01)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 20)
                    .background(Color.gray200)
                    .cornerRadius(16)
                    Spacer().frame(height: 10)
                    
                    HStack(alignment: .top, spacing: 4) {
                        Text("※")
                            .typography(12, weight: .regular, color: .gray700)
                        Text("test666")
                            .typography(13, weight: .regular, color: .gray700)
                    }
                    Spacer()
                    
                    
                }
                .padding(.horizontal, 20)
            }
            
            CTAButton(type: .basic, config: OneButtonConfig(text: "test777", colorType: .primary, backgroundType: .filled, action: {
                // Add action here
                vm.requestAllPermission {
                    // move to next screen
                     completion()
                }
            }))
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    PermissionView()
}
