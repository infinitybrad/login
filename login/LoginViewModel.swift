//
//  LoginViewModel.swift
//  login
//
//  Created by brad on 2022/05/18.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    let emailObserver = BehaviorRelay<String>(value: "")
    let passwordObserver = BehaviorRelay<String>(value: "")

    var isValid: Observable<Bool> {
        return Observable.combineLatest(emailObserver, passwordObserver)
            .map { email, password in
                //print("Email : \(email), Password : \(password)")
                return !email.isEmpty && email.contains("@") && email.contains(".") && password.count > 0
            }
    }
}

