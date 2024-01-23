//
//  PostDetailView.swift
//  ConexaProjectInterview
//
//  Created by Juan Bazan Carrizo on 26/12/2023.
//

import SwiftUI

struct PostDetailView: View {
    // MARK: - PROPERTIES
    @State private var isAnimatingImage = false
    let post: PostModel
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 20) {
                    /// BANNER
                    ZStack {
                        if !isAnimatingImage {
                            Rectangle()
                                .fill(Color.gray.opacity(isAnimatingImage ? 0 : 1))
                                .frame(height: 200)
                        }
                        AsyncImage(url: URL(string: post.image)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(isAnimatingImage ? 1.0 : 0.9)
                                .opacity(isAnimatingImage ? 1 : 0.5)
                                .onAppear {
                                    withAnimation(.easeOut(duration: 0.5)) {
                                        isAnimatingImage = true
                                    }
                                }
                            
                        } placeholder: {
                            EmptyView()
                        }
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 8) {
                        /// TITLE
                        Text(post.title.uppercased())
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.primary)
                        
                        /// Dates
                        GroupBox {
                            DisclosureGroup("Dates") {
                                VStack {
                                    Divider()
                                    HStack {
                                        Group {
                                            Image(systemName: "timer")
                                            Text("Published at: ")
                                        }
                                        .font(.system(.body).bold())
                                        
                                        Spacer()
                                        Text(post.publishedAt)
                                            .font(.system(.body))
                                            .multilineTextAlignment(.trailing)
                                    }
                                    
                                    Divider()
                                    HStack {
                                        Group {
                                            Image(systemName: "clock.arrow.2.circlepath")
                                            Text("Updated at: ")
                                        }
                                        .font(.system(.body).bold())
                                        
                                        Spacer()
                                        Text(post.updatedAt)
                                            .font(.system(.body))
                                            .multilineTextAlignment(.trailing)
                                    }
                                }
                            }
                            .font(.system(.title3).bold())
                        } //: GroupBox
                        
                        /// DESCRIPTION
                        Text(post.content)
                            .font(.system(size: 14))
                            .multilineTextAlignment(.leading)
                            .layoutPriority(1)
                    } //: VStack
                    .padding(.horizontal)
                } //: VStack
                
            } //: ScrollView
            .edgesIgnoringSafeArea(.top)
        } //: NavigationView
        .navigationViewStyle(.stack)
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(post: Mock.post)
    }
}
