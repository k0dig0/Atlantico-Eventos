//
//  EventosViewModel.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 3/11/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import Foundation
import UIKit
public class EventosViewModel{
    var Eventos = [Evento_model]()
    init(token:String ,completion:@escaping () -> ()) {
        ClientAPI.verEventos(token: token) { dados in
            self.Eventos = dados.Objecto
            completion()
        }
    }
    
    
    func numeroElemntos(section : Int) -> Int {
        return self.Eventos.count
    }
    func retornarCategoria(section : Int) -> String {
        return Eventos[section].evento
    }
    
    func InformacaLinha(indexpath : NSIndexPath) -> NSMutableAttributedString {
        let atributos :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor.black , .font : UIFont(name: fontExtra,size: 16.0)!]
        let atributospreco :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor.red , .font : UIFont(name: fontnegrito,size: 12.0)!]
        
        
        let produto = " " + Eventos[indexpath.row].evento
        let retorno = NSMutableAttributedString(string: produto , attributes: atributos)
        
        return retorno
    }
    
    func retornarImagem(indexpath : NSIndexPath) -> UIImage {
        
        let produto = Eventos[indexpath.row].imagem
        let image = UIImage(named: produto)
        return image!
    }}
