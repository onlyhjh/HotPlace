//
//  FeedView.swift
//  HotPlace
//
//  Created by 60192229 on 8/6/24.
//

import SwiftUI

struct FeedView: View {
    
    var feedImages = ["store_default", "store_default", "store_default", "store_default", "store_default"]
    
    var body: some View {
        VStack {
            feedTitleView
            .padding(.horizontal, 10)
            
            feedImageTableView
            
            userActionView
            
            
            
            .padding(.horizontal, 10)
        }
    }
    
    var feedTitleView: some View {
        HStack {
            Image("store_default")
                .resizable()
                .frame(width: 30, height: 30)
                .padding(.trailing, 2)
            Text("Store Name")
                .bold()
            Spacer()
        }
    }
    
    var feedImageTableView: some View {
        TabView {
            ForEach(Array(zip(feedImages.indices, feedImages)), id: \.0) { index, item in
                ZStack {
                    Image(item)
                        .resizable()
                    Text("\(index)")
                        .foregroundColor(.white)
                        .fontStyle(size: 30)
                }
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
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
