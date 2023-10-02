//
//  FireStoreController.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 25..
//

import SwiftUI
import FirebaseFirestore

struct FireStoreController {
    
    //    let db = Firestore.firestore()
    
    //    func doSomething() {
    //        let data: [String: Any] = [
    //            "color": "red",
    //            "name": "big red",
    //            "quantity": 123
    //        ]
    //
    //
    //        db.collection("bananas").addDocument(data: data) { error in
    //            if let error = error {
    //                print("Error adding document: \(error)")
    //            } else {
    //                print("Document added with ID:")
    //            }
    //        }
    //    }
    //    func createSomeMockNews() {
    //        Task {
    //            var i = 0
    //            articlesModel.articles?.forEach() { article in
    //                let title = article.title ?? ""
    //                let description = article.description ?? ""
    //                let content = article.content ?? ""
    //                let url = article.url ?? ""
    //                let urlToImage = article.urlToImage ?? ""
    //
    //                let data: [String: Any] = [
    //                    "title": title,
    //                    "description": description,
    //                    "content": content,
    //                    "url": url,
    //                    "urlToImage": urlToImage
    //                ]
    //
    //                print("data: \(data)")
    //                var ref: DocumentReference? = nil
    //                ref = db.collection("articles").addDocument(data: data) { error in
    //                    if let error = error {
    //                        print("Error adding document: \(error)")
    //                    } else {
    //                        print("\(i)Document added with ID: \(ref!.documentID)")
    //                        i += 1
    //                    }
    //                }
    //            }
    //        }
    //    }
    
    private static var db: CollectionReference {
        get {
            return Firestore.firestore().collection("articles")
        }
    }
    
    static func save(article: Article) {
        let data: [String: Any] = [
            "title": article.title,
            "content": article.content,
            "description": article.description,
            "url": article.url,
            "urlToImage": article.urlToImage,
        ]
        
        Self.db.document(article.id).setData(data) { error in
            if let error = error {
                print("Save has been failed. \(error.localizedDescription)")
                return
            }
            //retrieve
        }
    }
    
    private static func splitArrayIntoChunks<T>(_ array: [T], chunkSize: Int) -> [[T]] {
        var chunks: [[T]] = []
        
        for index in stride(from: 0, to: array.count, by: chunkSize) {
            let endIndex = Swift.min(index + chunkSize, array.count)
            let chunk = Array(array[index..<endIndex])
            chunks.append(chunk)
        }
        
        return chunks
    }
    
    private static func documentsToArticles(_ documents: [QueryDocumentSnapshot])->[Article] {
        documents.compactMap() { Article($0) }
    }
    
    static func getArticles(count: Int = 10000) {
        print("FireStoreController.getArticles")
        let search = ArticlesObservable.share.searchString
        
        if search.isEmpty {
            Self.db.limit(to: count).getDocuments() { (querySnapshot, error) in
                if let error = error {
                    print("getArticles error: \(error)")
                    return
                }
                guard let documents = querySnapshot?.documents else {
                    print("There is no documents here")
                    return
                }
                
                ArticlesObservable.share.articles = Self.documentsToArticles(documents)
            }
        }
        else {
            let a = AlgoliaController()
            a.search() { IDs in
                Task {
                    await getDocumentsByIDs(IDs)
                }
            }
        }
    }
    
    @MainActor
    static private func getDocumentsByIDs(_ IDs: [String]) async {
        do {
            var foundArticles: [Article] = []
            let chunks = Self.splitArrayIntoChunks(IDs, chunkSize: 20)
            for chunk in chunks {
                let result = try await Self.db.whereField(FieldPath.documentID(), in: chunk).getDocuments()
                let documents: [QueryDocumentSnapshot] = result.documents
                foundArticles.append(contentsOf: Self.documentsToArticles(documents))
            }
            ArticlesObservable.share.articles = foundArticles
        }
        catch {}
    }
    
    
}
