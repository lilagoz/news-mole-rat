//
//  Config.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 13..
//

import Foundation

final class Config: ObservableObject {
    @Published var allat: String
    
    init(){
        self.allat = "medve"
    }

}
