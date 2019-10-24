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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var keyHideView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        /*
        messageTextField.rx.text.asDriver()
            .drive(Binder(self) { me, text in
                print(text)
            }).disposed(by: self.disposeBag)
        */
        
        let keyHideViewTapGesture = UITapGestureRecognizer()
        keyHideViewTapGesture.rx.event.asDriver()
            .drive(Binder(self) { me, _ in
                me.messageTextField.endEditing(true)
            }).disposed(by: disposeBag)

        keyHideView.addGestureRecognizer(keyHideViewTapGesture)
    
        NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillShowNotification)
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(Binder(self) { me, info in
                guard let userInfo = info.userInfo else { return }
                guard let rect = userInfo["UIKeyboardFrameEndUserInfoKey"] as? CGRect else { return }

                
            }).disposed(by: disposeBag)
        
        NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillHideNotification)
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(Binder(self) {_, _ in
                print("hide keybrd")
            }).disposed(by: disposeBag)

    }
    
}


