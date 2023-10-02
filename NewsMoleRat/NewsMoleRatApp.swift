//
//  NewsMoleRatApp.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 12..
//

import SwiftUI
import GoogleSignIn
import UserNotifications
import FirebaseCore
import FirebaseAppCheck

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        /// Product -> Scheme -> Run -> Arguments passed on launch -> -FIRDebugEnabled
        ///  and `Firebase App Check debug token:`
        //    let providerFactory = AppCheckDebugProviderFactory()
        //    AppCheck.setAppCheckProviderFactory(providerFactory)
        
        FirebaseApp.configure()
        return true
    }
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

@main
struct NewsMoleRatApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @Environment(\.scenePhase) var scenePhase
    @State var userAuth: UserAuthModel = UserAuthModel() //@Observable
    @State var config = ConfigManager() // ObservableObject
    @StateObject var articlesStore = ArticlesObservable.share
    
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
                ArticleListView()
            }
//            .onOpenURL { url in
//                print("onOpenURL: \(url)")
//                GIDSignIn.sharedInstance.handle(url)
//            }
            .onAppear {
                print("onAppear")
                userAuth.check()
            }
            .environment(userAuth) // @Observable
            .environmentObject(config) // ObservableObject
            .environmentObject(articlesStore) // ObservableObject
            .navigationViewStyle(.stack)
            .task {
                await config.load()
                FireBaseController.getArticles(count: 10)
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
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4567, repeats: false)
                
                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                // add our notification request
                UNUserNotificationCenter.current().add(request)
                UNUserNotificationCenter.current().setBadgeCount(0)
            }
        }
    }
}
