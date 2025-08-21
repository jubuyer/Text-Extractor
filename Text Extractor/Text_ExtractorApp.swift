//
//  Text_ExtractorApp.swift
//  Text Extractor
//
//  Created by Jubayer Ahmed on 7/26/25.
//

import SwiftUI
import MASShortcut

@main
struct Text_ExtractorApp: App {
    init() {
        // Binds persisted shortcut (if any) to action at launch.
        MASShortcutBinder.shared().bindShortcut(withDefaultsKey: "userHotkey") {
            print("Shortcut triggered")
            // TODO: call capture/OCR
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
