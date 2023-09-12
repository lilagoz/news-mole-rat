//
//  ArticleDetails.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 12..
//

import SwiftUI

struct ArticleDetails: View {
    let article: Article
    
    var body: some View {
        VStack {
            Text(article.title!)
        }
    }
}

struct ArticleDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ArticleDetails(article: Article())
        }
    }
}
