//
//  VIHome_VolunteerHome.swift
//  DearFriend
//
//  Created by Vũ Minh Hà on 17/9/24.
//

import SwiftUI

struct StartView_VIMainSelection: View {
    @State var isShowStartView: Bool = true
    
    var body: some View {
        if (isShowStartView) {
            StartView(isShowStartView: $isShowStartView)
        } else {
            VIMainSelectionView(isShowStartView: $isShowStartView)
        }
    }
}

#Preview {
    StartView_VIMainSelection()
}
