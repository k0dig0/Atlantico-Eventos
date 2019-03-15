//
//  ResultadoBenificioViewController.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 3/12/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import UIKit

class ResultadoBenificioViewController: UIViewController {
var operacao = "Clinicas"
       var clinicas : ClinicasViewModel!
       var rotas : RotasViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        clinicas = ClinicasViewModel(token: "String", completion: {
            
        })
        rotas = RotasViewModel(token: "String", completion: {
            
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
extension ResultadoBenificioViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let bgimage = imageWithGradientView(startColor: Colors.nav1, endColor: Colors.nav2, size: CGSize(width: UIScreen.main.bounds.size.width, height: 1))
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "header", for: indexPath) as! GenericCollectionViewCell
            
            // cell.backgroundColor = Colors.green
            // let radius = cell.imgInfo.frame.height/2
            // cell.imgInfo.layer.cornerRadius = radius
            //cell.imgInfo.layer.masksToBounds = true
            cell.layer.cornerRadius = 4
           //
            cell.lblInfor.text = operacao
            
            cell.backgroundColor = UIColor(patternImage: bgimage!)
            return cell
        }else{
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resultado", for: indexPath as IndexPath) as! GenericCollectionViewCell
            if operacao == "Clinicas"{
                cell.lblInfor.attributedText = clinicas.InformacaLinha(indexpath: indexPath as NSIndexPath)
                
            }else if operacao == "Rotas"{
                 cell.lblInfor.attributedText = rotas.InformacaLinha(indexpath: indexPath as NSIndexPath)
            }
            
          
            
           
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
           
            
            if operacao == "Clinicas"{
               
                 return clinicas.numeroElemntos(section: 0)
                
            }else if operacao == "Rotas"{
             
                  return rotas.numeroElemntos(section: 0)
            }
            return 0
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
