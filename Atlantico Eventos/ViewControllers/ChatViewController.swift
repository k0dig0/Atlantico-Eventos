//
//  ChatViewController.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 2/27/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//


import UIKit
import MessageKit
import MessageInputBar
import UIKit
import MessageKit
import MessageInputBar
import Firebase
import FirebaseDatabase
import UserNotifications

/// A base class for the example controllers

class ChatViewController: MessagesViewController, MessagesDataSource {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    //
    var ref: DatabaseReference!

      private var messageListener: ListenerRegistration?
    var messageList: [Message] = []
    
    let refreshControl = UIRefreshControl()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      // CarregarMensagens()
        
        configureMessageCollectionView()
        configureMessageInputBar()
        loadFirstMessages()
        title = destino.displayName.uppercased()
        ref = Database.database().reference()
       
       
        verificarNovas()
    }
    
    func verificarNovas()  {
        messageListener = db.collection("Conversas").document(currentSender().id).collection("Mensagens").document(destino.id).collection("Conversas").addSnapshotListener { (querySnapshot, error) in
            /// Check if snapshot is not nil
            guard let snapshot = querySnapshot else {                print("Error: \(error.debugDescription)")
                return
            }
            /// Check if snapshot has documents and not empty
            guard snapshot.documents.last != nil else {
                // The collection is empty.
                return
            }
            //
            /// This is the on change listner
            snapshot.documentChanges.forEach({ (diff) in
                print(diff.document.data())
                if (diff.type == .added) {
                    print("Adicionado")
                    self.loadFirstMessages()
                }
                else if (diff.type == .modified) {
                    print("Modificado")
                }
                else if (diff.type == .removed) {
                    
                }
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         self.loadFirstMessages()
       
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        MockSocket.shared.disconnect()
    }
    
    func loadFirstMessages() {
        DispatchQueue.global(qos: .userInitiated).async {
            let count = 1
            SampleData.shared.getMessages(count: count) { messages in
                DispatchQueue.main.async {
                    self.messageList = messages
                    self.messagesCollectionView.reloadData()
                    self.messagesCollectionView.scrollToBottom()
                   print("mensagens",messages.count)
                }
            }
        }
    }
    
    @objc
    func loadMoreMessages() {
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 1) {
            SampleData.shared.getMessages(count: 20) { messages in
                DispatchQueue.main.async {
                    self.messageList.insert(contentsOf: messages, at: 0)
                    self.messagesCollectionView.reloadDataAndKeepOffset()
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    func configureMessageCollectionView() {
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messageCellDelegate = self
        
        scrollsToBottomOnKeyboardBeginsEditing = true // default false
        maintainPositionOnKeyboardFrameChanged = true // default false
        
        messagesCollectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(loadMoreMessages), for: .valueChanged)
    }
    
    func configureMessageInputBar() {
        messageInputBar.delegate = self
        messageInputBar.inputTextView.tintColor = .blue
        messageInputBar.sendButton.tintColor = .blue
    }
    
    // MARK: - Helpers
    
    func insertMessage(_ message: Message) {
        messageList.append(message)
        // Reload last section to update header/footer labels and insert a new one
        messagesCollectionView.performBatchUpdates({
            messagesCollectionView.insertSections([messageList.count - 1])
            if messageList.count >= 2 {
                messagesCollectionView.reloadSections([messageList.count - 2])
            }
        }, completion: { [weak self] _ in
            if self?.isLastSectionVisible() == true {
                self?.messagesCollectionView.scrollToBottom(animated: true)
            }
        })
    }
    
    func isLastSectionVisible() -> Bool {
        
        guard !messageList.isEmpty else { return false }
        
        let lastIndexPath = IndexPath(item: 0, section: messageList.count - 1)
        
        return messagesCollectionView.indexPathsForVisibleItems.contains(lastIndexPath)
    }
    
    // MARK: - MessagesDataSource
    
    func currentSender() -> Sender {
        return envio
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messageList.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messageList[indexPath.section]
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        if indexPath.section % 3 == 0 {
            
            return NSAttributedString(string: MessageKitDateFormatter.shared.string(from: message.sentDate), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        }
        return nil
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)])
    }
    
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        
        let dateString = formatter.string(from: message.sentDate)
        return NSAttributedString(string: dateString, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption2)])
    }
    
}

// MARK: - MessageCellDelegate

extension ChatViewController: MessageCellDelegate {
    
    func didTapAvatar(in cell: MessageCollectionViewCell) {
        print("Avatar tapped")
    }
    
