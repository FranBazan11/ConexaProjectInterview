//
//  PostListItemView.swift
//  ConexaProjectInterview
//
//  Created by Juan Bazan Carrizo on 24/12/2023.
//

import SwiftUI

struct PostListItemView: View {
    
    // MARK: - PROPERTIES
    let post: PostModel
    
    @Binding var searchText: String
    
    // MARK: - BODY
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: URL(string: post.thumbnail)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 70, height: 70)
            .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(highlightedText(for: post.title))
                    .font(.system(size: 15, weight: .medium))
                    .fontWeight(.heavy)
                Text(highlightedText(for: post.content))
                    .font(.system(size: 12))
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
            }
        }
    }
    
    private func ranges(of substring: String, in string: AttributedString) -> [Range<AttributedString.Index>] {
        var ranges = [Range<AttributedString.Index>]()
        var start = string.startIndex
        while let range = string[start...].range(of: substring) {
            ranges.append(range)
            start = range.upperBound
        }
        return ranges
    }

    private func highlightedText(for string: String) -> AttributedString {
        var attributedString = AttributedString(string)
        
    
        let highlightColor = UIColor(Color("ColorHighlight"))
        
        for range in ranges(of: searchText, in: attributedString) {
            attributedString[range].backgroundColor = highlightColor
        }
        
        return attributedString
    }
}

struct PostListItemView_Previews: PreviewProvider {
    @State private static var searchText = "adipiscing elit"
    static var previews: some View {
        PostListItemView(post: Mock.post, searchText: $searchText)
            .padding()
    }
}
