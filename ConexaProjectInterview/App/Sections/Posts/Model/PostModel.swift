//
//  PostModel.swift
//  ConexaProjectInterview
//
//  Created by Juan Bazan Carrizo on 24/12/2023.
//

import Foundation

struct PostModel: Identifiable, Codable {
    let id: Int
    let title: String
    let content: String
    let thumbnail: String
    let image: String
    let status: String
    let category: String
    let publishedAt: String
    let updatedAt: String
}
