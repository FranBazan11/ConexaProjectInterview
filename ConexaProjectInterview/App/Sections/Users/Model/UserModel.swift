//
//  UserModel.swift
//  ConexaProjectInterview
//
//  Created by Juan Bazan Carrizo on 30/12/2023.
//

import Foundation

struct UserModel: Identifiable, Codable {
    let id: Int
    let firstname: String
    let lastname: String
    let address: AddressUserModel
}

struct AddressUserModel: Codable {
    let street: String
    let suite: String
    let geo: GeolocationUserModel
}

struct GeolocationUserModel: Codable {
    let lat: String
    let lng: String
}
