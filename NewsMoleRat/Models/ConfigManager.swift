//
//  Config.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 13..
//

import Foundation

final class ConfigManager : ObservableObject {
    @Published var config: ConfigModel = ConfigModel()
    @Published var errorName = ""
    
    init(){
        
    }
    
    func validateName() {
        if !config.language.commonForenames.contains(config.name) {
            errorName = "The most typical forenames in the country that was chosen are the next.\n\(config.language.commonForenames.joined(separator: ", ")).\nAre you sure, you aren't one of them?"
        }
    }

}

/// save and load capabilities of the class
extension ConfigManager {
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("config.data")
    }


    func load() async {
        let task = Task<ConfigModel, Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return ConfigModel()
            }
            let config = try JSONDecoder().decode(ConfigModel.self, from: data)
            return config
        }
        do {
            config = try await task.value
        }
        catch {}
    }


    func save() async {
        let task = Task {
            let data = try JSONEncoder().encode(config)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        do {
            _ = try await task.value
        }
        catch {}
    }

}
