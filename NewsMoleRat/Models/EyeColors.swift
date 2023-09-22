//
//  EyeColors.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 21..
//

import Foundation

enum EyeColor: Codable, CaseIterable, Identifiable {
    case brown
    case blue
    case green
    case hazel
    case gray
    case amber
    
    var id: Self { self }
}
