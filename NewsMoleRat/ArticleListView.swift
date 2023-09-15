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
//                            .border(Color.gray)
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(10)
                            .frame(height:40)
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
                            .background(article.color.opacity(0.2))
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
//                .task {
//                 //   use only for preview
//                    await articlesModel.start()
//                }
                .background(AngularGradient(gradient: Gradient(colors:[Color.red,Color.green,Color.blue,Color.green,Color.red ]), center: .center).opacity(0.5))
            }
        }
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView(articlesModel: .init())
    }
}
