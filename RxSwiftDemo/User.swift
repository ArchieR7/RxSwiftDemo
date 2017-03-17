//
//  User.swift
//  RxSwiftDemo
//
//  Created by 家齊 on 2017/2/22.
//  Copyright © 2017年 張家齊. All rights reserved.
//

import Foundation
import RxSwift

struct User {
    enum Gender: Int {
        case male = 0
        case female
    }
    var name: Variable<String?> = Variable(String())
    var emial: Variable<String?> = Variable(String())
    var gender: Variable<Gender> = Variable(.male)
}
