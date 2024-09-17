//
//  ProfileField.swift
//  DearFriend
//
//  Created by Vũ Minh Hà on 17/9/24.
//

import Foundation

struct ProfileField: Identifiable {
    let id = UUID()
    let icon: String
    let label: String
    var value: String
}
