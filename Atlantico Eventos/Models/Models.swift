//
//  Models.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 1/21/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import Foundation
import Firebase
import MessageKit
import FirebaseFirestore

struct Noticia_model {
   var titulo : String = ""
   var capa : String = ""
   var descricao : String = ""
   var tipo : String
    var url : String
}

struct Evento_model {
    var evento = ""
    var imagem = ""
    var data = ""
}

struct rota_model {
    var rota = ""
    var motorista = ""
    var contacto = ""
}
struct clinica_model {
    var clinica = ""
    var endereco = ""
    var contacto = ""
}

struct user :Codable {
    var numero :String
    var nome :String
    var email :String
    var tipo : String
    var extencao :String
    var direcao :String
    var responsavel :String
    var telemovel :String
    var token :String
    var fotoUrl :String
    var funcao :String
}

struct RespostaRotas {
    var mesnsagem : String
    var sucesso : Bool
    var Objecto : [rota_model]
    
}

struct RespostaClinica {
    var mesnsagem : String
    var sucesso : Bool
    var Objecto : [clinica_model]
    
}

struct RespostaEventos {
    var mesnsagem : String
    var sucesso : Bool
    var Objecto : [Evento_model]
    
}

struct RespostaNoticias {
    var mesnsagem : String
    var sucesso : Bool
    var Objecto : [Noticia_model]
    
}
struct RespostaPrograma {
    var mesnsagem : String
    var sucesso : Bool
    var Objecto : [Programa]
    
}
struct RespostaOradores {
    var mesnsagem : String
    var sucesso : Bool
    var Objecto : [Orador]
    
}
struct RespostaBiblioteca {
    var mesnsagem : String
    var sucesso : Bool
    var Objecto : [foto]
    
}



struct Orador {
    var nome = ""
    var imagem = ""
    var oucupacao = ""
    var descricao = ""
}
struct Programa {
    var evento = ""
    var periodo = ""
    var orador = ""
}
struct foto {
    var fotografia = ""
    var descricao = ""
}
