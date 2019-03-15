//
//  EventosViewController.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 3/11/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import UIKit

class EventosViewController: BaseViewController {
    var eventos : EventosViewModel!
   // var produtos : ProdutosViewModel!
    var procurar = UISearchBar()
    //  let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        navigationItem.hidesSearchBarWhenScrolling = false
        eventos = EventosViewModel(token: "String", completion: {
            
        })
        
        //searchController = UISearchController(searchResultsController: nil)
       // searchController.searchBar.delegate = self
      //  mostaraSearch(searchController: searchController)
       // self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        // Do any additional setup after loading the view.
       // actulizarBadge()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension EventosViewController  : UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  eventos.numeroElemntos(section: 0)
    }
    func corner(p1: CGFloat) -> CGFloat {
        return p1 / 2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celula", for: indexPath) as! GenericCollectionViewCell
        
        cell.lblInfor.attributedText = eventos.InformacaLinha(indexpath: indexPath as NSIndexPath)
        cell.imgOrador.image = eventos.retornarImagem(indexpath: indexPath as NSIndexPath)
        cell.imgOrador.layer.cornerRadius = 4
       // let radius = cell.imageView.frame.height/2
//        cell.btnAgenda.layer.cornerRadius = corner(p1: cell.btnAgenda.frame.height)
//        cell.btnAgenda.layer.masksToBounds = true
//        cell.btnOradores.layer.cornerRadius = corner(p1: cell.btnOradores.frame.height)
//        cell.btnOradores.layer.masksToBounds = true
        //cell.vwBack.layer.cornerRadius = 4
        cell.btnOradores.addTarget(self, action:
            #selector(EventosViewController.mostrarOradores(sender:)), for: .touchUpInside)
        cell.btnAgenda.addTarget(self, action:
            #selector(EventosViewController.mostrarPrograma(sender:)), for: .touchUpInside)
        cell.btnOradores.tag = indexPath.row
        cell.btnAgenda.tag = indexPath.row
        cell.layer.cornerRadius = 4
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "bliblioteca") as? GaleriaViewController {

           //.categoria = categorias.retornarCategoria(section : indexPath.row)
           self.navigationController?.pushViewController(viewController, animated: true)


        }
    }
    @objc func mostrarOradores(sender: UIButton)  {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "orador") as? OradoresViewController {
            
            //.categoria = categorias.retornarCategoria(section : indexPath.row)
            self.navigationController?.pushViewController(viewController, animated: true)
            
            
        }
    }
    @objc func mostrarPrograma(sender: UIButton)  {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "programa") as? ProgramaViewController {
            
            //.categoria = categorias.retornarCategoria(section : indexPath.row)
            self.navigationController?.pushViewController(viewController, animated: true)
            
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if eventos.Eventos.count == 1{
           return CGSize(width: view.frame.width , height: view.frame.height / 1.4 )
        }else if eventos.Eventos.count == 2{
            return CGSize(width: view.frame.width  , height: view.frame.height / 3 )
        }
        
        return CGSize(width: view.frame.width - 16 , height: view.frame.width / 2)
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        return UIEdgeInsets(top: 2, left: 8, bottom: 2, right:8)
    }
    
}
