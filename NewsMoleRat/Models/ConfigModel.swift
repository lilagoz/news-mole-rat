//
//  Config.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 21..
//

import Foundation

struct ConfigModel: Encodable, Decodable {
    var language: Language
    var name: String
    var height: Float
    var weight: Float
    var gender: Double
    var eyeColor: EyeColor
    
    init() {
        self.init(language: .English, name: "", height: 0.0, weight: 0.0, gender: 150, eyeColor: .brown)
    }
    init(language: Language, name: String, height: Float, weight: Float, gender: Double, eyeColor: EyeColor) {
        self.language = language
        self.name = name
        self.height = height
        self.weight = weight
        self.gender = gender
        self.eyeColor = eyeColor
    }
}

