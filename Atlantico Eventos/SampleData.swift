//
//  SampleData.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 2/27/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import Foundation
import MessageKit
import CoreLocation

final internal class SampleData {
    
    static let shared = SampleData()
    
    private init() {}
    
    enum MessageTypes: UInt32, CaseIterable {
        case Text = 0
        case AttributedText = 1
        case Photo = 2
        case Video = 3
        case Emoji = 4
        case Location = 5
        case Url = 6
        case Phone = 7
        case Custom = 8
        
        static func random() -> MessageTypes {
            // Update as new enumerations are added
            let maxValue = Custom.rawValue
            
            let rand = arc4random_uniform(maxValue+1)
            return MessageTypes(rawValue: rand)!
        }
    }
    
let system = Sender(id: "000000", displayName: "System",   fotoUrl: Utilizador.fotoUrl, email: Utilizador.email, funcao: Utilizador.funcao, direcao: Utilizador.direcao, extencao: Utilizador.extencao )
    let nathan = Sender(id: "000001", displayName: "Nathan Tannar" ,  fotoUrl: Utilizador.fotoUrl, email: Utilizador.email, funcao: Utilizador.funcao, direcao: Utilizador.direcao, extencao: Utilizador.extencao )
    let steven = Sender(id: "000002", displayName: "Steven Deutsch" ,   fotoUrl: Utilizador.fotoUrl, email: Utilizador.email, funcao: Utilizador.funcao, direcao: Utilizador.direcao, extencao: Utilizador.extencao )
    let wu = Sender(id: "000003", displayName: "Wu Zhong" ,   fotoUrl: Utilizador.fotoUrl, email: Utilizador.email, funcao: Utilizador.funcao, direcao: Utilizador.direcao, extencao: Utilizador.extencao )
    
    lazy var senders = [nathan, steven, wu]
    
    var currentSender: Sender {
        return envio
    }
    
    var now = Date()
    
