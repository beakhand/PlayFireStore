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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    private var db: Firestore {
        return Firestore.firestore()
    }
    
}

//        textField.rx.text.asDriver().drive(Binder(self) { _, text in
//            print(text)
//        }).disposed(by: self.disposeBag)

