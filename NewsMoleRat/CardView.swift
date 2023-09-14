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
        HStack {
            VStack {
                if let title = article.title {
                    Text(title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 5.0)
                }
                if let description = article.description {
                    Text(description)
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                }
                if let sourceName = article.source?.name {
                    Text(sourceName)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .fontWeight(.thin)
                }
            }
            .padding(.vertical, 10.0)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(article: Article(title: "Macska kutya denevér", description: "Kutyat es macskat es denevert fogtak a tavoli varosban, a rendorok megkezdtek az eljaras lefolytatasat a muveleti teruleten", sourceName: "Allatkert info", content: nil, urlToImage: nil, url: nil))
    }
}