    let messageImages: [UIImage] = [#imageLiteral(resourceName: "211766-48.png"),#imageLiteral(resourceName: "211766-48.png") ]
    
    let emojis = [
        "👍",
        "😂😂😂",
        "👋👋👋",
        "😱😱😱",
        "😃😃😃",
        "❤️"
    ]
    
    let attributes = ["Font1", "Font2", "Font3", "Font4", "Color", "Combo"]
    
    let locations: [CLLocation] = [
        CLLocation(latitude: 37.3118, longitude: -122.0312),
        CLLocation(latitude: 33.6318, longitude: -100.0386),
        CLLocation(latitude: 29.3358, longitude: -108.8311),
        CLLocation(latitude: 39.3218, longitude: -127.4312),
        CLLocation(latitude: 35.3218, longitude: -127.4314),
        CLLocation(latitude: 39.3218, longitude: -113.3317)
    ]
    
    func attributedString(with text: String) -> NSAttributedString {
        let nsString = NSString(string: text)
        var mutableAttributedString = NSMutableAttributedString(string: text)
        let randomAttribute = Int(arc4random_uniform(UInt32(attributes.count)))
        let range = NSRange(location: 0, length: nsString.length)
        
        switch attributes[randomAttribute] {
        case "Font1":
            mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.preferredFont(forTextStyle: .body), range: range)
        case "Font2":
            mutableAttributedString.addAttributes([NSAttributedString.Key.font: UIFont.monospacedDigitSystemFont(ofSize: UIFont.systemFontSize, weight: UIFont.Weight.bold)], range: range)
        case "Font3":
            mutableAttributedString.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)], range: range)
        case "Font4":
            mutableAttributedString.addAttributes([NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)], range: range)
        case "Color":
            mutableAttributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], range: range)
        case "Combo":
            let msg9String = "Use .attributedText() to add bold, italic, colored text and more..."
            let msg9Text = NSString(string: msg9String)
            let msg9AttributedText = NSMutableAttributedString(string: String(msg9Text))
            
            msg9AttributedText.addAttribute(NSAttributedString.Key.font, value: UIFont.preferredFont(forTextStyle: .body), range: NSRange(location: 0, length: msg9Text.length))
            msg9AttributedText.addAttributes([NSAttributedString.Key.font: UIFont.monospacedDigitSystemFont(ofSize: UIFont.systemFontSize, weight: UIFont.Weight.bold)], range: msg9Text.range(of: ".attributedText()"))
            msg9AttributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)], range: msg9Text.range(of: "bold"))
            msg9AttributedText.addAttributes([NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)], range: msg9Text.range(of: "italic"))
            msg9AttributedText.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], range: msg9Text.range(of: "colored"))
            mutableAttributedString = msg9AttributedText
        default:
            fatalError("Unrecognized attribute for mock message")
        }
        
        return NSAttributedString(attributedString: mutableAttributedString)
    }
    
    func dateAddingRandomTime() -> Date {
        let randomNumber = Int(arc4random_uniform(UInt32(10)))
        if randomNumber % 2 == 0 {
            let date = Calendar.current.date(byAdding: .hour, value: randomNumber, to: now)!
            now = date
            return date
        } else {
            let randomMinute = Int(arc4random_uniform(UInt32(59)))
            let date = Calendar.current.date(byAdding: .minute, value: randomMinute, to: now)!
            now = date
            return date
        }
    }
    
    func randomMessageType() -> MessageTypes {
        let messageType = MessageTypes.random()
        
//        if !UserDefaults.standard.bool(forKey: "\(messageType)" + " Messages") {
//            return randomMessageType()
//        }
        
        return messageType
    }
    
    func randomMessage(allowedSenders: [Sender]) -> Message {
        
        let randomNumberSender = Int(arc4random_uniform(UInt32(allowedSenders.count)))
        
        let uniqueID = NSUUID().uuidString
        let sender = allowedSenders[randomNumberSender]
        let date = dateAddingRandomTime()
        
        switch randomMessageType() {
        case .Text:
            let randomSentence = Lorem.sentence()
            return Message(text: randomSentence, sender: sender, messageId: uniqueID, date: date)
        case .AttributedText:
            let randomSentence = Lorem.sentence()
            let attributedText = attributedString(with: randomSentence)
            return Message(attributedText: attributedText, sender: senders[randomNumberSender], messageId: uniqueID, date: date)
        case .Photo:
            let randomNumberImage = Int(arc4random_uniform(UInt32(messageImages.count)))
            let image = messageImages[randomNumberImage]
            return Message(image: image, sender: sender, messageId: uniqueID, date: date)
        case .Video:
            let randomNumberImage = Int(arc4random_uniform(UInt32(messageImages.count)))
            let image = messageImages[randomNumberImage]
            return Message(thumbnail: image, sender: sender, messageId: uniqueID, date: date)
        case .Emoji:
            let randomNumberEmoji = Int(arc4random_uniform(UInt32(emojis.count)))
            return Message(emoji: emojis[randomNumberEmoji], sender: sender, messageId: uniqueID, date: date)
        case .Location:
            let randomNumberLocation = Int(arc4random_uniform(UInt32(locations.count)))
            return Message(location: locations[randomNumberLocation], sender: sender, messageId: uniqueID, date: date)
        case .Url:
            return Message(text: "https://github.com/MessageKit", sender: sender, messageId: uniqueID, date: date)
        case .Phone:
            return Message(text: "123-456-7890", sender: sender, messageId: uniqueID, date: date)
        case .Custom:
            return Message(custom: "Someone left the conversation", sender: system, messageId: uniqueID, date: date)
        }
    }
    
    func getMessages(count: Int, completion: @escaping ([Message]) -> Void) {
        var messages: [Message] = []
        
        // Disable Custom Messages
        
       // db.collection("Conversas").getDocuments()
        db.collection("Conversas").document(currentSender.id).collection("Mensagens").document(destino.id).collection("Conversas").getDocuments()
        
        //db.collection("Conversas").getDocuments()
         
            {
                (querySnapshot, err) in
                
                if let err = err
                {
                    print("Error getting documents: \(err)");
                }
                else
                {
                    var count = 0
                    print("Dados retornados" , querySnapshot!.documents.count)
                    messages.removeAll()
                    
                    for document in querySnapshot!.documents {
                        
                        count += 1
                        print(" documento: \(document.documentID) => \(document.data())");
                        var codigo = ""
                        var enviadaPor = ""
                        var mensagem = ""
                        var data = Date()
                        var ids = ""
                        for (key,value) in document.data() {
                            if key == "enviadaPor"{
                                enviadaPor = value as! String
                            }
                            else if key == "mensagem"{
                                mensagem = value as! String
                            }
                            else if key == "data"{
                                data = (value as! NSDate) as Date
                                
                                
                            }
                            else if key == "id"{
                                ids = value as! String
                            }
                            else if key == "codigo"{
                                codigo = value as! String
                            }
                            
                            
                            print("\(key) = \(value)")
                        }
                        let wu = Sender(id: codigo, displayName: enviadaPor,  fotoUrl: "", email: "", funcao:"", direcao: "", extencao: "" )
                        
                        
                       // print("mensagens" , msg)
                         let msg = Message(text: mensagem, sender: wu, messageId: ids, date: data)
                         messages.append(msg)
                    }
                   let retorno =  messages.sorted(by: { $0.sentDate < $1.sentDate })
                      completion(retorno)
                    print("Count = \(messages.count)");
                }
        }
        
        
       
    }
    func getLastMessages(receptor: Sender, completion: @escaping (String) -> Void) {
        //print("Receptor" , receptor)
        var messages: [Message] = []
        var ultima = ""
        var origem  = ""
         let query = db.collection("Conversas").document(currentSender.id).collection("Mensagens").document(receptor.id).collection("Conversas")
        
      
               query.order(by: "data", descending: false).getDocuments(){
                (querySnapshot, err) in
                
                if let err = err
                {
                    print("Error getting documents: \(err)");
                }
                else
                {
                    var count = 0
                    print("Dados retornados" , querySnapshot!.documents.count)
                    messages.removeAll()
                    
                    for document in querySnapshot!.documents {
                        
                        count += 1
                        print(" documento: \(document.documentID) => \(document.data())");
                        var codigo = ""
                        var enviadaPor = ""
                        var mensagem = ""
                        var data = Date()
                        var ids = ""
                        for (key,value) in document.data() {
                            if key == "enviadaPor"{
                                enviadaPor = value as! String
                            }
                            else if key == "mensagem"{
                                mensagem = value as! String
                            }
                            else if key == "data"{
                                data = (value as! NSDate) as Date
                                
                                
                            }
                            else if key == "id"{
                                ids = value as! String
                            }
                            else if key == "codigo"{
                                codigo = value as! String
                            }
                            
                            
                            print("\(key) = \(value)")
                        }
                        let wu = Sender(id: codigo, displayName: enviadaPor ,   fotoUrl: Utilizador.fotoUrl, email: Utilizador.email, funcao: Utilizador.funcao, direcao: Utilizador.direcao, extencao: Utilizador.extencao )
                        if self.currentSender.id == codigo {
                            origem = "Você"
                        }else{
                            origem = enviadaPor
                        }
                        
                        // print("mensagens" , msg)
                        let msg = Message(text: mensagem, sender: wu, messageId: ids, date: data)
                        ultima = origem + " escreveu " + mensagem
                        messages.append(msg)
                    }
                    let retorno =  messages.sorted(by: { $0.sentDate < $1.sentDate })
                    let retorn = retorno[0].kind
                    completion(ultima)
                    print("Count = \(messages.count)");
                }
        }
        
        
        
    }
    
    func getUsers(count: Int, completion: @escaping ([Sender]) -> Void) {
        var usuarios: [Sender] = []
        
        // Disable Custom Messages
        
        // db.collection("Conversas").getDocuments()
        db.collection("Usuarios").getDocuments()
            
            //db.collection("Conversas").getDocuments()
            
            {
                (querySnapshot, err) in
                
                if let err = err
                {
                    print("Error getting documents: \(err)");
                }
                else
                {
                    var count = 0
                    print("Dados retornados" , querySnapshot!.documents.count)
                    usuarios.removeAll()
                    
                    for document in querySnapshot!.documents {
                        
                        count += 1
                        print(" documento: \(document.documentID) => \(document.data())");
                        var codigo = ""
                        var nome = ""
                        var localuser : user!
                        for (key,value) in document.data() {
                            if key == "numero"{
                                localuser.numero = value as! String
                            }
                            else if key == "nome"{
                                localuser.nome = value as! String
                            }
                            else if key == "fotourl"{
                                localuser.fotoUrl = value as! String
                            }
                           
                            
                            
                            
                            
                            print("\(key) = \(value)")
                        }
                        let user = Sender(id: localuser.numero, displayName: localuser.nome ,   fotoUrl: localuser.fotoUrl, email: "", funcao:"", direcao: "", extencao: "" )
                        
                        
                     
                       usuarios.append(user)
                    }
                    usuarios = usuarios.filter { $0.id != self.currentSender.id}
                    let retorno =  usuarios.sorted(by: { $0.id < $1.id })
                    completion(retorno)
                    //print("Count = \(messages.count)");
                }
        }
        
        
        
    }
    func getMinhasConversas(count: Int, completion: @escaping ([conversas]) -> Void) {
        var usuarios: [Sender] = []
        var listaConversas :[conversas] = []
        //var cnv = conversas()
        
    db.collection("Conversas").document(currentSender.id).collection("Mensagens").getDocuments(){
                (querySnapshot, err) in
                
                if let err = err
                {
                    print("Error getting documents: \(err)");
                }
                else
                {
                    var count = 0
                    print("Dados retornados" , querySnapshot!.documents.count)
                    usuarios.removeAll()
                    
                    for document in querySnapshot!.documents {
                        
                        count += 1
                        print("Conversas documento: \(document.documentID) => \(document.data())");
                        var codigo = "0000"
                        var nome = ""
                        var mensagem = "teste de escrita"
                        
                       
                        
                        
                        for (key,value) in document.data() {
                            if key == "Codigo"{
                                codigo = value as! String
                               // mensagem =  self.mostrarUltmaMensagem(id: codigo)
                            }
                            else if key == "Nome"{
                               print("Conversa",nome)
                                nome = value as! String
                            }
                            
                            
                            
                            print("\(key) = \(value)")
                        }
                        let user = Sender(id: codigo, displayName: nome ,  fotoUrl: "", email: "", funcao:"", direcao: "", extencao: "" )
                        let conversa = conversas(id: codigo, displayName: nome, mensagem: mensagem)
                        usuarios.append(user)
                       
                        listaConversas.append(conversa)
                    }
                   // let retorno =  usuarios.sorted(by: { $0.id < $1.id })
                    
                    completion(listaConversas)
                    //print("Count = \(messages.count)");
                }
        }
        
        
        
    }
    func mostrarUltmaMensagem(id : String) -> String {
         var retorno = ""
        let query = db.collection("Conversas").document(self.currentSender.id).collection("Mensagens").document(id).collection("Conversas")
        
        
        query.order(by: "data", descending: false).getDocuments(){
            (querySnapshot, err) in
            
            if let err = err
            {
                print("Error getting documents: \(err)");
            }
            else
            {
                var count = 0
                print("Dados retornados conv" , querySnapshot!.documents.count)
                
                for document in querySnapshot!.documents {
                    count += 1
                    var enviadaPor = ""
                    var mensagem = ""
                  
                    for (key,value) in document.data() {
                        if key == "enviadaPor"{
                            enviadaPor = value as! String
                        }
                        else if key == "mensagem"{
                            mensagem = value as! String
                        }
                        print("\(key) = \(value)")
                    }
                     retorno = enviadaPor + " escreveu " + mensagem
                   
                    
                }
               
            }
           
        }
         return retorno
    }
    func getAdvancedMessages(count: Int, completion: ([Message]) -> Void) {
        var messages: [Message] = []
        // Enable Custom Messages
        UserDefaults.standard.set(true, forKey: "Custom Messages")
        for _ in 0..<count {
            let message = randomMessage(allowedSenders: senders)
            messages.append(message)
        }
        completion(messages)
    }
    
    func getMessages(count: Int, allowedSenders: [Sender], completion: ([Message]) -> Void) {
        var messages: [Message] = []
        // Disable Custom Messages
        UserDefaults.standard.set(false, forKey: "Custom Messages")
        for _ in 0..<count {
            let message = randomMessage(allowedSenders: allowedSenders)
            messages.append(message)
        }
        completion(messages)
    }
    
    func getAvatarFor(sender: Sender) -> Avatar {
        let firstName = sender.displayName.components(separatedBy: " ").first
        let lastName = sender.displayName.components(separatedBy: " ").first
        let initials = "\(firstName?.first ?? "A")\(lastName?.first ?? "A")"
        switch sender {
        case nathan:
            return Avatar(image: #imageLiteral(resourceName: "orador"), initials: initials)
        case steven:
            return Avatar(image: #imageLiteral(resourceName: "orador"), initials: initials)
        case wu:
            return Avatar(image: #imageLiteral(resourceName: "orador"), initials: initials)
        case system:
            return Avatar(image: #imageLiteral(resourceName: "orador"), initials: "SS")
        default:
            return Avatar(image: #imageLiteral(resourceName: "orador"), initials: initials)
        }
    }
    
}
