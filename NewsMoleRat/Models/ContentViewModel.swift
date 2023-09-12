//
//  ContentViewModel.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 12..
//

import Foundation

@MainActor
final class ContentViewModel: ObservableObject {
    @Published var articles: [Article]?
    func start() async {
        print("ContentViewModel start")
        
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
}
