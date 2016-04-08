//
//  User.swift
//  AutoLayoutV1.0
//
//  Created by 董林森 on 16/3/10.
//  Copyright © 2016年 Luke. All rights reserved.
//

import Foundation

struct User {
    var name: String
    var password: String
    var login: String
    var company: String
    
    static func login(login: String, password: String) -> User? {
        if let user = database[login] {
            if password == user.password {
                return user
            }
        }
        return  nil
    }
    
    static let database: Dictionary<String, User> = {
        var theDatabase = Dictionary<String, User>()
        for user in [
            User(name: "John Appleseed",password:"foo", login: "japple", company: "Apple"),
            User(name: "Madison Bumgarner", password: "foo", login:"mabum", company:"World Champion San Francisco Giant"),
            User(name: "StandfordUniversity", password: "foo", login: "stanford", company: "Stanford")
            ] {
                theDatabase[user.login] = user
        }
        return theDatabase
    }()
}