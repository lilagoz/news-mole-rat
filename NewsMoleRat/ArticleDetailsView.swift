//
//  ArticleDetails.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 12..
//

import SwiftUI

struct ArticleDetailsView: View {
    let article: Article
    var imageView: UIImageView!
    
    var body: some View {
        VStack {
            ZStack {
                if let urlToImage = article.urlToImage {
                    AsyncImage(url: URL(string: urlToImage)) { phase in
                        if let image = phase.image {
                            image.resizable()
                        } else if phase.error != nil {
                            Rectangle()
                                .fill(
                                    LinearGradient(gradient: Gradient(colors: [.green, .white]), startPoint: .top, endPoint: .bottom)
                                )
                        } else {
                            ZStack {
                                Rectangle()
                                    .fill(
                                        LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom)
                                    )
                                ProgressView()
                            }
                        }
                    }
                    .aspectRatio(contentMode: .fit)
                }
                else {
                    Rectangle()
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [.purple, .white]), startPoint: .top, endPoint: .bottom)
                        ).aspectRatio(contentMode: .fit)
                }
                if let title = article.title {
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .shadow(color: Color.black, radius: 10)
                }
            }
            VStack{
                HStack {
                    Text(article.source?.name ?? "")
                        .fontWeight(.thin)
                    Spacer()
                    Text(article.publishedAt ?? "")
                        .fontWeight(.thin)
                }.padding(.bottom, 5)
                
                
                Text(article.content ?? article.description ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let url = article.url {
                    Link(destination: URL(string: url)!) {
                        Text("more...").padding()
                    }
                }
            }.padding()
            Spacer()
        }.ignoresSafeArea()
    }
}

struct ArticleDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ArticleDetailsView(article: Article(title: "Macska kutya denevér", description: nil, sourceName: nil, content: "Kutyat es macskat es denevert fogtak a tavoli varosban, a rendorok megkezdtek az eljaras lefolytatasat a muveleti teruleten", urlToImage: nil))
        }
    }
}
