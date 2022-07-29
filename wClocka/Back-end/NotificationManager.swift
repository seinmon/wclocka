//
/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UserNotifications

/**
 * Notification Center related functionalities
 */
class NotificationManager {
    /**
     * Get the status of notifcation authorization
     *
     * - Parameters:
     *  - enabledHandler: Handle authorized notifications
     *  - disabledHandler: Handle disabled notifcations
     */
    internal static func authorizationStatusHandlers(enabledHandler: @escaping () -> Void,
                                                     disabledHandler: @escaping () -> Void) {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings {settings in
            if settings.authorizationStatus == .denied {
                DispatchQueue.main.async {
                    disabledHandler()
                }
            } else if settings.authorizationStatus == .authorized {
                DispatchQueue.main.async {
                    enabledHandler()
                }
            }
        }
    }

    /**
     * Request permission for notifications
     *
     * - Parameters:
     *  - successHandler: Handle notifications when the permission is granted
     *  - failHandler: Handle notifcations when permission is not granted
     */
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

    /**
     * Schedule a notifcation
     *
     * - Parameters:
     *  - notifcationTime: time of the notifcation
     *  - timezone: time zone of receiving notifcation
     *  - identifier: unique identifier for the scheduled notifcation
     *  - message: message of notification
     */
    internal func scheduleNotification(notificationTime: Date,
                                       timezone: TimeZone,
                                       identifier: String,
                                       message: String) {
        var dateComponent = DateComponents()
        dateComponent.hour = getTimeSlice(of: notificationTime, format: "HH")
        dateComponent.minute = getTimeSlice(of: notificationTime, format: "mm")
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent,
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

    /**
     * Cancel a scheduled notification
     *
     * - Parameters: Unique identifier of a scheduled notification
     */
    internal func cancelNotification(identifier: String) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
    }

    /**
     * Get a certain part of the date/time
     *
     * - Parameters:
     *  - date: time to slice
     *  - format: specific format to use for slicing
     *
     *  - Returns: a certain part of the time
     */
    private func getTimeSlice(of date: Date, format: String) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return Int(dateFormatter.string(from: date))
    }
}
