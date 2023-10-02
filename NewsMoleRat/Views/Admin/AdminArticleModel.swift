//
//  AdminArticleModel.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 02/10/2023.
//

import Foundation
import SwiftUI
import PhotosUI
import CoreTransferable

@MainActor
class AdminArticleModel: ObservableObject {
    
    // MARK: - Profile Details
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var content: String = ""
    @Published var url: String = ""
    @Published var urlToImage: String = ""
    @Published var uiImage: UIImage?
    
    // MARK: - Constructor
    init(article: Article) {
        self.title = article.title
        self.description = article.description
        self.content = article.content
        self.url = article.url
        self.urlToImage = article.urlToImage
    }
    
    // MARK: - Profile Image
    
    enum ImageState {
        case empty
        case loading(Progress)
        case success(Image)
        case failure(Error)
    }
    
    enum TransferError: Error {
        case importFailed
    }
    
    struct ProfileImage: Transferable {
        let uiImage: UIImage
        let image: Image
        
        static var transferRepresentation: some TransferRepresentation {
            DataRepresentation(importedContentType: .image) { data in
//            #if canImport(AppKit)
//                guard let nsImage = NSImage(data: data) else {
//                    throw TransferError.importFailed
//                }
//                let image = Image(nsImage: nsImage)
//                return ProfileImage(image: image)
            #if canImport(UIKit)
                guard let uiImage = UIImage(data: data) else {
                    throw TransferError.importFailed
                }
                let image = Image(uiImage: uiImage)
                return ProfileImage(uiImage: uiImage, image: image)
            #else
                throw TransferError.importFailed
            #endif
            }
        }
    }
    
    @Published private(set) var imageState: ImageState = .empty
    
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: ProfileImage.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else {
                    print("Failed to get the selected item.")
                    return
                }
                switch result {
                case .success(let profileImage?):
                    self.urlToImage = ""
                    self.imageState = .success(profileImage.image)
                    self.uiImage = profileImage.uiImage
                case .success(nil):
                    self.imageState = .empty
                case .failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
}
