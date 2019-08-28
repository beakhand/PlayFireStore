//
//  ViewController.swift
//  PlayFirestore
//
//  Created by beakhand on 2019/06/13.
//  Copyright © 2019 beakhand. All rights reserved.
//

import UIKit
import Firebase
import ExpandableLabel
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: ExpandableLabel!
    @IBOutlet weak var exLabel: ExpandableLabel!
    @IBOutlet weak var textField: UITextField!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.numberOfLines = 1
        label.collapsed = true
        label.collapsedAttributedLink = NSAttributedString(string: "read more")
        
        exLabel.text = "あいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおかきくけこかきくけこかきくけこ"
        exLabel.numberOfLines = 2
        exLabel.expandedAttributedLink = NSAttributedString(string: "Read Less")
        exLabel.collapsedAttributedLink = NSAttributedString(string: "Read More")

        DispatchQueue.main.async { [weak self] in

            //self?.exLabel.collapsedAttributedLink = NSAttributedString(string: "Read More")
            
        }
        
        //let textField: UITextField
        //textField.rx.
        textField.rx.text.asDriver().drive(Binder(self) { _, text in
            print(text)
        }).disposed(by: self.disposeBag)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //label.collapsedAttributedLink = NSAttributedString(string: "Read More")
        //label.numberOfLines = 2
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
//            self.label.addTrailing(with: "...", moreText: "read more", moreTextFont: self.label.font, moreTextColor: self.label.textColor)
        })

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
    
    private func listenForUsers() {
        db.collection("users")
            .whereField("born", isLessThan: 1900)
        
            .addSnapshotListener {querySnapshot, error in
                
        }
        
    }
}
