//
//  SettingsView.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 13..
//

import SwiftUI
import GoogleSignIn


struct SettingsView: View {
    init() {

    }
    
    var body: some View {
        VStack{
//            TextField("Search...", text: $config.allat)
            
            Text("Hello, World!")

//            Form {
//                TextField(text: $config.allat, prompt: Text("Required")) {
//                    Text("Username")
//                }
//                SecureField(text: $config.allat, prompt: Text("Required")) {
//                    Text("Password")
//                }
            }
            Spacer()

        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
