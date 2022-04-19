//
//  NewsView.swift
//  HackerNewsApp
//
//  Created by John Hur on 2022/04/18.
//

import SwiftUI

struct Story: View {
    let position: Int
    let title: String
    let footnote: String
    let score: String
    let commentCount: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16.0) {
            Position(position: position)
            VStack(alignment: .leading, spacing: 8.0) {
                Text(title)
                    .font(.headline)
                Text(footnote)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                    Badge(text: score, imageName: "arrowtriangle.up.circle")
                        .foregroundColor(.blue)
                    Badge(text: commentCount, imageName: "ellipses.bubble")
                        .padding(.leading,96.0)
                        .foregroundColor(.orange)
                }
                .font(.callout)
                .padding(.bottom)
            }
        }
        .padding(.top, 16.0)
    }
}

extension Story {
    init(position: Int, item: Item) {
        self.position = position
        title = item.title
        score = "\(item.score)"
        commentCount = "\(item.commentCount)"
        footnote = "\(item.url)"
            + " - \(item.date.timeIntervalSince1970)"
            + " - by \(item.author)"
    }
}



// 뱃지
struct Badge: View {
    let text: String
    let imageName: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
            Text(text)
        }
    }
}

// 위치 뷰
struct Position: View {
    let position: Int
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 32.0, height: 32.0)
                .foregroundColor(.blue)
            Text("\(position)")
                .font(.callout)
                .bold()
                .foregroundColor(.white)
        }
    }
}

struct NewsView: View {
//    let stories: [Item]
    @StateObject private var model = NewsViewModel()
    
    var body: some View {
        List(model.stories.indices) { index in
            if let story = model.stories[index] {
                Story(position: index + 1, item: story)
            }
            
        }
        .navigationTitle("News")
        .onAppear(perform: model.fetchTopStories)
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewsView()
            Group {
                Story(position: 1, item: TestData.story)
                Position(position: 1)
                Badge(text: "1.234", imageName: "paperplane")
            }
            .previewLayout(.sizeThatFits)

        }
    }
}

