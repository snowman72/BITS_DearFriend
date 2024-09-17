//
//  VolunteerHome_ProfileView.swift
//  DearFriend
//
//  Created by Vũ Minh Hà on 17/9/24.
//

import SwiftUI

struct VolunteerHome_ProfileView: View {
    @State var isShowProfileView: Bool = false
    
    var body: some View {
        if (isShowProfileView) {
            ProfileView(isShowProfileView: $isShowProfileView)
        } else {
            VolunteerHome(isShowProfileView: $isShowProfileView)
        }
    }
}

#Preview {
    VolunteerHome_ProfileView()
}
