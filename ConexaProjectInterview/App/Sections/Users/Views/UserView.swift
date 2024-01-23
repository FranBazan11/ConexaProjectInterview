//
//  UserView.swift
//  ConexaProjectInterview
//
//  Created by Juan Bazan Carrizo on 30/12/2023.
//

import SwiftUI

struct UserView: View {
    
    // MARK: - PROPERTIES
    @StateObject var viewModel = UserViewModel()
    
    // MARK: - BODY
    var body: some View {
        List(viewModel.users) { user in
            UserListItemView(user: user, modalId: $viewModel.modalId)
        }
        .sheet(item: $viewModel.modalId, content: { id in
            NavigationStack {
                MapUserView(user: viewModel.users[id - 1])
            }
        })
        .onAppear{
            Task {
                await viewModel.fetchUsers()
            }
        }
    }
}

// MARK: - PREVIEW
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
