//
//  PerfilViewController.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 1/22/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import UIKit

class PerfilViewController: UIViewController {
let opt = ["Telefone" , "Chat" , "Email"]
    
    @IBOutlet weak var tvOutrosDados: UITableView!
    @IBOutlet weak var dadosCollection: UICollectionView!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var imgPerfil: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       lblInfo.attributedText = textoModificado(texto: "Augusto Firmino")
      imgPerfil.layer.borderWidth = 0.5
        imgPerfil.layer.masksToBounds = false
        imgPerfil.layer.borderColor = Colors.blue.cgColor
       imgPerfil.layer.cornerRadius = imgPerfil.frame.height/2
       imgPerfil.clipsToBounds = true
       // dadosCollection.delegate = self
       // dadosCollection.dataSource = self
        
        tvOutrosDados.delegate = self
        tvOutrosDados.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func textoModificado(texto : String) -> NSAttributedString {
        let atributospreco :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor.black , .font : UIFont(name: fontnegrito,size: 17.0)!]
        
        let info = NSMutableAttributedString(string:texto, attributes:atributospreco)
        return info
    }
}
extension PerfilViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "info", for: indexPath) as! GenericTableViewCell
        
        
        let atributos :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor.black , .font : UIFont(name: fontnormal,size: 12.0)!]
        let atributospreco :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor.black , .font : UIFont(name: fontnegrito,size: 12.0)!]
        
        let preco = NSMutableAttributedString(string:"Disruption LAB \n", attributes:atributos)
        
        let produto = "Augusto Firmino \n"
        let retorno = NSMutableAttributedString(string: produto , attributes:  atributospreco)
        retorno.append(preco)
        
        cell.lblinfo.attributedText = retorno
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    
}
extension PerfilViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "info", for: indexPath as IndexPath) as! GenericCollectionViewCell
        
        
        
        cell.imgOrador.layer.borderWidth = 0.5
        cell.imgOrador.layer.masksToBounds = false
        cell.imgOrador.layer.borderColor = Colors.blue.cgColor
        cell.imgOrador.layer.cornerRadius = cell.imgOrador.frame.height/2
        cell.imgOrador.clipsToBounds = true
        
        cell.lblInfor.text = opt[indexPath.row]
        // cell.imgOrador.image = produtos.retornarImagem(indexpath: indexPath as NSIndexPath)
        // cell.lblInformaca.text = "Hello World \nThis is a new line"
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "perfil") as? PerfilViewController {
            // let x = provincia.textoporprov(indexpath: indexPath as NSIndexPath)
            // viewController.provincia = x.string
            // viewController.lblProvincia.attributedText = x
            // viewController.img = provincia.converterImagem(indexpath: indexPath as NSIndexPath)
            self.navigationController?.pushViewController(viewController, animated: true)
            
            // self.inputViewController?.navigationController?.pushViewController(viewController, animated: true)
            //self.window?.rootViewController = viewController
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return opt.count
        
        
    }
    
    
}
