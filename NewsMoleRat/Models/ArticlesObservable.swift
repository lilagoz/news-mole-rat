//
//  ArticlesObservable.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 28/09/2023.
//

import Foundation

class ArticlesObservable: ObservableObject {
    static let share = ArticlesObservable()
    
    @Published var articles: [Article]?
    @Published var searchString: String = ""
}
