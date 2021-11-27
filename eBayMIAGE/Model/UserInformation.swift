//
//  UserInformation.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 27/11/2021.
//

import Foundation

class UserInformation: Codable {
    var token: String
    var exp: Int
    var id: Int
    
    public init() {
        token = ""
        exp = 0
        id = 0
    }
    
    var informationFilled: Bool {
        return (token != "" && exp != 0 && id != 0)
    }
}
