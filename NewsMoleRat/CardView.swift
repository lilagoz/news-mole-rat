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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(article.title!)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(article: Article())
    }
}
