//
//  ClientAPI.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 1/21/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import Foundation
public class ClientAPI{
    static func verNoticias(token: String , completion: (RespostaNoticias)-> Void){
        
        let noticias = [Noticia_model(titulo: "Banco Millennium Atlântico lança máquina automática de depósitos" , capa: "capa" , descricao:"O banco Millennium Atlântico lançou a primeira máquina automática de depósitos, na sua rede comercial, que permite a realização de depósitos de notas de forma segura e cómoda, todos os dias da semana, adequando-se às exigências dos seus clientes." , tipo : "texto", url:""),Noticia_model(titulo: "Banco Millennium Atlântico lança máquina automática de depósitos" , capa: "capa" , descricao:"O banco Millennium Atlântico lançou a primeira máquina automática de depósitos, na sua rede comercial, que permite a realização de depósitos de notas de forma segura e cómoda, todos os dias da semana, adequando-se às exigências dos seus clientes." , tipo : "texto", url:""),Noticia_model(titulo: "Banco Millennium Atlântico lança máquina automática de depósitos" , capa: "capa" , descricao:"O banco Millennium Atlântico lançou a primeira máquina automática de depósitos, na sua rede comercial, que permite a realização de depósitos de notas de forma segura e cómoda, todos os dias da semana, adequando-se às exigências dos seus clientes." , tipo : "texto", url:"")]
        
        let resposta = RespostaNoticias(mesnsagem: "Sucesso", sucesso: true, Objecto: noticias)
        completion(resposta)
    }
    
    static func verEventos(token: String , completion: (RespostaEventos)-> Void){
        
        let eventos = [Evento_model(evento :"Encontro de Quadros" ,imagem: "banco" , data: "04-05-2019" ), Evento_model(evento :"Encontro de Quadros" ,imagem: "banco" , data: "04-05-2019" ), Evento_model(evento :"Encontro de Quadros" ,imagem: "banco" , data: "04-05-2019" ), Evento_model(evento :"Encontro de Quadros" ,imagem: "banco" , data: "04-05-2019" ),Evento_model(evento :"Encontro de Quadros" ,imagem: "banco" , data: "04-05-2019" )]
        
        let resposta = RespostaEventos(mesnsagem: "Sucesso", sucesso: true, Objecto: eventos)
        completion(resposta)
    }
    
    static func verPrograma(token: String , completion: (RespostaPrograma)-> Void){
        
    let programa = [Programa(evento:"Encontro de Quadros", periodo: "Inicio: 10h - Termino: 12h" ,orador : "Orador" ), Programa(evento:"Encontro de Quadros", periodo: "Inicio: 10h - Termino: 12h" ,orador : "Orador" ), Programa(evento:"Encontro de Quadros", periodo: "Inicio: 10h - Termino: 12h" ,orador : "Orador" ),Programa(evento:"Encontro de Quadros", periodo: "Inicio: 10h - Termino: 12h" ,orador : "Orador" ),Programa(evento:"Encontro de Quadros", periodo: "Inicio: 10h - Termino: 12h" ,orador : "Orador" ),Programa(evento:"Encontro de Quadros", periodo: "Inicio: 10h - Termino: 12h" ,orador : "Orador" ),Programa(evento:"Encontro de Quadros", periodo: "Inicio: 10h - Termino: 12h" ,orador : "Orador" ),Programa(evento:"Encontro de Quadros", periodo: "Inicio: 10h - Termino: 12h" ,orador : "Orador" )]
        
        let resposta = RespostaPrograma(mesnsagem: "Sucesso", sucesso: true, Objecto: programa)
        completion(resposta)
    }
    
    static func verOradores(token: String , completion: (RespostaOradores)-> Void){
        
        let oradores = [Orador(nome: "Ana Bela Marcos" , imagem:"orador" ,oucupacao: "Palestrante"  , descricao: "orador palestrante"), Orador(nome: "Ana Bela Marcos" , imagem:"orador" ,oucupacao: "Palestrante"  , descricao: "orador palestrante"), Orador(nome: "Ana Bela Marcos" , imagem:"orador" ,oucupacao: "Palestrante"  , descricao: "orador palestrante"),Orador(nome: "Ana Bela Marcos" , imagem:"orador" ,oucupacao: "Palestrante"  , descricao: "orador palestrante"),Orador(nome: "Ana Bela Marcos" , imagem:"orador" ,oucupacao: "Palestrante"  , descricao: "orador palestrante"),Orador(nome: "Ana Bela Marcos" , imagem:"orador" ,oucupacao: "Palestrante"  , descricao: "orador palestrante")]
        
        let resposta = RespostaOradores(mesnsagem: "Sucesso", sucesso: true, Objecto: oradores)
        completion(resposta)
    }
    
    static func verRotas(token: String , completion: (RespostaRotas)-> Void){
        
        
        let rotas = [rota_model(rota: "Linha 2 : Cidade Financeira - Centralidade do Sequele" , motorista : "Motorista 2" , contacto: "999234432") , rota_model(rota: "Linha 2 : Cidade Financeira - Centralidade do Sequele" , motorista : "Motorista 2" , contacto: "999234432"), rota_model(rota: "Linha 2 : Cidade Financeira - Centralidade do Sequele" , motorista : "Motorista 2" , contacto: "999234432"),rota_model(rota: "Linha 2 : Cidade Financeira - Centralidade do Sequele" , motorista : "Motorista 2" , contacto: "999234432"), rota_model(rota: "Linha 2 : Cidade Financeira - Centralidade do Sequele" , motorista : "Motorista 2" , contacto: "999234432")]
        
        let resposta = RespostaRotas(mesnsagem: "Sucesso", sucesso: true, Objecto: rotas)
        completion(resposta)
    }
    
    static func verClinicas(token: String , completion: (RespostaClinica)-> Void){
        
        
        let clinica = [clinica_model(clinica: "Sagrada Informatica" ,endereco: "Talatona" , contacto:"999999999" ) , clinica_model(clinica: "Sagrada Informatica" ,endereco: "Talatona" , contacto:"999999999" ), clinica_model(clinica: "Sagrada Informatica" ,endereco: "Talatona" , contacto:"999999999" ),clinica_model(clinica: "Sagrada Informatica" ,endereco: "Talatona" , contacto:"999999999" ),clinica_model(clinica: "Sagrada Informatica" ,endereco: "Talatona" , contacto:"999999999" ),clinica_model(clinica: "Sagrada Informatica" ,endereco: "Talatona" , contacto:"999999999" ),clinica_model(clinica: "Sagrada Informatica" ,endereco: "Talatona" , contacto:"999999999" ),clinica_model(clinica: "Sagrada Informatica" ,endereco: "Talatona" , contacto:"999999999" ),clinica_model(clinica: "Sagrada Informatica" ,endereco: "Talatona" , contacto:"999999999" )]
        
        let resposta = RespostaClinica(mesnsagem: "Sucesso", sucesso: true, Objecto: clinica)
        completion(resposta)
    }
    
    
}
