//
//  ImageView.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 15..
//

import SwiftUI

struct ImageView: View {
    var urlToImage: String?
    var color: Color
    
    var body: some View {
        AsyncImage(url: URL(string: urlToImage ?? "")) { phase in
            if let image = phase.image {
                image.resizable()
            } else if phase.error != nil {
                Rectangle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [.red, .white]), startPoint: .top, endPoint: .bottom)
                    )
            } else {
                ZStack {
                    Rectangle()
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [color, .white]), startPoint: .top, endPoint: .bottom)
                        )
                    ProgressView()
                }
            }
        }
        .aspectRatio(contentMode: .fit)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(urlToImage: "urlToImage", color: Color.purple)
    }
}
