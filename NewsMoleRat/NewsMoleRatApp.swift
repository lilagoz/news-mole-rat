//
//  NewsMoleRatApp.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 12..
//

import SwiftUI

@main
struct NewsMoleRatApp: App {
    @ObservedObject var articlesModel: ArticlesModel
    
    private func load() {
        Task {
            await articlesModel.start()
        }
    }
    
    init() {
        self.articlesModel = .init()
        load()
    }
    
    
    var body: some Scene {
        WindowGroup {
            ArticleListView(articlesModel: articlesModel)
        }
    }
}
