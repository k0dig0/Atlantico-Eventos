//
//  ClinicasViewModel.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 3/12/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import Foundation
import UIKit
public class ClinicasViewModel{
    var clinicas = [clinica_model]()
    init(token:String ,completion:@escaping () -> ()) {
        ClientAPI.verClinicas(token: token) { dados in
            self.clinicas = dados.Objecto
            completion()
        }
    }
    
    
    func numeroElemntos(section : Int) -> Int {
        return self.clinicas.count
    }
    func retornarCategoria(section : Int) -> String {
        return clinicas[section].clinica
    }
    
    func InformacaLinha(indexpath : NSIndexPath) -> NSMutableAttributedString {
        let atributos :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor.black , .font : UIFont(name: fontExtra,size: 16.0)!]
        let atributospreco :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor.lightGray , .font : UIFont(name: fontnegrito,size: 12.0)!]
        
        
        let produto = clinicas[indexpath.row].clinica
        let ocupacao = "\n" + clinicas[indexpath.row].endereco + "\n "  + clinicas[indexpath.row].contacto
        let retorno = NSMutableAttributedString(string: produto , attributes: atributos)
        let oucup = NSMutableAttributedString(string: ocupacao , attributes: atributospreco)
        retorno.append(oucup)
        return retorno
    }
    
   }
