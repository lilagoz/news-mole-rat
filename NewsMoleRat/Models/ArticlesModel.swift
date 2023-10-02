//
//  ContentViewModel.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 12..
//

import Foundation


//@Observable final class ArticlesModel {
//    var articles: [Article]?
//    
//    init(){
//        
//    }
//    
//    var newApiKey: String {
//        if let newApiKey = Bundle.main.object(forInfoDictionaryKey: "NewApiKey") as? String {
//            return newApiKey
//        }
//        return ""
//    }
//    
//    func start() async {
//        
//        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(newApiKey)")!
//        
//        do{
//            let (data, _) = try await URLSession.shared.data(from: url)
//            let decodedResponse = try JSONDecoder().decode(NewsApiResponse.self, from: data)
//            articles = decodedResponse.articles
//        }
//        catch {
//            print("Something went wrong. \(error)")
//        }
//    }
//    
//    func search(searchString: String) async {
//        print("search: \(searchString)")
//        articles = nil
//        
//        var urlComps = URLComponents(string: "https://newsapi.org/v2/everything")!
//        urlComps.queryItems = [
//            URLQueryItem(name: "apiKey", value: newApiKey),
//            URLQueryItem(name: "sortBy", value: "popularity"),
//            URLQueryItem(name: "q", value: searchString),
//        ]
//
//        do{
//            let (data, _) = try await URLSession.shared.data(from: urlComps.url!)
//            let decodedResponse = try JSONDecoder().decode(NewsApiResponse.self, from: data)
//            articles = decodedResponse.articles
//        }
//        catch {
//            print("Something went wrong. \(error)")
//        }
//    }
//    
//}
