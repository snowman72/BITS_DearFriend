//
//  ProfileField.swift
//  DearFriend
//
//  Created by Vũ Minh Hà on 17/9/24.
//

import SwiftUI


struct ProfileFieldView: View {
    var field: ProfileField
    
    var body: some View {
        HStack {
            Image(systemName: field.icon)
                .foregroundColor(Color(red: 0, green: 0, blue: 1))
                .font(.system(size: 30))
                .frame(width: 50, height: 50)
                .background(Color.blue.opacity(0.1))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(field.label)
                    .font(.system(size: 21, weight: .semibold))
                Spacer().frame(height: 3)
                Text(field.value)
                    .font(.system(size: 18, weight: .medium))
            }.padding(.horizontal, 15)
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
        Spacer().frame(height: 20)
    }
}

#Preview {
    ProfileFieldView(field: ProfileField(icon: "", label: "", value: ""))
}