    func didTapMessage(in cell: MessageCollectionViewCell) {
        print("Message tapped")
    }
    
    func didTapCellTopLabel(in cell: MessageCollectionViewCell) {
        print("Top cell label tapped")
    }
    
    func didTapMessageTopLabel(in cell: MessageCollectionViewCell) {
        print("Top message label tapped")
    }
    
    func didTapMessageBottomLabel(in cell: MessageCollectionViewCell) {
        print("Bottom label tapped")
    }
    
    func didTapAccessoryView(in cell: MessageCollectionViewCell) {
        print("Accessory view tapped")
    }
    
}

// MARK: - MessageLabelDelegate

extension ChatViewController: MessageLabelDelegate {
    
    func didSelectAddress(_ addressComponents: [String: String]) {
        print("Address Selected: \(addressComponents)")
    }
    
    func didSelectDate(_ date: Date) {
        print("Date Selected: \(date)")
    }
    
    func didSelectPhoneNumber(_ phoneNumber: String) {
        print("Phone Number Selected: \(phoneNumber)")
    }
    
    func didSelectURL(_ url: URL) {
        print("URL Selected: \(url)")
    }
    
    func didSelectTransitInformation(_ transitInformation: [String: String]) {
        print("TransitInformation Selected: \(transitInformation)")
    }
    
}

// MARK: - MessageInputBarDelegate

extension ChatViewController: MessageInputBarDelegate {
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        
        for component in inputBar.inputTextView.components {
            
           
            // Add a new document with a generated ID
            if   SalvarMensagem(texto: text, enviadaPor: currentSender().displayName, data: Date(), Id: UUID().uuidString){
                
                  print("teste" , text)
            }
          
        }
        inputBar.inputTextView.text = String()
        messagesCollectionView.scrollToBottom(animated: true)
    }
    func SalvarMensagem(texto: String , enviadaPor: String , data : Date , Id : String) -> Bool {
       
       SalvarMensagemDestino(texto: texto, enviadaPor: currentSender().displayName, data: Date(), Id: UUID().uuidString)
        var retorno : Bool = false
         let citiesRefNome = db.collection("Conversas").document(currentSender().id)
        citiesRefNome.setData(["Nome" :currentSender().displayName  , "Codigo" : currentSender().id])
       
       // let citiesRef = db.collection("Conversas").document(currentSender().displayName)
        let novoCaminho = db.collection("Conversas").document(currentSender().id).collection("Mensagens").document(destino.id)
         novoCaminho.setData([ "Codigo" :destino.id , "Nome" :destino.displayName ])
        
        novoCaminho.collection("Conversas").document().setData([
            "mensagem": texto,
            "enviadaPor": enviadaPor,
            "data": data,
            "id" :Id,
            "codigo" : currentSender().id
            ]){ err in
            if let err = err {
                print("Error adding document: \(err)")
                retorno = false
            } else {
               // print("Document added with ID: \(citiesRef.document)")
                  retorno =  true
            }
        }
        return retorno
    }
    func SalvarMensagemDestino(texto: String , enviadaPor: String , data : Date , Id : String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        var retorno : Bool = false
   
        let citiesRefNome = db.collection("Conversas").document(destino.id)
        citiesRefNome.setData(["Nome" :destino.displayName  , "Codigo" : destino.id])
        
        // let citiesRef = db.collection("Conversas").document(currentSender().displayName)
        let novoCaminho = db.collection("Conversas").document(destino.id).collection("Mensagens").document(currentSender().id)
        novoCaminho.setData([ "Codigo" :currentSender().id , "Nome" :currentSender().displayName ])
        
        novoCaminho.collection("Conversas").document().setData([
            "mensagem": texto,
            "enviadaPor": enviadaPor,
            "data": data,
            "id" :Id,
            "codigo" : currentSender().id
        ]){ err in
            if let err = err {
                print("Error adding document: \(err)")
                retorno = false
            } else {
                // print("Document added with ID: \(citiesRef.document)")
                retorno =  true
            }
        }
        return retorno
    }
    
    func CarregarMensagens()  {
        
        db.collection("Conversas").getDocuments()
            {
                (querySnapshot, err) in
                
                if let err = err
                {
                    print("Error getting documents: \(err)");
                }
                else
                {
                    var count = 0
                    for document in querySnapshot!.documents {
                        count += 1
                        print("\(document.documentID) => \(document.data())");
                        
                        for (key,value) in document.data() {
                            print("\(key) = \(value)")
                        }
                    }
                    
                    print("Count = \(count)");
                }
        }
        }
    }
    

