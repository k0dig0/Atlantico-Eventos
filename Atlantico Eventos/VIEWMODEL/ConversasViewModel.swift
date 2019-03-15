//
//  ConversasViewModel.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 3/1/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import Foundation
import MessageKit
import UIKit
public class ConversasViewModel{
    var listaConversas = [conversas]()
    var userList = [Sender]()
   var ultimaMensagem = ""
    init(token:String ,completion:@escaping () -> ()) {
        SampleData.shared.getMinhasConversas(count: 0) { messages in
           print("Conversas" , messages)
           // self.listaConversas = messages
            for m in messages{
                let u = Sender(id: m.id, displayName: m.displayName,  fotoUrl: "", email: "", funcao:"", direcao: "", extencao: "" )
              
                SampleData.shared.getLastMessages(receptor: u) { connversa in
                   // print("Conversas" , messages)
                   let cv = conversas(id: m.id, displayName: m.displayName, mensagem: connversa)
                   // m.mensagem = connversa
                    self.listaConversas.append(cv)
                     print("Helner",cv)
                  completion()
                    
                    
                }
            }
            
          
           
    }
    
     }
    func numeroElemntos(section : Int) -> Int {
        return self.listaConversas.count
    }
    
    func InformacaLinha(indexpath : NSIndexPath) -> NSMutableAttributedString {
       
        let atributos :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor.black , .font : UIFont(name: fontsanBold,size: 12.0)!]
        let atributosdescri :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor.lightGray , .font : UIFont(name: fontnormal,size: 10.0)!]
        
        
        
        let produto = listaConversas[indexpath.row].displayName + "\n"
        let retorno = NSMutableAttributedString(string: produto.uppercased() , attributes: atributos)
        let descricao = NSMutableAttributedString(string: listaConversas[indexpath.row].mensagem, attributes: atributosdescri)
        retorno.append(descricao)
        return retorno
    }
    
    func retornarUser(linha: Int) -> Sender {
        let user = Sender(id: listaConversas[linha].id, displayName: listaConversas[linha].displayName  ,  fotoUrl: "", email: "", funcao:"", direcao: "", extencao: "" )
        
        return user
    }
    
    func retornarImagem(indexpath : NSIndexPath) -> UIImage {
        
        let CAPA = "noticias[indexpath.row].capa"
        let image = UIImage(named: CAPA)
        return image!
    }}
