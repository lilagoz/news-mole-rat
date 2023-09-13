//
//  SettingsView.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 13..
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var config: Config
    
    func doSomething() {
        config.allat = "macska"
    }
    
    init() {
        self.config = .init()
        doSomething()
    }
    
    var body: some View {
        VStack{
//            TextField("Search...", text: $config.allat)
            Text("Hello, World! \(config.allat)")
            Form {
                TextField(text: $config.allat, prompt: Text("Required")) {
                    Text("Username")
                }
                SecureField(text: $config.allat, prompt: Text("Required")) {
                    Text("Password")
                }
            }
            Spacer()
        }

        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
