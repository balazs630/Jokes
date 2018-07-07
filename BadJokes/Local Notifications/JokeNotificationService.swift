//
//  JokeNotificationService.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 08. 26..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit
import UserNotifications

protocol JokeNotificationServiceDelegate: class {
    func notificationDidFire()
}

class JokeNotificationService: NSObject, UNUserNotificationCenterDelegate {

    // MARK: Properties
    let defaults = UserDefaults.standard
    var localTimeZoneName: String { return TimeZone.current.identifier }
    weak var delegate: JokeNotificationServiceDelegate?
    let jokeNotificationGenerator = JokeNotificationGenerator()
    var jokeTypes = [String]()

    // MARK: Initializers
    override init() {
        super.init()
        // Seeking permission of the user to display app notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (_, _) in }
        UNUserNotificationCenter.current().delegate = self
    }
}

// MARK: Notification operations
extension JokeNotificationService {
    func setNewRepeatingNotifications() {
        guard DBService.shared.unusedJokesCount() > 0 else {
            return
        }

        removeAllScheduledNotification()
        let notificationTimes = jokeNotificationGenerator.generateNotificationTimes()

        jokeTypes = jokeNotificationGenerator.makeJokeTypeProbabilityArray()
        for index in 0...notificationTimes.count - 1 {
            self.addJokeNotificationRequest(on: notificationTimes[index])
        }
    }

    func removeAllScheduledNotification() {
        removeAllPendingNotificationRequests()
        DBService.shared.deleteAllSchedules()
    }

    private func addJokeNotificationRequest(on time: Date) {
        let content = setNotificationContent()
        let trigger = setNotificationTrigger(on: time)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        guard let jokeId = content.userInfo["jokeId"] as? Int else {
            return
        }

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        DBService.shared.insertNewScheduledJoke(with: jokeId, on: time.convertToUnixTimeStamp())
    }

    private func setNotificationContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Vicc:"
        let type = jokeNotificationGenerator.generateAvailableJokeType(from: jokeTypes)
        let joke = generateRandomJoke(with: type)
        content.body = joke.jokeText.formatLineBreaks()
        content.sound = UNNotificationSound.default()
        content.badge = incrementNotificationBadgeNumber(by: 1)

        var userInfo = [String: Int]()
        userInfo["jokeId"] = joke.jokeId
        content.userInfo = userInfo

        return content
    }

    private func setNotificationTrigger(on time: Date) -> UNCalendarNotificationTrigger {
        // Setting time for notification trigger
        var dateCompenents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: time)
        dateCompenents.timeZone = TimeZone(identifier: localTimeZoneName)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateCompenents, repeats: false)

        return trigger
    }

    func moveDeliveredJokesToJokeCollection() {
        let deliveredJokes = DBService.shared.getAllDeliveredSchedules()

        for joke in deliveredJokes {
            DBService.shared.setJokeUsedAndDeliveredWith(jokeId: joke.jokeId, deliveryTime: joke.time)
            DBService.shared.deleteScheduleWith(jokeId: joke.jokeId)
        }
    }

    private func incrementNotificationBadgeNumber(by value: Int) -> NSNumber {
        let actualBadgeNumber = defaults.integer(forKey: UserDefaults.Key.badgeNumber)
        defaults.set(actualBadgeNumber + value, forKey: UserDefaults.Key.badgeNumber)
        return NSNumber(value: actualBadgeNumber + value)
    }

    private func generateRandomJoke(with type: String) -> Joke {
        if let joke = DBService.shared.getRandomJokeWith(type: type) {
            return joke
        }

        let anyType = "%"
        return DBService.shared.getRandomJokeWith(type: anyType)!
    }
}

// MARK: UNUserNotificationCenter
extension JokeNotificationService {
    func removeAllPendingNotificationRequests() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    func isNotificationsEnabled(completed: @escaping (Bool) -> Void) {
        let current = UNUserNotificationCenter.current()

        current.getNotificationSettings(completionHandler: { settings in
            completed(settings.authorizationStatus == .authorized)
        })
    }
}