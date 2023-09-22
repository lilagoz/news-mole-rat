//
//  SettingsView.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 13..
//

import SwiftUI
import GoogleSignIn


struct SettingsView: View {
    @EnvironmentObject private var cm: ConfigManager
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        VStack{

            Form {
                Section {
                    Picker("Language", selection: $cm.config.language) {
                        ForEach(Language.allCases) { language in
                            Text(String(describing: language)).tag(language)
                        }
                    }
                    .onChange(of: cm.config.language) {
                        cm.validateName()
                    }
                }
                Section {
                    TextField("Name", text: $cm.config.name)
                        .listRowSeparator(.hidden)
                        .onChange(of: cm.config.name) {
                            cm.validateName()
                        }
                    if !cm.errorName.isEmpty {
                        Text(cm.errorName)
                            .font(.footnote)
                            .foregroundColor(Color.red)
                    }
                }
                
                
                Section {
                    Picker("Eye color", selection: $cm.config.eyeColor) {
                        ForEach(EyeColor.allCases) { eyeColor in
                            Text(String(describing: eyeColor)).tag(eyeColor)
                        }
                    }
                }
                
                Section {
                    HStack{
                        Text("Male")
                        Spacer()
                        Text("Gender")
                        Spacer()
                        Text("Female")
                    }
                        .listRowSeparator(.hidden)
                    Slider(value: $cm.config.gender, in: 100...200)
                }
                
            }
            .onChange(of: scenePhase) { oldScenePhase, newScenePhase in
                if newScenePhase == .inactive {
                    print("newScenePhase == .inactive")
                    Task {
                        await cm.save()
                    }
                }
            }
            
            Spacer()
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        @State var config = ConfigManager()
//        SettingsView()
//            .environmentObject(config)
//    }
//}
/// This is an easier way to create a preview
#Preview {
    SettingsView()
        .environmentObject(ConfigManager())
}
