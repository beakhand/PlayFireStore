//
//  ViewController.swift
//  PlayFirestore
//
//  Created by beakhand on 2019/06/13.
//  Copyright © 2019 beakhand. All rights reserved.
//

import UIKit
import Firebase



class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onButtonTap(_ sender: Any) {
        addDocument()
    }
    
    func addDocument() {
        let db = Firestore.firestore()
        var ref: DocumentReference?
        ref = db.collection("users").addDocument(data: [
            "first": "Aba",
            "last": "Lovelace",
            "born": 1815
        ]) { err in
            if let err = err {
                print("Error add document \(err)")
            } else {
                let id = ref.map { $0.documentID } ?? "id none"
                print("Success add document - ID -> \(id)")
            }
        }
    }
}

