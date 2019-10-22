//
//  ViewController.swift
//  PlayFirestore
//
//  Created by beakhand on 2019/06/13.
//  Copyright © 2019 beakhand. All rights reserved.
//

import UIKit
import Firebase
import RxCocoa
import RxSwift

class ViewController: UIViewController {    
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        bind()
    }
    
    
    private var db: Firestore {
        return Firestore.firestore()
    }
    
    
    private func bind() {
        sendButton.rx.tap.asDriver()
            .drive(Binder(self) { me, _ in
                print(me.messageTextField.text ?? "")
            
            }).disposed(by: disposeBag)
        
        
        //rx.key
        
        messageTextField.rx.text.asDriver().drive(Binder(self) { _, text in
            print(text)
        }).disposed(by: self.disposeBag)

    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

