//
//  ContentView.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 12..
//

import SwiftUI

struct ArticleListView: View {
    @State var searchString: String = ""
    @ObservedObject var articlesModel: ArticlesModel
    
    var body: some View {
        VStack{
            NavigationStack{
                VStack{
                    HStack {
                        TextField("Search...", text: $searchString)
                            .padding(5.0)
                            .border(Color.gray)
                            .onSubmit {
                                Task{
                                    await articlesModel.search(searchString:  searchString)
                                }
                            }
                    }
                    .padding(.horizontal, 10)
                    
                    if let articles = articlesModel.articles {
                        List(articles, id: \.id) { article in
                            NavigationLink(destination: ArticleDetailsView(article: article)) {
                                CardView(article: article)
                                    .padding(10)
                            }
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
                        }
                        .scrollContentBackground(.hidden)
                        
                    } else {
                        ProgressView()
                    }
                    Spacer()
                    
                }
                
                .toolbar {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape")
                    }
                }
            }
            
        }

    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView(articlesModel: .init())
    }
}
