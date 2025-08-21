//
//  SelectionView.swift
//  Text Extractor
//
//  Created by Jubayer Ahmed on 8/21/25.
//


import Cocoa

class SelectionView: NSView {

    private var startPoint: NSPoint?
    private var currentRect: NSRect?
    
    // Mouse released: notify completion
    var onComplete: ((NSRect) -> Void)?
    var onCancel: (() -> Void)?

    override var acceptsFirstResponder: Bool { true }

    override func keyDown(with event: NSEvent) {
        if event.keyCode == 53 { // 53 = Escape
            onCancel?()
        } else {
            super.keyDown(with: event)
        }
    }

    // Dim overlay
    override func draw(_ dirtyRect: NSRect) {
        NSColor.black.withAlphaComponent(0.2).setFill()
        bounds.fill() // fill the whole screen

        if let rect = currentRect {
            NSColor.clear.set()
            rect.fill(using: .destinationOut) // undim selection rectangle

            NSColor.white.setStroke()
            let path = NSBezierPath(rect: rect)
            path.lineWidth = 1
            path.stroke()
        }
    }
    
    // Show crosshair cursor
    override func resetCursorRects() {
        addCursorRect(bounds, cursor: .crosshair)
    }

    // Track mouse down
    override func mouseDown(with event: NSEvent) {
        startPoint = event.locationInWindow
        currentRect = NSRect.zero
        needsDisplay = true
    }

    // Track mouse drag
    override func mouseDragged(with event: NSEvent) {
        guard let start = startPoint else { return }
        let end = event.locationInWindow
        currentRect = NSRect(
            x: min(start.x, end.x),
            y: min(start.y, end.y),
            width: abs(start.x - end.x),
            height: abs(start.y - end.y)
        )
        needsDisplay = true
    }

    override func mouseUp(with event: NSEvent) {
        if let rect = currentRect, rect.width > 2, rect.height > 2  {
            onComplete?(rect)
        } else {
            onCancel?()
        }
    }
}
