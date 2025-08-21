//
//  ContentView.swift
//  Text Extractor
//
//  Created by Jubayer Ahmed on 7/26/25.
//

import SwiftUI
import MASShortcut

// Bridge MASShortcutView into SwiftUI
struct ShortcutPicker: NSViewRepresentable {
    let defaultsKey: String

    func makeNSView(context: Context) -> MASShortcutView {
        let v = MASShortcutView()
        v.associatedUserDefaultsKey = defaultsKey
        return v
    }

    func updateNSView(_ nsView: MASShortcutView, context: Context) {}
}

struct ContentView: View {
    @State private var feedback: String = "Press a shortcut to see feedback"

    var body: some View {
        HStack(spacing: 10) {
            Text("Choose your hotkey:").font(.headline)
            ShortcutPicker(defaultsKey: "userHotkey")
        }
        .padding()
        .frame(width: 350, height: 100)
    }
}

#Preview {
    ContentView()
}
