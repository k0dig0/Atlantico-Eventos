//
//  ProgramaViewController.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 3/12/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import UIKit

class ProgramaViewController: UIViewController {

    var programa : ProgramaViewModel!
    let Agenda = ["Abertura" , "Conferencia" , "Conferencia" , "Conferencia" , "Conferencia" , "Conferencia" , "Conferencia" , "Conferencia" , "Conferencia"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        programa = ProgramaViewModel(token: "String", completion: {
            
        })
        
    }
    
    
    
}


extension ProgramaViewController :   UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return programa.numeroElemntos()
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "header", for: indexPath) as! GenericCollectionViewCell
            
            // cell.backgroundColor = Colors.green
            // let radius = cell.imgInfo.frame.height/2
            // cell.imgInfo.layer.cornerRadius = radius
            //cell.imgInfo.layer.masksToBounds = true
            cell.layer.cornerRadius = 4
            cell.lblInfor.text = "Agenda da Reunião de Quadros"
            let bgimage = imageWithGradientView(startColor: Colors.nav1, endColor: Colors.nav2, size: CGSize(width: UIScreen.main.bounds.size.width, height: 1))
             cell.backgroundColor = UIColor(patternImage: bgimage!)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "programa", for: indexPath) as! GenericCollectionViewCell
            // cell.lblinfo.attributedText = .InformacaLinha(indexpath: indexPath as NSIndexPath)
            
            cell.lblInfor.attributedText = programa.InformacaLinha(indexpath: indexPath as NSIndexPath)
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 4
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: view.frame.width - 8 , height: view.frame.width / 2)
        }
        return CGSize(width: view.frame.width - 8 , height: view.frame.width / 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == 0 {
            return UIEdgeInsets(top: 10, left: 8, bottom: 2, right: 8)
        }
        return UIEdgeInsets(top: 4, left: 4, bottom: 2, right: 4)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
}
