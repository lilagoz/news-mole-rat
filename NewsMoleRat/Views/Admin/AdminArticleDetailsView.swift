//
//  AdminArticleDetailsView.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 27/09/2023.
//

import SwiftUI

struct AdminArticleDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    private let db = FireStoreController()
    
    var article: Article
    @State var title:String
    @State var description:String
    @State var content:String
    
    init(article: Article) {
        self.article = article
        _title = State(initialValue: article.title)
        _description = State(initialValue: article.description)
        _content = State(initialValue: article.content)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Title") {
                    TextField("Title", text: $title, axis: .vertical)
                }
                
                Section("Description") {
                    TextField("Description", text: $description, axis: .vertical)
                }
                
                Section("Content") {
                    TextField("Content", text: $content, axis: .vertical)
                }
            }
            .navigationTitle("\(article.id)")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        print("ok")
                        let modified = Article(id: article.id, title: title, description: description, content: content )
                        
                        FireStoreController.save(article: modified)
                        
                        dismiss()
                    }
                }
            }
            
        }
        
    }
}

#Preview {
    AdminArticleDetailsView(article: Article(id: "1234"))
}
