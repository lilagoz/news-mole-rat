//
//  Language.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 21..
//

import Foundation

enum Language: String, Codable, CaseIterable, Identifiable {
    case English = "en"
    case Arabic = "ar"
    case German = "de"
    case Spanish = "es"
    case French = "fr"
    case Hebrew = "he"
    case Italian = "it"
    case Dutch = "nl"
    case Norwegian = "no"
    case Portuguese = "pt"
    case Russian = "ru"
    case Swedish = "sv"
    case Urdu = "ud" // Note: "ud" is not a standard language code for Urdu, normally it's "ur"
    case Chinese = "zh"
    
    var id: Self {self}
    
    var shortName: String {
        return self.rawValue
    }
    
    var commonForenames: [String] {
        switch self {
        case .English:
            return ["James", "John", "Robert", "Michael", "William", "Mary", "Patricia", "Jennifer", "Linda", "Barbara"]
        case .Arabic:
            return ["Mohammed", "Ahmed", "Ali", "Fatima", "Aisha", "Omar", "Abdullah", "Sara", "Hana", "Yusuf"]
        case .German:
            return ["Maximilian", "Sophie", "Emma", "Lukas", "Leon", "Marie", "Paul", "Mia", "Elias", "Hannah"]
        case .Spanish:
            return ["Maria", "Jose", "Juan", "Antonio", "Carmen", "Francisco", "Ana", "David", "Javier", "Isabel"]
        case .French:
            return ["Marie", "Jean", "Pierre", "Claire", "Thomas", "Anne", "Nicolas", "Nathalie", "Philippe", "François"]
        case .Hebrew:
            return ["Avraham", "Moshe", "Sara", "Esther", "David", "Yosef", "Rachel", "Leah", "Jacob", "Miriam"]
        case .Italian:
            return ["Giuseppe", "Maria", "Antonio", "Giovanni", "Luigi", "Anna", "Angela", "Marco", "Rosa", "Andrea"]
        case .Dutch:
            return ["Jan", "Anna", "Johanna", "Maria", "Hendrik", "Willem", "Klaas", "Pieter", "Elisabeth", "Gerard"]
        case .Norwegian:
            return ["Ole", "Lars", "Kari", "Anne", "Arne", "Ingrid", "Johan", "Kristin", "Erik", "Astrid"]
        case .Portuguese:
            return ["João", "Maria", "José", "Ana", "Antonio", "Carlos", "Pedro", "Luís", "Fernanda", "Paulo"]
        case .Russian:
            return ["Alexander", "Maria", "Sergey", "Anastasia", "Dmitry", "Natalia", "Olga", "Vladimir", "Elena", "Igor"]
        case .Swedish:
            return ["Erik", "Anna", "Johan", "Emma", "Karl", "Sara", "Lena", "Anders", "Oskar", "Sofia"]
        case .Urdu:
            return ["Ali", "Fatima", "Ahmed", "Ayesha", "Saad", "Sara", "Zainab", "Hassan", "Mohammad", "Hafsa"]
        case .Chinese:
            return ["Li", "Wang", "Zhang", "Liu", "Chen", "Yang", "Zhao", "Huang", "Wu", "Zhou"]
        }
    }
}
