//
//  ViewController.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 1/18/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import UIKit
import UserNotifications
class ViewController: BaseViewController {

    @IBOutlet weak var tvFeed: UITableView!
    @IBOutlet weak var lblinfo: UILabel!
    @IBOutlet weak var imgQR: UIImageView!
    @IBOutlet weak var vwBack: UIView!
    var noticias : NoticiasViewModel!
    let Agenda = ["Abertura" , "Conferencia" , "Conferencia" , "Conferencia" , "Conferencia" , "Conferencia" , "Conferencia" , "Conferencia" , "Conferencia"]
    override func viewDidLoad() {
        super.viewDidLoad()
//        tvFeed.dataSource = self
//        tvFeed.delegate = self
//        // Do any additional setup after loading the view, typically from a nib.
//        vwBack.layer.cornerRadius = 8
// vwBack.layer.shadowColor = UIColor.white.cgColor
//        vwBack.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//      vwBack.layer.shadowRadius = 12.0
//      vwBack.layer.shadowOpacity = 0.1
//        // self.navigationController?.navigationBar.applyNavigationGradient(colors: [ Colors.blue2,Colors.blue2 ])
//        imgQR.image = generateQRCode(from: "Atlantico")
//        lblinfo.text = "Ola! Atlantico ! \nNumero Colaborador: 0000 \nDirecção: Disruption Lab"
        noticias = NoticiasViewModel(token: "String", completion: {
            
        })
        addSlideMenuButton()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) {
            (granted, error) in
            if granted {
                print("yes")
              
            } else {
                print("No")
            }
        }
       //   self.notificacao()
    }
   
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
   }
extension ViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticias.numeroElemntos(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath) as! GenericTableViewCell
        cell.vwbBack.layer.cornerRadius = 8
        //cell.vwBack.layer.borderWidth = 0.1
        // cell.vwBack.layer.borderColor = UIColor.black.cgColor
        cell.vwbBack.layer.shadowColor = UIColor.white.cgColor
        cell.vwbBack.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cell.vwbBack.layer.shadowRadius = 12.0
        cell.vwbBack.layer.shadowOpacity = 0.1
        
        cell.imgInfo.layer.cornerRadius = 8
        cell.imgInfo.image = noticias.retornarImagem(indexpath: indexPath as NSIndexPath)
        cell.lblinfo.attributedText = noticias.InformacaLinha(indexpath: indexPath as NSIndexPath)
        return cell
    }
    
    
}

extension ViewController :   UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
           return noticias.numeroElemntos(section: section)
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "header", for: indexPath) as! DestaqueCollectionViewCell
           
            // cell.backgroundColor = Colors.green
           // let radius = cell.imgInfo.frame.height/2
           // cell.imgInfo.layer.cornerRadius = radius
            //cell.imgInfo.layer.masksToBounds = true
            cell.vwContorno.layer.cornerRadius = 4
            cell.imgInfo.image = generateQRCode(from: "Atlantico")
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noticias", for: indexPath) as! NoticiasCollectionViewCell
           // cell.lblinfo.attributedText = .InformacaLinha(indexpath: indexPath as NSIndexPath)
            cell.imgInfo.layer.cornerRadius = 4
            cell.imgInfo.image = noticias.retornarImagem(indexpath: indexPath as NSIndexPath)
            cell.lblinfo.attributedText = noticias.InformacaLinha(indexpath: indexPath as NSIndexPath)
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 4
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: view.frame.width, height: view.frame.width / 2)
        }
        return CGSize(width: view.frame.width - 8 , height: view.frame.width / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 8, bottom: 2, right: 8)
        }
        return UIEdgeInsets(top: 4, left: 4, bottom: 2, right: 4)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
      
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
}
