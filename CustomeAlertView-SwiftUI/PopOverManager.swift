//
//  PopOverManager.swift
//  CustomAlertView-SwiftUI
//
//  Created by Akshaya Gunnepalli on 05/04/25.
//

import Foundation
import UIKit
import SwiftUI

/// A singleton manager responsible for displaying and removing custom popover overlays.
class PopOverView {
    
    /// Shared instance of `PopOverView`.
    static let shared = PopOverView()
    
    /// Retrieves the current key window of the application.
    private func getActiveWindow() -> UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }

    /// Presents a SwiftUI view as an overlay on top of the key window.
    /// - Parameter overlayView: The SwiftUI view to present.
    func presentOverlay<Content: View>(_ overlayView: Content) {
        guard let keyWindow = getActiveWindow() else { return }
        
        let hostingController = UIHostingController(rootView: overlayView)
        hostingController.view.backgroundColor = .clear
        hostingController.view.frame = keyWindow.bounds
        hostingController.view.tag = 999  // Unique tag for identification
        
        keyWindow.addSubview(hostingController.view)
    }
    
    /// Removes the overlay view from the key window.
    func removeOverlay() {
        guard let keyWindow = getActiveWindow() else { return }
        
        keyWindow.subviews
            .filter { $0.tag == 999 }
            .forEach { $0.removeFromSuperview() }
    }
}

// MARK: - Blur Background Modifier

/// A view modifier that adds a blurred background behind content.
struct SheetOverlayModifier: ViewModifier {
    let backgroundColor: Color = .blue.opacity(0.8)

    func body(content: Content) -> some View {
        ZStack {
            Rectangle()
                .fill(backgroundColor)
                .ignoresSafeArea()
                .blur(radius: 5)
            
            content
        }
    }
}

// MARK: - View Extension

extension View {
    /// Applies a custom blurred background to the view.
    func addBlurBackground() -> some View {
        self.modifier(SheetOverlayModifier())
    }
}
