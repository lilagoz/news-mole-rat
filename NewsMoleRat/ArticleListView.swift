//
//  ContentView.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 12..
//

import SwiftUI

struct ArticleListView: View {
//    @State var articles: [Article]
    @State var searchString: String = ""
    @ObservedObject var viewModel: ContentViewModel
    
    
    func doSomethingStrange() {
        print("doSomethingStrange")
    }
    
    var body: some View {
        VStack{
            HStack {
                TextField("Search...", text: $searchString)
                    .padding(5.0)
                    .border(Color.gray)
                    .onSubmit {
                        Task{
                            await viewModel.search(searchString: searchString)
                        }
                    }
            }
            .padding(.horizontal, 10)
            
            if let articles = viewModel.articles {
                NavigationStack{
                    List(articles, id: \.id) { article in
                        NavigationLink(destination: ArticleDetails(article: article)) {
                            CardView(article: article)
                        }
                    }
                }
            } else {
                Text("Loading...")
            }
            Spacer()
        }
        .task {
            await viewModel.start()
        }
//        .toolbar {
//            Button(action: doSomethingStrange) {
//                Image(systemName: "plus")
//            }
//        }
            
        

    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView(viewModel: .init())
    }
}
