//
//  ObjectRecognitionView.swift
//  DearFriend
//
//  Created by Vũ Minh Hà on 22/8/24.
//

import SwiftUI

struct ObjectRecognitionView: View {
    
    @StateObject private var viewModel: CameraViewModel
    
    init(initialMode: CameraViewModel.RecognitionMode) {
        _viewModel = StateObject(wrappedValue: CameraViewModel(initialMode: initialMode))
    }
    
    var body: some View {
        ZStack {
            if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding()
            } else {
                
                // Camera preview
                CameraPreview(session: viewModel.session)
                    .edgesIgnoringSafeArea(.all)
                
                // Recognition overlay (Object or Text)
                VStack {
                    Spacer()
                    Text(viewModel.currentMode ==  .object ? viewModel.identifiedObject : viewModel.recognizedText)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.bottom)
                }
            }
        }
        .onAppear {
            viewModel.checkCameraAuthorization()
        }
        .onDisappear { // the user goes back to main menu
            viewModel.stopAllProcesses()
        }
    }
}

