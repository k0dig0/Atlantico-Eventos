//
//  BenificiosViewController.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 3/12/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import UIKit

class BenificiosViewController: UIViewController {
let benificios = ["SAÚDE","TRANSPORTE", "ENTRETENIMENTO"]
    override func viewDidLoad() {
        super.viewDidLoad()

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
extension BenificiosViewController  : UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  benificios.count
    }
    func corner(p1: CGFloat) -> CGFloat {
        return p1 / 2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "benificio", for: indexPath) as! GenericCollectionViewCell
        
        cell.lblInfor.text = benificios[indexPath.row]
        
        cell.layer.cornerRadius = 4
        if indexPath.row == 0 {
            let bgimage = imageWithGradientView(startColor: Colors.veryDarkGrey, endColor: Colors.blue, size: CGSize(width: UIScreen.main.bounds.size.width, height: 1))
            cell.backgroundColor = UIColor(patternImage: bgimage!)
            
        }else if indexPath.row == 1 {
            let bgimage = imageWithGradientView(startColor: Colors.nav1, endColor: Colors.nav2, size: CGSize(width: UIScreen.main.bounds.size.width, height: 1))
            cell.backgroundColor = UIColor(patternImage: bgimage!)
        }else{
            let bgimage = imageWithGradientView(startColor: Colors.green1, endColor: Colors.blue1, size: CGSize(width: UIScreen.main.bounds.size.width, height: 1))
              cell.backgroundColor = UIColor(patternImage: bgimage!)
        }
        
       
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "resultado") as? ResultadoBenificioViewController {
            if indexPath.row == 0 {
                viewController.operacao = "Clinicas"
            }else {
                viewController.operacao = "Rotas"
            }
            //.categoria = categorias.retornarCategoria(section : indexPath.row)
            self.navigationController?.pushViewController(viewController, animated: true)
            
            
        }
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        
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
