//
//  ContentView.swift
//  DearFriend
//
//  Created by Vũ Minh Hà on 20/8/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        StartView_VIMainSelection()
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}
