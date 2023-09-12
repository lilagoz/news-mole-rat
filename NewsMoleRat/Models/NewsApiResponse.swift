//
//  NewsApiResponse.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 12..
//

import Foundation

struct NewsApiResponse: Decodable {
    var status: String
    var totalResults: Int
    var articles: [Article]
}
