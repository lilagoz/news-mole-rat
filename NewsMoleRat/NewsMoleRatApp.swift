//
//  NewsMoleRatApp.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 12..
//

import SwiftUI
import GoogleSignIn

@main
struct NewsMoleRatApp: App {
    @State var userAuth: UserAuthModel = UserAuthModel()
    @State var articlesModel = ArticlesModel()
    
    private func load() {
        Task {
            await articlesModel.start()
        }
    }
    
    init() {
        load()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ArticleListView(articlesModel: articlesModel)
            }
            .onOpenURL { url in
                print("onOpenURL: \(url)")
                GIDSignIn.sharedInstance.handle(url)
            }
            .onAppear {
                print("onAppear")
                userAuth.check()
            }
            .environment(userAuth)
            .navigationViewStyle(.stack)
        }
    }
}
