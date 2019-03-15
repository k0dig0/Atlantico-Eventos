//
//  OradoresViewController.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 1/18/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import UIKit

class OradoresViewController: UIViewController {
 let Agenda = ["Jose Alberto" , "Carlos Cesar" , "Costa Alves" , "Correia Antonio" , "Contreiras Jorge" , "Gomes Jose" , "Adalberto Correia" , "Cosmes Carlos" , "Constancio Alberto"]
     var oradores : OradoresViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        oradores = OradoresViewModel(token: "String", completion: {
            
        })
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

}
extension OradoresViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let bgimage = imageWithGradientView(startColor: Colors.nav1, endColor: Colors.nav2, size: CGSize(width: UIScreen.main.bounds.size.width, height: 1))
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "header", for: indexPath) as! GenericCollectionViewCell
            
            // cell.backgroundColor = Colors.green
            // let radius = cell.imgInfo.frame.height/2
            // cell.imgInfo.layer.cornerRadius = radius
            //cell.imgInfo.layer.masksToBounds = true
            cell.layer.cornerRadius = 4
            cell.lblInfor.text = "Oradores"
            
            cell.backgroundColor = UIColor(patternImage: bgimage!)
            return cell
        }else{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "orador", for: indexPath as IndexPath) as! GenericCollectionViewCell
      
        cell.lblInfor.attributedText = oradores.InformacaLinha(indexpath: indexPath as NSIndexPath)
        cell.imgOrador.image = oradores.retornarImagem(indexpath: indexPath as NSIndexPath)
       // cell.imgOrador.layer.cornerRadius = 4
            let radius =  cell.imgOrador.frame.height/2
             cell.imgOrador.layer.cornerRadius = radius
            cell.imgOrador.layer.masksToBounds = true
            cell.imgOrador.layer.borderWidth = 2
            cell.imgOrador.layer.borderColor = UIColor(patternImage: bgimage!).cgColor
         //cell.lblInfor.text = "Hello World \nThis is a new line"
        cell.layer.cornerRadius = 4
        return cell
        
       }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        // self.hojeItemSelectedAtIndex(indice: indexPath.row)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
           return oradores.numeroElemntos(section: 0)
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: view.frame.width - 8 , height: view.frame.width / 2)
        }
        return CGSize(width: view.frame.width - 8 , height: view.frame.width / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == 0 {
            return UIEdgeInsets(top: 10, left: 8, bottom: 2, right: 8)
        }
        return UIEdgeInsets(top: 4, left: 4, bottom: 2, right: 4)
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
}
