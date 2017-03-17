//
//  EditViewModel.swift
//  RxSwiftDemo
//
//  Created by 家齊 on 2017/2/22.
//  Copyright © 2017年 張家齊. All rights reserved.
//

import Foundation
import RxSwift

struct EditViewModel {
    var name: Variable<String?>
    var email: Variable<String?>
    var genderSelected: Variable<Int>
    
    private let disposeBag = DisposeBag()
    
    init(user: User) {
        name = user.name
        email = user.emial
        genderSelected = Variable(user.gender.value.rawValue)
        genderSelected.asObservable().map({
            selectedIndex in
            return User.Gender(rawValue: selectedIndex) ?? .male
        }).bindTo(user.gender).addDisposableTo(disposeBag)
    }
}
