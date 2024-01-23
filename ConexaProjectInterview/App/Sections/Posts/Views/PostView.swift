//
//  PostView.swift
//  ConexaProjectInterview
//
//  Created by Juan Bazan Carrizo on 24/12/2023.
//

import SwiftUI

struct PostView: View {
    // MARK: - PROPERTIES
    @StateObject var viewModel = PostViewModel()
    @State private var searchText = ""
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack(spacing:10) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .font(.system(.body).bold())
                    TextField("Search...", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                        .onSubmit {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                }
                .padding(.horizontal)
                
                List(viewModel.posts.filter { post in
                    searchText.isEmpty ||
                    post.title.lowercased().contains(searchText.lowercased()) ||
                    post.content.lowercased().contains(searchText.lowercased())
                }) { post in
                    NavigationLink {
                        PostDetailView(post: post)
                    } label: {
                        PostListItemView(post: post, searchText: $searchText)
                    } //: NavigationLink
                } //: List
            } //: VStack
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Posts")
            .onAppear {
                Task {
                    if viewModel.posts.isEmpty {
                        await viewModel.fetchPosts()
                    }
                }
            }
        } //: NavigationView
        .navigationViewStyle(.stack)
    }
}

// MARK: - PREVIEW
struct PostList_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
