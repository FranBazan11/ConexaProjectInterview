//
//  UserViewModel.swift
//  ConexaProjectInterview
//
//  Created by Juan Bazan Carrizo on 30/12/2023.
//

import Foundation

class UserViewModel: ObservableObject {
    // MARK: - PROPERTIES
    @Published var users = [UserModel]() {
        didSet {
            usersDidUpdate?()
        }
    }
    var usersDidUpdate: (() -> Void)?
    
    @Published var modalId: Int? = nil
    
    private let httpClient: HttpClientProtocol
    
    // MARK: - INIT
    init(httpClient: HttpClientProtocol = HttpClient.shared) {
        self.httpClient = httpClient
    }
    
    // MARK: - FUNCS
    func fetchUsers() async {
        do {
            let urlString = Constants.baseURL + Endpoints.users
            
            let url = URL(string: urlString)
            
            let usersResponse: [UserModel] = try await httpClient.fetch(url: url)
            
            DispatchQueue.main.async {
                self.users = usersResponse
            }
        } catch {
            print("❌ \(error)")
        }
    }
}

extension Int: Identifiable {
    public var id: Self { self }
}
