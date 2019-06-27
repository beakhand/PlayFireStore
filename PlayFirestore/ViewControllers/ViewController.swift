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
    
    @IBAction func onAddDocumentButtonTap(_ sender: Any) {
        addDocument()
    }
    
    @IBAction func onGetDocumentButtonTap(_ sender: Any) {
        getDocument()
    }
    
    
    private var db: Firestore {
        return Firestore.firestore()
    }
    
    private func addDocument() {
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
    
    private func getDocument() {
        db.collection("users").getDocuments() { querySnapshot, err in
            if let err = err {
                print("Error ge document \(err)")
            } else {
                guard let query = querySnapshot else { return }
                query.documents.forEach { doc in
                    print("get document id -> \(doc.documentID) : data -> \(doc.data())")
                }
            }
            
        }
        
        
        
        
    }
}

