//
//  NotificationView.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 22..
//

import SwiftUI
import UserNotifications

struct NotificationView: View {
    var body: some View {
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }

            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Dress up the mole rat."
                content.subtitle = "She looks naked. She might catch a cold."
                content.sound = UNNotificationSound.default

                // show this notification five seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)

                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                // add our notification request
                UNUserNotificationCenter.current().add(request)
                
                UNUserNotificationCenter.current().setBadgeCount(64738)
                
            }
            
            Button("Get notifications") {
                UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: { pendingNotifications in
                    //print("pendingNotifications: \(pendingNotifications)")
                    pendingNotifications.forEach() { pendingNotification in
                        print("id: \(pendingNotification.identifier), title: \(pendingNotification.content.title), subtitle: \(pendingNotification.content.subtitle)")
                    }
                })
                
            }
        }
    }
}

#Preview {
    NotificationView()
}
