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
    @State var config = ConfigManager()
    @State var userAuth: UserAuthModel = UserAuthModel()
    @State var articlesModel = ArticlesModel()
    
    init() {
        
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
            .environmentObject(config)
            .navigationViewStyle(.stack)
            .task {
                await config.load()
                await articlesModel.start()
            }
        }
        
    }
}
