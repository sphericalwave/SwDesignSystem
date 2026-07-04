//
//  LocalNotificationManager.swift
//  fu3l
//
//  Created by Aaron Anthony on 2023-10-09.
//  Copyright © 2021 SphericalWaveSoftware. All rights reserved.
//

import Foundation

public struct LocalNotification {
    public init(identifier: String,
                  title: String,
                  body: String,
                  timeInterval: Double,
                  repeats: Bool) {
        self.identifier = identifier
        self.scheduleType = .time
        self.title = title
        self.body = body
        self.timeInterval = timeInterval
        self.dateComponents = nil
        self.repeats = repeats
    }

    public init(identifier: String,
                  title: String,
                  body: String,
                  dateComponents: DateComponents,
                  repeats: Bool) {
        self.identifier = identifier
        self.scheduleType = .calendar
        self.title = title
        self.body = body
        self.timeInterval = nil
        self.dateComponents = dateComponents
        self.repeats = repeats
    }
    
    enum ScheduleType {
        case time, calendar
    }
    
    var identifier: String
    var scheduleType: ScheduleType
    var title: String
    var body: String
    var subtitle: String?
    var bundleImageName: String?
    var userInfo: [AnyHashable : Any]?
    var timeInterval: Double?
    var dateComponents: DateComponents?
    var repeats: Bool
    var categoryIdentifier: String?
}
