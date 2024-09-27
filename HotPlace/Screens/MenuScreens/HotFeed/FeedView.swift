//
//  FeedView.swift
//  HotPlace
//
//  Created by 60192229 on 8/6/24.
//

import SwiftUI

struct FeedView: View {
    
    var feed: HotFeed?
    
    var body: some View {
        VStack {
            feedImageTableView
            userActionView
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
            Text( feed?.description ?? "")
                .padding(.horizontal, 10)
        }
        .padding(.bottom, 20)
    }
    
    var feedImageTableView: some View {
        TabView {
            if let imagePaths = feed?.imagePaths {
                ForEach(Array(zip(imagePaths.indices, imagePaths)), id: \.0) { index, path in
                    ZStack {
                        Image(path)
                            .resizable()
                        Text("\(index)")
                            .foregroundColor(.white)
                            .fontStyle(size: 30)
                    }
                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
        .tabViewStyle(.page(indexDisplayMode: .automatic))
    }
    
    var userActionView: some View {
        HStack {
            Button {
                
            } label: {
                Image(systemName: "swift")
                
            }
            Button {
                
            } label: {
                Image(systemName: "swift")
                
            }
            Button {
                
            } label: {
                Image(systemName: "swift")
                
            }
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "swift")
                
            }
        }
    }
}

#Preview {
    FeedView()
}
