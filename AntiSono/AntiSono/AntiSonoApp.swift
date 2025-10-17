//
//  AntiSonoApp.swift
//  AntiSono
//
//  Created by Lucas Vasconcellos Côrtes on 10/8/25.
//

import SwiftUI

@main
struct AntiSonoApp: App {
    @UIApplicationDelegateAdaptor var appDelegate: CustomAppDelegate
    
    var body: some Scene {
        WindowGroup {
            CloudKitUser()
            ContentView()
                .onAppear {
                    appDelegate.app = self
                }
        }
    }
}
