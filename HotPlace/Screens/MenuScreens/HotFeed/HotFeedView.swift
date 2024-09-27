//
//  HotFeedView.swift
//  HotPlace
//
//  Created by 60192229 on 7/30/24.
//

import SwiftUI

struct HotFeedView: View {
    @ObservedObject var vm = HotFeedViewModel()
    
    let feeds = [
                HotFeed(store: HotStore(name: "Store111", imagePath: "store_default"), title: "my best food 111", imagePaths: ["store_default", "store_default", "store_default"], description: "11111 가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하"),
                 HotFeed(store: HotStore(name: "Store2222", imagePath: "store_default"), title: "my best food 222", imagePaths: ["store_default", "store_default", "store_default"], description: "22222 가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하\n가나다라마바사아자카차타파하")
    ]
    
    var body: some View {
        VStack {
            Spacer()
            if feeds.isEmpty {
                Text("Empty Feed")
            }
            else {
                ScrollView {
                    ForEach(feeds, id: \.title) { feed in
                        StoreTitleView(store: feed.store)
                        .padding(.horizontal, 10)
                        FeedView(feed: feed)
                            .padding(.bottom, 10)
                    }
                }
            }
            
            Spacer()

        }
    }
}

#Preview {
    HotFeedView()
}
