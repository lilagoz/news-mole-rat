//
//  ContentView.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 12..
//

import SwiftUI

struct ArticleListView: View {
    @Environment(UserAuthModel.self) private var userAuth
    @State var searchString: String = ""
    @State var articlesModel: ArticlesModel
    @State private var animateGradient: Bool = true
    
    var body: some View {
        VStack{
            NavigationStack{
                VStack{
                    HStack {
                        TextField("Search...", text: $searchString)
                            .padding(5.0)
                            .background(Color.white.opacity(0.7))
                            .clipShape(RoundedRectangle(cornerRadius: 12.5))
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
                        .clipShape(RoundedRectangle(cornerRadius: 12.5))
                    } else {
                        ProgressView()
                    }
                    Spacer()
                    
                }
                .toolbar {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape")
                    }
                    NavigationLink(destination: LoginView()) {
                        if userAuth.isLoggedIn {
                            Image(uiImage: userAuth.profilePic)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 25, height: 25)
                                .clipShape(RoundedRectangle(cornerRadius: 12.5))
                        } else {
                            Image(systemName: "person")
                        }
                    }
                }
                
//                .task {
//                 //   use only for preview
//                    await articlesModel.start()
//                }
                .background(
                    ZStack {

                        AngularGradient(gradient: Gradient(colors:[
                            Color.red,
                            Color.yellow,
                            Color.green,
                            Color.cyan,
                            Color.blue,
                            Color.purple,
                            Color.red
                        ]), center: .center, angle: .degrees(animateGradient ? 360 : 0))
                            .edgesIgnoringSafeArea(.all)
                            .onAppear {
                                withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                                    animateGradient.toggle()
                                }
                            }
                            .opacity(0.8)
                        
                        if let image = UIImage(named: "AppIcon") {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150.0, height: 150.0)
                                .clipShape(RoundedRectangle(cornerRadius: 75))
                        }

                    }
                )
            }
        }
    }
}

//struct ArticleListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleListView(articlesModel: .init())
//    }
//}
