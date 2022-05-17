//
//  LoginViewController.swift
//  login
//
//  Created by brad on 2022/05/18.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var warningButton: UIButton!
    
    
    private let bag = DisposeBag()
    let viewModel = LoginViewModel()

    let userEmail = "waynehills@gmail.co"
    let userPassword = "su283242"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        setupControl()
    }
    
    private func initViews()
    {

        idTextField.layer.borderWidth = 0
        passwordTextField.layer.borderWidth = 0
        
        self.loginButton.layer.cornerRadius = 48 / 2
        self.signupButton.layer.cornerRadius = 48 / 2
        self.signupButton.layer.borderColor = UIColor.init(rgb: 0x6E54F6).cgColor
        self.signupButton.layer.borderWidth  = 1
        
        self.warningButton.layer.cornerRadius = 10
        
        self.warningLabel.isHidden = true
        self.warningButton.isHidden = true
        
    }
    
    func setupControl() {
        idTextField.rx.text
            .orEmpty
            .bind(to: viewModel.emailObserver)
            .disposed(by: bag)
        
        
        passwordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.passwordObserver)
            .disposed(by: bag)
        
        idTextField.rx.text.asDriver()
            .drive(onNext:{ [weak self] _ in
                self?.warningLabel.isHidden = true
                self?.warningButton.isHidden = true
                
                self?.idTextField.layer.borderColor = UIColor.init(rgb: 0x7450FF).cgColor
                self?.idTextField.layer.borderWidth = 1
                self?.passwordTextField.layer.borderWidth = 0
            })
            .disposed(by: bag)
        
        passwordTextField.rx.text.asDriver()
            .drive(onNext:{ [weak self] _ in
                self?.warningLabel.isHidden = true
                self?.warningButton.isHidden = true
                
                self?.passwordTextField.layer.borderColor = UIColor.init(rgb: 0x7450FF).cgColor
                self?.passwordTextField.layer.borderWidth = 1
                self?.idTextField.layer.borderWidth = 0
            })
            .disposed(by: bag)
        

        viewModel.isValid.bind(to: loginButton.rx.isEnabled)
            .disposed(by: bag)

        viewModel.isValid
            .map { $0 ? 1 : 0.3 }
            .bind(to: loginButton.rx.alpha)
            .disposed(by: bag)

        loginButton.rx.tap.subscribe(
            onNext: { [weak self] _ in
                if self?.userEmail == self?.viewModel.emailObserver.value &&
                    self?.userPassword == self?.viewModel.passwordObserver.value {
                    let alert = UIAlertController(title: "성공", message: "환영합니다", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "확인", style: .default)
                    alert.addAction(ok)
                    self?.present(alert, animated: true, completion: nil)
                } else {
                    
                    self?.warningLabel.isHidden = false
                    self?.warningButton.isHidden = false
                    
                    self?.idTextField.layer.borderColor = UIColor.init(rgb: 0xFF5F0A).cgColor
                    self?.idTextField.layer.borderWidth = 1
                    
                    self?.passwordTextField.layer.borderColor = UIColor.init(rgb: 0xFF5F0A).cgColor
                    self?.passwordTextField.layer.borderWidth = 1
                    

                }
            }
        ).disposed(by: bag)
    }
    
}
