//
//  OverlayWindow.swift
//  Text Extractor
//
//  Created by Jubayer Ahmed on 8/21/25.
//


import Cocoa

class OverlayWindow: NSWindow {

    init(screen: NSScreen) {
        super.init(
            contentRect: screen.frame,                   // covers the screen
            styleMask: [.borderless],                   // no title bar
            backing: .buffered,
            defer: false
        )

        self.isOpaque = false                           // allow transparency
        self.backgroundColor = NSColor.black.withAlphaComponent(0.3) // dimmed overlay
        self.level = .screenSaver                       // always on top
        self.ignoresMouseEvents = false                // allow mouse events
        self.makeKeyAndOrderFront(nil)                 // show window
        self.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
    }
    
    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { true }
}
