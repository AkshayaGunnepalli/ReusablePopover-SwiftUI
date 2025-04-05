//
//  ContentView.swift
//  CustomAlertView-SwiftUI
//
//  Created by Akshaya Gunnepalli on 05/04/25.
//

import SwiftUI


/// The main content view of the app.
struct ContentView: View {
    
    var body: some View {
        VStack {
            // Button to show the custom popover
            Button(action: {
                PopOverView.shared.presentOverlay(
                    popOverStyle()
                )
            }) {
                Text("Show PopOver")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red)
                    )
            }
        }
        .padding()
    }
    
    // MARK: - Custom PopOver View
    
    /// Custom popover style that will be presented on button tap.
    /// - Returns: A view representing the custom popover content.
    @ViewBuilder
    private func popOverStyle() -> some View {
        ZStack {
            GroupBox {
                VStack(spacing: 30) {
                    Text("Common PopOver View")
                        .font(.headline)
                    
                    Divider()
                    
                    // Close button
                    Text("Close")
                        .frame(width: 150, height: 50)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(Capsule())
                        .onTapGesture {
                            PopOverView.shared.removeOverlay()
                        }
                }
                .padding()
                .frame(width: 300, height: 300)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .addBlurBackground() // Apply custom blur background modifier
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
