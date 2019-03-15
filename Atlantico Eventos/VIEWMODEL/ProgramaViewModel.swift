//
//  ProgramaViewModel.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 3/12/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import Foundation
import UIKit
public class ProgramaViewModel{
    var programa = [Programa]()
    init(token:String ,completion:@escaping () -> ()) {
        ClientAPI.verPrograma(token: token) { dados in
            self.programa = dados.Objecto
            completion()
        }
    }
    
    
    func numeroElemntos() -> Int {
        return self.programa.count
    }
    func retornarCategoria(section : Int) -> String {
        return programa[section].evento
    }
    
    func InformacaLinha(indexpath : NSIndexPath) -> NSMutableAttributedString {
        let atributos :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor.black , .font : UIFont(name: fontExtra,size: 16.0)!]
        let atributospreco :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor.lightGray , .font : UIFont(name: fontnegrito,size: 12.0)!]
        
        
        let produto = programa[indexpath.row].evento
        let ocupacao = "\n" + programa[indexpath.row].periodo
        let retorno = NSMutableAttributedString(string: produto , attributes: atributos)
        let oucup = NSMutableAttributedString(string: ocupacao , attributes: atributospreco)
        retorno.append(oucup)
        return retorno
    }
    
    }
