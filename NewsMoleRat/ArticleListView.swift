//
//  ContentView.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 12..
//

import SwiftUI

struct ArticleListView: View {
//    @State var articles: [Article]
    
    @ObservedObject var viewModel: ContentViewModel
    
    
    func doSomethingStrange() {
        print("doSomethingStrange")
    }
    
    var body: some View {
        NavigationStack{
            if let articles = viewModel.articles {
                List(articles, id: \.id) { article in
                    NavigationLink(destination: ArticleDetails(article: article)) {
                        CardView(article: article)
                    }
                }
                .toolbar {
                    Button(action: doSomethingStrange) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .task {
            await viewModel.start()
        }
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView(viewModel: .init())
    }
}
