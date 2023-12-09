//
//  UserModel.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 09.12.2023.
//

import Foundation

protocol UserDataProtocol {
    var email: String? { get set }
    var password: String? { get set }
    var birthday: String? { get set }
    var name: String? { get set }
}

struct UserData {
    var email: String?
    var password: String?
    var birthday: String? = ""
    var name: String? = ""
}
