//
//  OradoresViewModel.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 3/11/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//


import Foundation
import UIKit
public class OradoresViewModel{
    var oradores = [Orador]()
    init(token:String ,completion:@escaping () -> ()) {
        ClientAPI.verOradores(token: token) { dados in
            self.oradores = dados.Objecto
            completion()
        }
    }
    
    
    func numeroElemntos(section : Int) -> Int {
        return self.oradores.count
    }
    func retornarCategoria(section : Int) -> String {
        return oradores[section].nome
    }
    
    func InformacaLinha(indexpath : NSIndexPath) -> NSMutableAttributedString {
        let atributos :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor.black , .font : UIFont(name: fontExtra,size: 16.0)!]
        let atributospreco :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor.lightGray , .font : UIFont(name: fontnegrito,size: 12.0)!]
        
        
        let produto = oradores[indexpath.row].nome
        let ocupacao = "\n" + oradores[indexpath.row].oucupacao
        let retorno = NSMutableAttributedString(string: produto , attributes: atributos)
            let oucup = NSMutableAttributedString(string: ocupacao , attributes: atributospreco)
        retorno.append(oucup)
        return retorno
    }
    
    func retornarImagem(indexpath : NSIndexPath) -> UIImage {
        
        let produto = oradores[indexpath.row].imagem
        let image = UIImage(named: produto)
        return image!
    }}
