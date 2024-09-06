import SwiftUI

struct HomePage: View {
    @State private var goToProfile = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Text("Temporary Visually Impaired HomePage")
                Text("Thay thế page này bằng user home page")
                Spacer().frame(height: 10)
                
                Button("View Profile") {
                    goToProfile = true
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
            }
            .navigationDestination(isPresented: $goToProfile) {
                ProfileContentView()
            }
            .navigationBarTitle("Profile", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .accentColor(.red)
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
