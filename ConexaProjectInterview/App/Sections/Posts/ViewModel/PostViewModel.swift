//
//  PostViewModel.swift
//  ConexaProjectInterview
//
//  Created by Juan Bazan Carrizo on 24/12/2023.
//

import Foundation

class PostViewModel: ObservableObject {
    // MARK: - PROPERTIES
    @Published var posts = [PostModel]() {
        didSet {
            postsDidUpdate?()
        }
    }
    var postsDidUpdate: (() -> Void)?
    private let httpClient: HttpClientProtocol
    
    // MARK: - INIT
    init(httpClient: HttpClientProtocol = HttpClient.shared) {
        self.httpClient = httpClient
    }
    
    // MARK: - FUNCS
    func fetchPosts() async {
        do {
            let urlString = Constants.baseURL + Endpoints.posts
            
            let url = URL(string: urlString)
            
            let postsResponse: [PostModel] = try await httpClient.fetch(url: url)
            
            DispatchQueue.main.async {
                self.posts = postsResponse
            }
        } catch {
            print("❌ \(error)")
        }
    }
}
