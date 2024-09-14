//
//  User.swift
//  DearFriend
//
//  Created by Tony Nguyen on 2024-09-10.
//

import Foundation

struct User:Identifiable,Codable{
    let id: String
    let fullname: String
    let email: String
//    let ROLE: String
    var initials: String{
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
}

