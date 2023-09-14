//
//  News.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 12..
//

import SwiftUI

struct Source: Decodable {
    var id: String?
    var name: String?
    init(name: String? = nil) {
        self.name = name
    }
}

struct Article: Identifiable, Decodable {
    var id: String? = UUID().uuidString
    
    var source: Source?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    var color: Color!
    
    private func randomPredefinedColor() -> Color {
        let colors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple, .gray, .pink, .mint, .teal, .cyan, .indigo, .brown]
        
        let randomIndex = Int.random(in: 0..<colors.count)
        return colors[randomIndex]
    }
    
    init() {
        self.color = randomPredefinedColor()
    }
    
    init(title: String?, description: String?, sourceName: String?, content: String?, urlToImage: String?, url: String?) {
        self.init()
        self.title = title
        self.description = description
        self.source = Source(name: sourceName)
        self.content = content
        self.urlToImage = urlToImage
        self.url = url
    }
    
    enum CodingKeys: String, CodingKey {
        case title, description, url, urlToImage, publishedAt, content, source
    }
        
    init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage)
        self.publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        self.source = try container.decodeIfPresent(Source.self, forKey: .source)
    }
}
