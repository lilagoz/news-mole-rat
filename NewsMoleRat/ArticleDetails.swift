//
//  ArticleDetails.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 12..
//

import SwiftUI

struct ArticleDetails: View {
    let article: Article
    var imageView: UIImageView!
    
    var body: some View {
        VStack {
            ZStack {
                
                if let urlToImage = article.urlToImage {
                    //TODO: fallback image as rectangle
                    AsyncImage(
                        url: URL(string: urlToImage),
                        content: { image in
                            image.image?
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    )
                }
                else {
                    Rectangle()
                        
                        .frame(width: .infinity, height: 100)
                        
                }
                VStack {
                    if let title = article.title {
                        Text(title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .shadow(color: Color.black, radius: 10)
                    }
                }
            }
            VStack{
                HStack {
                    if let sourceName = article.source?.name {
                        Text(sourceName)
                            .fontWeight(.thin)
                    } else {
                        Text("someone")
                            .fontWeight(.thin)
                    }
                    Spacer()
                    if let publishedAt = article.publishedAt {
                        Text(publishedAt)
                            .fontWeight(.thin)
                    } else {
                        Text("sometime")
                            .fontWeight(.thin)
                    }
                }.padding(.bottom, 5)
                
                if let content = article.content {
                    Text(content)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    if let description = article.description {
                        Text(description)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
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

struct ArticleDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ArticleDetails(article: Article(title: "Macska kutya denevér", description: nil, sourceName: "Allatkert info", content: "Kutyat es macskat es denevert fogtak a tavoli varosban, a rendorok megkezdtek az eljaras lefolytatasat a muveleti teruleten", urlToImage: "https://www.akronzoo.org/sites/default/files/styles/uncropped_xl/public/2022-05/Naked-mole-rat-main.png"))
        }
    }
}
