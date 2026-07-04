//
//  NotificationsListUi.swift
//  fu3l
//
//  Created by Aaron Anthony on 2023-10-09.
//  Copyright © 2021 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

@available(iOS 17.0, *)
public struct NotificationsUi: View {

    @ObservedObject var lnManager: FwNotifications
    @Environment(\.scenePhase) var scenePhase
    @State private var scheduleDate = Date()

    public init(lnManager: FwNotifications) {
        self.lnManager = lnManager
    }
    
    var hdr: some View {
        VStack(alignment: .leading) {
            
            Button("Interval Notification") {
                Task {
                    var localNotification = LocalNotification(identifier: UUID().uuidString,
                                                              title: "Some Title",
                                                              body: "some body",
                                                              timeInterval: 5,
                                                              repeats: false)
                    localNotification.subtitle = "This is a subtitle"
                    localNotification.bundleImageName = "Stewart.png"
                    localNotification.userInfo = ["nextView" : NextView.renew.rawValue]
                    localNotification.categoryIdentifier = "snooze"
                    await lnManager.schedule(localNotification: localNotification)
                }
            }
            .buttonStyle(.bordered)
            
            VStack(alignment: .leading) {
                DatePicker("Date", selection: $scheduleDate)
                
                Button("Calendar Notification") {
                    Task {
                        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: scheduleDate)
                        let localNotification = LocalNotification(identifier: UUID().uuidString,
                                                                  title: "Calendar Notification",
                                                                  body: "Some Body",
                                                                  dateComponents: dateComponents,
                                                                  repeats: false)
                        await lnManager.schedule(localNotification: localNotification)
                    }
                }
                .buttonStyle(.bordered)
            }
            .chartBackgroundMod()
            
            Button("Promo Offer") {
                Task {
                    let dateComponents = DateComponents(day: 1, hour: 10, minute: 0)
                    var localNotification = LocalNotification(identifier: UUID().uuidString,
                                                              title: "Special Promotion",
                                                              body: "Take advantage of the monthly promotion",
                                                              dateComponents: dateComponents,
                                                              repeats: true)
                    localNotification.bundleImageName = "Stewart.png"
                    localNotification.userInfo = ["nextView" : NextView.promo.rawValue]
                    await lnManager.schedule(localNotification: localNotification)
                }
            }
            .buttonStyle(.bordered)
        }
        .chartBackgroundMod()
        .headerBackgroundMod()
    }
    
    public var body: some View {
        NavigationView {
            VStack {
                if lnManager.isGranted {
                    List {
                        Section(header: hdr) {
                            ForEach(lnManager.pendingRequests, id: \.identifier) { request in
                                VerticalRowDetailText(headline: request.content.title, subHeadline: request.identifier)
                                .swipeActions {
                                    Button("Delete", role: .destructive) {
                                        lnManager.removeRequest(withIdentifier: request.identifier)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(.grouped)
                }
                else {
                    Button("Enable Notifications") {
                        lnManager.openSettings()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .sheet(item: $lnManager.nextView, content: { nextView in
                nextView.view()
            })
            .navigationTitle("Local Notifications")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { lnManager.clearRequests() }) {
                        Image(systemName: "clear")
                            .thumbnailImg(color: .white)
                    }
                }
            }
        }
        .task { try? await lnManager.requestAuthorization() }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                Task {
                    await lnManager.getCurrentSettings()
                    await lnManager.getPendingRequests()
                }
            }
        }
    }
}

@available(iOS 17.0, *)
struct NotificationsListView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsUi(lnManager: FwNotifications())
    }
}
