//
//  NewsMoleRatApp.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 12..
//

import SwiftUI
import GoogleSignIn
import UserNotifications

@main
struct NewsMoleRatApp: App {
    @Environment(\.scenePhase) var scenePhase
    @State var config = ConfigManager()
    @State var userAuth: UserAuthModel = UserAuthModel()
    @State var articlesModel = ArticlesModel()
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ArticleListView(articlesModel: articlesModel)
            }
            .onOpenURL { url in
                print("onOpenURL: \(url)")
                GIDSignIn.sharedInstance.handle(url)
            }
            .onAppear {
                print("onAppear")
                userAuth.check()
            }
            .environment(userAuth)
            .environmentObject(config)
            .navigationViewStyle(.stack)
            .task {
                await config.load()
                await articlesModel.start()
            }
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .active {
                print("Active")
            } else if newPhase == .inactive {
                print("Inactive")
            } else if newPhase == .background {
                print("Background")
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                let content = UNMutableNotificationContent()
                content.title = "The mole rat miss you."
                content.subtitle = "Aren't you interested in what happened?"
                content.sound = UNNotificationSound.default

                // show this notification five seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)

                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                // add our notification request
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
    
    
    
}
