//
//  Item.swift
//  HackerNesApp
//
//  Created by John Hur on 2022/04/18.
//

import Foundation

// 뉴스 API가 단일 아이템으로 쓰여서 struct로 구성
struct Item: Identifiable {
    let id: Int
    let commentCount: Int
    let score: Int
    let author: String
    let title: String
    let date: Date
    let url: URL
}

extension Item: Codable {
    enum CodingKeys: String, CodingKey {
        case id, score, title, url
        case commentCount = "descendants"
        case date = "time"
        case author = "by"
    }
}

