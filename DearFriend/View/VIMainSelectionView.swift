//
//  VIMainSelectionView.swift
//  DearFriend
//
//  Created by Vũ Minh Hà on 25/8/24.
//

import SwiftUI

struct VIMainSelectionView: View {
    @State private var selectedMode: CameraViewModel.RecognitionMode?
    @Binding var isShowStartView: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Button(action: {
                        isShowStartView = true
                    }, label: {
                        Circle()
                            .frame(width: 80)
                            .foregroundColor(Color.clear)
                            .padding()
                            .overlay {
                                Image(systemName: "house.fill")
                                    .font(.system(size: 55))
                                    .foregroundColor(.white)
                                    
                            }
                    })
                    .offset(x: -140)
    
                    Text("Choose a mode")
                        .font(.largeTitle)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.top, 50)
                        .foregroundColor(.black)
                        
                    
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
                        .font(.title2.bold())
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
                        .font(.title2.bold())
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
                    .font(.title2.bold())
                    .padding(.horizontal)
                    
                    
                    NavigationLink("Call a Volunteer") {
                        CallView()
                    }
                    .frame(maxWidth: .infinity, minHeight: 50, alignment: .center)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.indigo)
                    .cornerRadius(10)
                    .font(.title2.bold())
                    .padding(.horizontal)
                }
                .padding(.bottom, 80)
                .padding(.top, 50)
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
    VIMainSelectionView(isShowStartView: .constant(true))
}
