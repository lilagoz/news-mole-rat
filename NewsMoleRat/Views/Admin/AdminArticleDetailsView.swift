//
//  AdminArticleDetailsView.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 27/09/2023.
//

import SwiftUI
import PhotosUI

struct AdminArticleDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    private let db = FireBaseController()
    //@ObservedObject var viewModel: AdminArticleModel
    @StateObject var viewModel: AdminArticleModel
    var article: Article
    
    init(article: Article) {
        self.article = article
        self._viewModel = StateObject(wrappedValue: AdminArticleModel(article: article))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Title") {
                    TextField("Title", text: $viewModel.title, axis: .vertical)
                }
                
                Section("Description") {
                    TextField("Description", text: $viewModel.description, axis: .vertical)
                }
                
                Section("Content") {
                    TextField("Content", text: $viewModel.content, axis: .vertical)
                }
                
                Section("URL") {
                    TextField("URL", text: $viewModel.url)
                }
                
                Section("Image") {
                    PhotosPicker(selection: $viewModel.imageSelection,
                                 matching: .images,
                                 photoLibrary: .shared()) {
                        Text("Image")
                    }
                    if !viewModel.urlToImage.isEmpty {
                        ImageView(urlToImage: viewModel.urlToImage, color: Color.purple)
                    } else {
                        switch viewModel.imageState {
                        case .success(let image):
                            image.resizable().scaledToFit()
                        case .empty:
                            Text("Empty")
                        case .loading(_):
                            ProgressView()
                        case .failure(_):
                            Text("Something went wrong")
                        }
                    }
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
                        Task {
                            
                            if case .success(_) = viewModel.imageState {
                                if let jpg = viewModel.uiImage?.jpegData(compressionQuality: 0.85) {
                                    let urlToImage = try await FireBaseController.upload(data: jpg)
                                    viewModel.urlToImage = urlToImage.absoluteString
                                }
                            }
                            
                            let modified = Article(id: article.id, title: viewModel.title, description: viewModel.description, content: viewModel.content,url: viewModel.url, urlToImage: viewModel.urlToImage )
                        
                            FireBaseController.save(article: modified)
                            
                            dismiss()
                        }
                        
                    }
                }
            }
        }
    }
}

#Preview {
    AdminArticleDetailsView(article: Article(id: "1234"))
}
