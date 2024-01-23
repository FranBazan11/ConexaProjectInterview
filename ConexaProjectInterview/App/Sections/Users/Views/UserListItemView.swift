//
//  UserListItemView.swift
//  ConexaProjectInterview
//
//  Created by Juan Bazan Carrizo on 30/12/2023.
//

import SwiftUI

struct UserListItemView: View {
    
    // MARK: - PROPERTIES
    let user: UserModel
    @Binding var modalId: Int?
    
    // MARK: - BODY
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Group {
                        Text(user.firstname)
                        Text(user.lastname)
                    }
                    .font(.system(size: 18, weight: .black))
                    .multilineTextAlignment(.leading)
                    Spacer()
                } //: HStack
                HStack {
                    Text("Street: ")
                        .font(.system(size: 15, weight: .bold))
                    Text(user.address.street)
                        .font(.system(size: 15, weight: .regular))
                    Spacer()
                } //: HStack
            } //: VStack
            Image(systemName: "map")
                .resizable()
                .frame(width: 25, height: 25, alignment: .trailing)
                .foregroundColor(.blue)
                .onTapGesture {
                    modalId = user.id
                }
        } //: HStack
    }
}

// MARK: - PREVIEW
//struct UserListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserListItemView(user: Mock.user, modalId: <#Binding<Int>#>)
//            .padding()
//    }
//}
