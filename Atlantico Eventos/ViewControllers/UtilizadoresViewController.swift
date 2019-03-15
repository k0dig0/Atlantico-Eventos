//
//  UtilizadoresViewController.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 2/28/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import UIKit
import MessageKit
import MessageInputBar
import Firebase
import FirebaseDatabase

class UtilizadoresViewController: UIViewController {
     private var messageListener: ListenerRegistration?
    @IBOutlet weak var clgeral: UICollectionView!
    var conversas : ConversasViewModel!
    var utlizadores : UsersViewModel!
    @IBOutlet weak var tvUser: UITableView!
    var userList: [Sender] = []
    //let system = Sender(id: "000000", displayName: "System")
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clgeral.dataSource = self
        self.clgeral.delegate = self
       carregarUsers()
        verificarNovas()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        carregarUsers()
    }
    func currentSender() -> Sender {
        return envio
    }
    func verificarNovas()  {
        
        messageListener = db.collection("Conversas").document(currentSender().id).collection("Mensagens").addSnapshotListener { (querySnapshot, error) in
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
                    self.carregarUsers()
                }
                else if (diff.type == .modified) {
                    print("Modificado")
                }
                else if (diff.type == .removed) {
                    
                }
            })
        }
    }
    
    func carregarUsers() {
        self.conversas = ConversasViewModel(token: "String", completion: {
            print("Dados conversas" , self.conversas.listaConversas)
            DispatchQueue.main.async {
                
                self.clgeral.reloadData()
                
            }
        })
        self.utlizadores = UsersViewModel(token: "String", completion: {
            DispatchQueue.main.async {
                
                self.clgeral.reloadData()
                print("Dados")
            }
        })
    }
    func carregarMinhasConversas() {
        DispatchQueue.global(qos: .userInitiated).async {
            let count = 1
            SampleData.shared.getUsers(count: count) { messages in
                DispatchQueue.main.async {
                    self.userList = messages
                    self.tvUser.reloadData()
                    // self.messagesCollectionView.scrollToBottom()
                    print("mensagens",messages.count)
                }
            }
        }
    }
    func do_table_refresh()
    {
        DispatchQueue.main.async { [unowned self] in
          //  self.tvCarrinho.reloadData()
          //  self.total = self.produtos.retornarTotal()
            // next = min (paginactrl.currentPage + 1,homeViewModel.numberOfItemsInSection(section: 0) - 1)
           // self.lbltotalCompras.text = converterValor(custo: self.total)
        }
        
        return
        
    }
    

}
extension UtilizadoresViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "utilizador") as! GenericTableViewCell
        cell.lblinfo.text = userList[indexPath.row].displayName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        destino = userList[indexPath.row]
        performSegue(withIdentifier: "conversa", sender: nil)
    }
}

extension UtilizadoresViewController :   UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
             return conversas.listaConversas.count
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "usuarios", for: indexPath) as! UsersCollectionViewCell
            cell.setup(data: utlizadores)
            cell.delegates = self
           // cell.backgroundColor = Colors.green
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "conversas", for: indexPath) as! GenericCollectionViewCell
            cell.lblInfor.attributedText = conversas.InformacaLinha(indexpath: indexPath as NSIndexPath)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: view.frame.width, height: view.frame.width / 4)
        }
        return CGSize(width: view.frame.width , height: view.frame.width / 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1 {
            return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        }
        return UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        destino =  conversas
            .retornarUser(linha: indexPath.row)
          print("Destino conversa" ,destino.id )
        performSegue(withIdentifier: "conversa", sender: nil)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
}
extension UtilizadoresViewController : GenericoDelegate{
    func catItemSelectedAtIndex(_ index: Int32) {
        
    }
    
   
    func recomendadosItemSelectedAtIndex(_ index: Int32) {
        
    }
    
    
    
    func destaqueItemSelectedAtIndex(_ index: Int32) {
       let numero = index
      destino =  utlizadores.retornarUser(linha: Int(numero))
        print("Destino User" ,destino.id )
      performSegue(withIdentifier: "conversa", sender: nil)
    }
    
    
    
    
}
