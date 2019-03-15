//
//  UsersViewModel.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 3/1/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import Foundation
import MessageKit
import UIKit
public class UsersViewModel{
    
    var userList = [Sender]()
    init(token:String ,completion:@escaping () -> ()) {
        SampleData.shared.getUsers(count: 0) { messages in
            DispatchQueue.main.async {
                self.userList = messages
              
              completion()
            }
        }
    }
    
    
    func numeroElemntos(section : Int) -> Int {
        print("Contactos",self.userList.count)
        return self.userList.count
    }
    
    func InformacaLinha(indexpath : NSIndexPath) -> NSMutableAttributedString {
        let atributos :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor.black , .font : UIFont(name: fontsanBold,size: 8.0)!]
        let atributospreco :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor.black , .font : UIFont(name: fontnormal,size: 12.0)!]
       
        let produto = userList[indexpath.row].displayName
        let retorno = NSMutableAttributedString(string: produto.uppercased() , attributes: atributos)
        //retorno.append(descricao)
        return retorno
    }
    
    func retornarUser(linha: Int) -> Sender {
        
       
        return userList[linha]
    }
    
    func retornarImagem(indexpath : NSIndexPath) -> UIImage {
        
        let CAPA = "orador"
        let image = UIImage(named: CAPA)
        return image!
    }}
