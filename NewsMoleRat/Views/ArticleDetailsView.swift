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
                    ImageView(urlToImage: urlToImage, color: article.color)
                }
                else {
                    Rectangle()
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [article.color, .white]), startPoint: .top, endPoint: .bottom)
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
            ZStack {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.white, article.color]), startPoint: .top, endPoint: .bottom)).opacity(0.5)
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
                        .padding(.bottom, 50)
                    
                    if let url = article.url {
                        Link(destination: URL(string: url)!) {
                            Image(systemName: "safari")
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text("read more...").padding()
                            
                        }
                    }
                    Spacer()
                }.padding()
            }
        }.ignoresSafeArea()
    }
}

struct ArticleDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ArticleDetailsView(article: Article(title: "Macska kutya denevér", description: nil, sourceName: nil, content: "Kutyat es macskat es denevert fogtak a tavoli varosban, a rendorok megkezdtek az eljaras lefolytatasat a muveleti teruleten", urlToImage: nil, url: "https://mokuscickany.hu"))
        }
    }
}
