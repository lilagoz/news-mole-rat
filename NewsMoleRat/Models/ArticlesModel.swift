//
//  ContentViewModel.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 12..
//

import Foundation

@MainActor
final class ArticlesModel: ObservableObject {
    @Published var articles: [Article]?
    
    func start() async {
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=db725ddeb9364ab7a645c52154d2df28")!
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(NewsApiResponse.self, from: data)
            articles = decodedResponse.articles
        }
        catch {
            print("Something went wrong. \(error)")
        }
    }
    
    func search(searchString: String) async {
        print("search: \(searchString)")
        articles = nil
        
        var urlComps = URLComponents(string: "https://newsapi.org/v2/everything")!
        urlComps.queryItems = [
            URLQueryItem(name: "apiKey", value: "db725ddeb9364ab7a645c52154d2df28"),
            URLQueryItem(name: "sortBy", value: "popularity"),
            URLQueryItem(name: "q", value: searchString),
        ]

        do{
            let (data, _) = try await URLSession.shared.data(from: urlComps.url!)
            let decodedResponse = try JSONDecoder().decode(NewsApiResponse.self, from: data)
            articles = decodedResponse.articles
        }
        catch {
            print("Something went wrong. \(error)")
        }
    }
    
}
