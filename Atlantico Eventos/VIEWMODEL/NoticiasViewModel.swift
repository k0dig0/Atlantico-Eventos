//
//  NoticiasViewModel.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 1/21/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import Foundation
import UIKit
public class NoticiasViewModel{
   
    var noticias = [Noticia_model]()
    init(token:String ,completion:@escaping () -> ()) {
        ClientAPI.verNoticias(token: token) { dados in
            self.noticias = dados.Objecto
            completion()
        }
    }
    
    
    func numeroElemntos(section : Int) -> Int {
        return self.noticias.count
    }
    
    func InformacaLinha(indexpath : NSIndexPath) -> NSMutableAttributedString {
        let atributos :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor.black , .font : UIFont(name: fontsanBold,size: 12.0)!]
        let atributospreco :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor.black , .font : UIFont(name: fontnormal,size: 10.0)!]
        let descricao = NSMutableAttributedString(string: noticias[indexpath.row].descricao, attributes:atributospreco)
        
        let produto = noticias[indexpath.row].titulo  + "\n\n"
        let retorno = NSMutableAttributedString(string: produto.uppercased() , attributes: atributos)
       retorno.append(descricao)
        return retorno
    }
    
    func retornarProduto(linha: Int) -> Bool {
        
       // let prod :Produto_Model = Produto_Model (codigo: Produtos[linha].codigo, produto:  Produtos[linha].produto, familia: "Mercearia Seca", image: "Arroz", preco:  Produtos[linha].preco, quantidade: 1)
       //let res = core.AddCarrinho(produto: prod)
        //print("Resultado" , res)
        return false
    }
    
    func retornarImagem(indexpath : NSIndexPath) -> UIImage {
        
        let CAPA = noticias[indexpath.row].capa
        let image = UIImage(named: CAPA)
        return image!
    }}
