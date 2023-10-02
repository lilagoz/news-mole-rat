//
//  CardView.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 12..
//

import SwiftUI

struct CardView: View {
    let article: Article
    
    var body: some View {
        ZStack {
            ImageView(urlToImage: article.urlToImage, color: article.color)
                .opacity(0.4)
                .clipShape(RoundedRectangle(cornerRadius: 12.5))
            HStack {
                VStack {
                    Text(article.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 5.0)
                    Text(article.description)
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                    //                    if let sourceName = article.source?.name {
                    //                        Text(sourceName)
                    //                            .frame(maxWidth: .infinity, alignment: .trailing)
                    //                            .fontWeight(.thin)
                    //                    }
                }
                .padding(.vertical, 10.0)
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(article: Article(id: "foo", title: "Macska kutya denevér", description: "Kutyat es macskat es denevert fogtak a tavoli varosban, a rendorok megkezdtek az eljaras lefolytatasat a muveleti teruleten", content: nil, url: nil, urlToImage: nil))
    }
}
