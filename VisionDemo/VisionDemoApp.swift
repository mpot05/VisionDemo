//
//  VisionDemoApp.swift
//  VisionDemo
//
//  Created by Michael Potter on 4/2/24.
//

import SwiftUI

@main
struct VisionDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.windowStyle(.volumetric)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
