//
//  AlgoliaController.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 28/09/2023.
//

import Foundation
import SwiftUI
import InstantSearchSwiftUI
import AlgoliaSearchClient

class AlgoliaController {
    let client = SearchClient(appID: "H0FRQNGSDQ", apiKey: "6d20f895ee59385d4e3f7f8f926cfdaa")
    let index: Index
    
    
    init() {
        index = client.index(withName: "NewsMoleRat")
//        let settings = Settings()
//            .set(\.paginationLimitedTo, to: 1000)
//        index.setSettings(settings) { result in
//            if case .success(let response) = result {
//                print("Response: \(response)")
//            }
//        }
    }
    
    func search(_ callback: @escaping ([String]) -> Void) {
        let search: String = ArticlesObservable.share.searchString
        index.search(query: Query(search).set(\.hitsPerPage, to: 200)) { result in
            if case .success(let response) = result {
                print("Response: \(response)")
                let IDs: [String] = response.hits.map() { item in
                    item.objectID.rawValue
                }
                print("IDs: \(IDs)")
                callback(IDs)
            }
        }
    }
}



