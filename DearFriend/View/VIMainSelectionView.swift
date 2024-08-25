//
//  VIMainSelectionView.swift
//  DearFriend
//
//  Created by Vũ Minh Hà on 25/8/24.
//

import SwiftUI

struct VIMainSelectionView: View {
    @State private var selectedMode: CameraViewModel.RecognitionMode?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Choose a mode")
                    .font(.largeTitle)
                    .padding()

                NavigationLink(destination: ObjectRecognitionView(initialMode: .object), tag: CameraViewModel.RecognitionMode.object, selection: $selectedMode) {
                    Button("See Object") {
                        selectedMode = .object
                    }
                    .buttonStyle(LargeButtonStyle())
                }

                NavigationLink(destination: ObjectRecognitionView(initialMode: .text), tag: CameraViewModel.RecognitionMode.text, selection: $selectedMode) {
                    Button("See Text") {
                        selectedMode = .text
                    }
                    .buttonStyle(LargeButtonStyle())
                }
            }
        }
    }
}

struct LargeButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

#Preview {
    VIMainSelectionView()
}
