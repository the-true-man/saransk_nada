//
//  saransk2025_2App.swift
//  saransk2025_2
//
//  Created by Евгений Михайлов on 03.04.2025.
//

import SwiftUI

@main
struct saransk2025_2App: App {
    @State var isLaunchComplete = false
    var body: some Scene {
        WindowGroup {
            if ProcessInfo.processInfo.arguments.contains("-signin") {
                LoginView()
            }
            else {
                if !isLaunchComplete {
                    LaunchView(onCompletion: {
                        isLaunchComplete = true
                    })
                } else {
                    OnboardView()
                }
            }
        }
    }
}
