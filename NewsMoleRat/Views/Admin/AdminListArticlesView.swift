//
//  AdminListArticlesView.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 25..
//

import SwiftUI

struct AdminListArticlesView: View {
    @EnvironmentObject var articleStore: ArticlesObservable
    
    var body: some View {
        NavigationView {
            if let articles = articleStore.articles  {
                List(articles) { article in
                    NavigationLink {
                        AdminArticleDetailsView(article: article)
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("\(article.title)")
                    }
                }
            }
        }
        .navigationTitle("Articles")
        .toolbar {
            Button(action: {
//                    db.createSomeMockNews()
            }) {
                Image(systemName: "plus")
            }
        }
        .onAppear() {
            print("AdminListArticlesView onAppear")
            FireStoreController.getArticles()
        }
    }
}

#Preview {
    AdminListArticlesView()
}
