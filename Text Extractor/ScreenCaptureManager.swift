//
//  ScreenCaptureManager.swift
//  Text Extractor
//
//  Created by Jubayer Ahmed on 8/21/25.
//


import Cocoa

class ScreenCaptureManager {
    static let shared = ScreenCaptureManager()

    private var overlayWindow: OverlayWindow?
    private var selectionView: SelectionView?
    private var overlayIsActive = false

    func showOverlay(completion: @escaping (CGRect) -> Void) {
        guard !overlayIsActive else { return }
        overlayIsActive = true

        guard let screen = NSScreen.main else { return }
        
        overlayWindow = OverlayWindow(screen: screen)
        selectionView = SelectionView(frame: screen.frame)

        selectionView?.onComplete = { rect in
            // Convert NSRect to CG coordinate system
            let flippedRect = CGRect(
                x: rect.origin.x,
                y: screen.frame.height - rect.origin.y - rect.height,
                width: rect.width,
                height: rect.height
            )
            completion(flippedRect)
            DispatchQueue.main.async {
                self.hideOverlay() // cleanup on success
            }
        }
        
        selectionView?.onCancel = {
            DispatchQueue.main.async {
                self.hideOverlay()   // cleanup on Esc key
            }
        }

        overlayWindow?.contentView = selectionView
        overlayWindow?.makeFirstResponder(selectionView)
    }
    
    private func hideOverlay() {
        DispatchQueue.main.async {
            self.overlayWindow?.orderOut(nil)
            self.overlayWindow = nil
            self.selectionView = nil
            self.overlayIsActive = false
        }
    }
}
