//
//  News.swift
//  CMTP_TestTask
//
//  Created by Dan on 12.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import Foundation

// MARK: - News
struct News: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let status, userTier: String
    let total, startIndex, pageSize, currentPage: Int
    let pages: Int
    let orderBy: String
    let results: [NewsResult]
}

// MARK: - Result
struct NewsResult: Codable {
    let id: String
    let webTitle: String
    let fields: Fields?

    enum CodingKeys: String, CodingKey {
        case id
        case webTitle
        case fields
    }
}

// MARK: - Fields
struct Fields: Codable {
    let thumbnail: String
}
