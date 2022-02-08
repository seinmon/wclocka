//
/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UserNotifications

class NotificationManager {
    
    internal static func authorizationStatusHandlers(enabledHandler: @escaping () -> Void,
                                                     disabledHandler: @escaping () -> Void) {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings {settings in
            if (settings.authorizationStatus == .denied) {
                DispatchQueue.main.async {
                    disabledHandler()
                }
            }
            else if (settings.authorizationStatus == .authorized) {
                DispatchQueue.main.async {
                    enabledHandler()
                }
            }
        }
    }
    
    internal static func requestAuthorisation(successHandler: @escaping () -> Void,
                                              failHandler: @escaping () -> Void) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                fatalError("Notification permission error: \(error)")
            }
            
            if granted {
                DispatchQueue.main.async {
                    successHandler()
                }
            } else {
                DispatchQueue.main.async {
                    failHandler()
                }
            }
        }
    }
    
    internal func scheduleNotification(notificationTime: Date,
                                       timezone: TimeZone,
                                       identifier: String,
                                       message: String) {
        let trigger = UNCalendarNotificationTrigger(dateMatching:
                                                        convertToLocalTime(notificationTime,
                                                                           timezone: timezone),
                                                    repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = "wClocka"
        content.body = message
        content.sound = .default
        
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content,
                                            trigger: trigger)
        
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if let error = error {
                fatalError("Could not schedule notification: \(error)")
            }
        }
    }
    
    internal func cancelNotification(identifier: String) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    private func convertToLocalTime(_ time: Date, timezone: TimeZone) -> DateComponents {
        var dateComponents = DateComponents(timeZone: timezone)
        dateComponents.hour = getTimeSlice(of: time, format: "HH")
        dateComponents.minute = getTimeSlice(of: time, format: "mm")
        return dateComponents
    }
    
    private func getTimeSlice(of date: Date, format: String) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return Int(dateFormatter.string(from: date))
    }
}
