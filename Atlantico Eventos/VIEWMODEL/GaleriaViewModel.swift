//
//  GaleriaViewModel.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 3/12/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import Foundation
import UIKit
public class GaleriaViewModel{
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
        let atributos :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor.black , .font : UIFont(name: fontExtra,size: 12.0)!]
        let atributospreco :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor.lightGray , .font : UIFont(name: fontnegrito,size: 8.0)!]
        
        
        let produto =  " " + Eventos[indexpath.row].evento + "\n"
        let retorno = NSMutableAttributedString(string: produto , attributes: atributos)
          let ret = NSMutableAttributedString(string: Eventos[indexpath.row].data , attributes: atributospreco)
        retorno.append(ret)
        return retorno
    }
    
    func retornarImagem(indexpath : NSIndexPath) -> UIImage {
        
        let produto = Eventos[indexpath.row].imagem
        let image = UIImage(named: produto)
        return image!
    }}
