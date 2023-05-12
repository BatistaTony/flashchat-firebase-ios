//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        title = Constants.appName
        navigationItem.hidesBackButton = true
        
        loadMessagesFromDB()
    }
    
    func loadMessagesFromDB(){
        
        db.collection(Constants.FStore.collectionName)
            .order(by: Constants.FStore.dateField)
            .addSnapshotListener { snapshot, error in
            self.messages = []
            if let error {
                print("Error trying to get data from data base", error)
            }else{
                if let snapDocs = snapshot?.documents {
                    for doc in snapDocs {
                        let data  =  doc.data()
                        let sender   =  data[Constants.FStore.senderField] as? String
                        let msgBody = data[Constants.FStore.bodyField] as? String
                        
                        if let sender, let msgBody {
                            let newMessage = Message(sender: sender, body: msgBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                            
                        }
                        
                        
                    }
                }
            }
        }
        
    }
     
    @IBAction func sendPressed(_ sender: UIButton) {
        if let msgBody = messageTextfield.text, let msgSender = Auth.auth().currentUser?.email {
            
            db.collection(Constants.FStore.collectionName).addDocument(data: [
                Constants.FStore.senderField: msgSender,
                Constants.FStore.bodyField: msgBody,
                Constants.FStore.dateField: Date().timeIntervalSince1970
            ], completion: {error in
                if(error != nil){
                    print("Error sending the message")
                }else{
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                }
            })
            
        }
        
        
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }catch let signOuterror as NSError {
            print("\(signOuterror)")
        }
        
    }
    
}


extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message  = messages[indexPath.row]
        let cell  = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCellTableViewCell
       
        
        if  message.sender  == Auth.auth().currentUser?.email {
            cell.youAvatar.isHidden = false
            cell.avatar.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.lightPurple)
            cell.messageLabel.textColor = UIColor(named: Constants.BrandColors.purple)
        }else{
            cell.youAvatar.isHidden = true
            cell.avatar.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.purple)
            cell.messageLabel.textColor = UIColor(named: Constants.BrandColors.lightPurple)
        }
        
        
        cell.messageLabel?.text = message.body;
        
        
        
        
        return cell
    }
    
    
}


//extension ChatViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//    }
//}
