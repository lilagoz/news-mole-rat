//
//  News.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 12..
//

import SwiftUI
import FirebaseFirestore

//struct Source: Decodable {
//    var id: String?
//    var name: String?
//    init(name: String? = nil) {
//        self.name = name
//    }
//}

struct Article: Identifiable, Decodable {
    var id: String
    
    //    var source: Source?
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    //    var publishedAt: String?
    var content: String
    var color: Color = Color.pink
    
    private static func randomPredefinedColor() -> Color {
        let colors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple, .gray, .pink, .mint, .teal, .cyan, .indigo, .brown]
        
        let randomIndex = Int.random(in: 0..<colors.count)
        return colors[randomIndex]
    }
    
    init (_ queryDocumentSnapshot: QueryDocumentSnapshot) {
        let id =  queryDocumentSnapshot.documentID as String
        let title =  queryDocumentSnapshot["title"] as? String
        let description =  queryDocumentSnapshot["description"] as? String
        let content =  queryDocumentSnapshot["content"] as? String
        let url =  queryDocumentSnapshot["url"] as? String
        let urlToImage =  queryDocumentSnapshot["urlToImage"] as? String
        self.init(id: id, title: title, description: description, content: content, url: url, urlToImage: urlToImage)
    }
    
    init(id: String, title: String? = nil, description: String? = nil, content: String? = nil, url: String? = nil, urlToImage: String? = nil) {
        self.color = Self.randomPredefinedColor()
        self.id = id
        self.title = title ?? ""
        self.description = description ?? ""
        self.content = content ?? ""
        self.url = url ?? ""
        self.urlToImage = urlToImage ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, url, urlToImage, publishedAt, content, source
    }
    
    init(from decoder: Decoder) throws {
        self.color = Self.randomPredefinedColor()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        self.urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage) ?? ""
        //        self.publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt)
        self.content = try container.decodeIfPresent(String.self, forKey: .content) ?? ""
        //        self.source = try container.decodeIfPresent(Source.self, forKey: .source)
    }
}
