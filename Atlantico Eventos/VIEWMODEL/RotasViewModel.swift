//
//  RotasViewModel.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 3/12/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import Foundation
import UIKit
public class RotasViewModel{
    var rotas = [rota_model]()
    init(token:String ,completion:@escaping () -> ()) {
        ClientAPI.verRotas(token: token) { dados in
            self.rotas = dados.Objecto
            completion()
        }
    }
    
    
    func numeroElemntos(section : Int) -> Int {
        return self.rotas.count
    }
    func retornarCategoria(section : Int) -> String {
        return rotas[section].rota
    }
    
    func InformacaLinha(indexpath : NSIndexPath) -> NSMutableAttributedString {
        let atributos :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor.black , .font : UIFont(name: fontExtra,size: 12.0)!]
        let atributospreco :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor.lightGray , .font : UIFont(name: fontnegrito,size: 10.0)!]
        
        
        let produto = rotas[indexpath.row].rota
        let ocupacao = "\nMotorista " + rotas[indexpath.row].motorista + "\nContacto "  + rotas[indexpath.row].contacto
        let retorno = NSMutableAttributedString(string: produto , attributes: atributos)
        let oucup = NSMutableAttributedString(string: ocupacao , attributes: atributospreco)
        retorno.append(oucup)
        return retorno
    }
    
}
