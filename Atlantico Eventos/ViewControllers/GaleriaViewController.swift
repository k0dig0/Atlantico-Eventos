//
//  GaleriaViewController.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 3/12/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import UIKit

class GaleriaViewController: UIViewController {

    var eventos : GaleriaViewModel!
    // var produtos : ProdutosViewModel!
    var procurar = UISearchBar()
    //  let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.hidesSearchBarWhenScrolling = false
        eventos = GaleriaViewModel(token: "String", completion: {
            
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


extension GaleriaViewController  : UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  eventos.numeroElemntos(section: 0)
    }
    func corner(p1: CGFloat) -> CGFloat {
        return p1 / 2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foto", for: indexPath) as! GenericCollectionViewCell
        
        cell.lblInfor.attributedText = eventos.InformacaLinha(indexpath: indexPath as NSIndexPath)
        cell.imgOrador.image = eventos.retornarImagem(indexpath: indexPath as NSIndexPath)
        cell.imgOrador.layer.cornerRadius = 4
        // let radius = cell.imageView.frame.height/2
        
        cell.layer.cornerRadius = 4
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "programa") as? ProgramaViewController {
            
            //.categoria = categorias.retornarCategoria(section : indexPath.row)
            self.navigationController?.pushViewController(viewController, animated: true)
            
            
        }
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       
        
        return CGSize(width: view.frame.width - 16 , height: view.frame.width / 1.5)
        
        
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
