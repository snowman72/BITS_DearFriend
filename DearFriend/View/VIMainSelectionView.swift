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
            ZStack {
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text("Choose a mode")
                        .font(.largeTitle)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding()
                        
                    
                    Spacer()
                    
                    NavigationLink(destination: RecognitionView(initialMode: .object), tag: CameraViewModel.RecognitionMode.object, selection: $selectedMode) {
                        Button("See Object") {
                            selectedMode = .object
                        }
                        .frame(maxWidth: .infinity, minHeight: 50, alignment: .center)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.pink)
                        .cornerRadius(10)
                        .font(.title3.bold())
                    }
                    .padding(.horizontal)
                    
                    
                    NavigationLink(destination: RecognitionView(initialMode: .text), tag: CameraViewModel.RecognitionMode.text, selection: $selectedMode) {
                        Button("See Text") {
                            selectedMode = .text
                        }
                        .frame(maxWidth: .infinity, minHeight: 50, alignment: .center)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.cyan)
                        .cornerRadius(10)
                        .font(.title3.bold())
                    }
                    .padding(.horizontal)
                    
                    
                    NavigationLink("Emergency Alert") {
                        ConversationView()
                    }
                    .frame(maxWidth: .infinity, minHeight: 50, alignment: .center)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(10)
                    .font(.title3.bold())
                    .padding(.horizontal)
                    
                    
                    NavigationLink("Join Call") {
                        CallView()
                    }
                    .frame(maxWidth: .infinity, minHeight: 50, alignment: .center)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.indigo)
                    .cornerRadius(10)
                    .font(.title3.bold())
                    .padding(.horizontal)
                }
                .padding(.vertical, 100)
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
