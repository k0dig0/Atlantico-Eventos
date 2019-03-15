//
//  UsersCollectionViewCell.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 3/1/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import UIKit
protocol GenericoDelegate : class {
    
    func destaqueItemSelectedAtIndex(_ index : Int32)
    
}

class UsersCollectionViewCell: UICollectionViewCell , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var users : UsersViewModel!
     weak var delegates: GenericoDelegate?
    var contador = 1
    var tamanho = 0
    var timer = Timer()
    var proximo = 0
    var images: [String]? {
        didSet {
            collectionView.reloadData()
        }
    }
    func destaqueItemSelectedAtIndex(indice : Int){
        
        
        if (delegates != nil) {
            let index = Int32(indice)
            
            delegates?.destaqueItemSelectedAtIndex(index)
        }else{
            let index = Int32(indice)
            delegates?.destaqueItemSelectedAtIndex(index)
            
        }
    }
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    let cellId = "cellId"
    
    
    
    func setup(data: UsersViewModel ) {
        
        
        addSubview(collectionView)
       
        collectionView.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
       
        //clGeral.register(CollectionViewCell.self, forCellWithReuseIdentifier: "celula")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        collectionView.register(IconsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.showsHorizontalScrollIndicator = false
        users = data
        // timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  users.numeroElemntos(section: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! IconsCell
        
        
        cell.imageView.image =  users.retornarImagem(indexpath: indexPath as NSIndexPath)
        
        let radius = cell.imageView.frame.height/2
        cell.imageView.layer.cornerRadius = radius
         cell.imageView.layer.masksToBounds = true
        //cell.imageView.contentMode = .scaleAspectFil
        
        cell.lblUser.lineBreakMode = .byWordWrapping
        cell.lblUser.numberOfLines = 3
        cell.lblUser.textAlignment = .center
        cell.lblUser.attributedText = users.InformacaLinha(indexpath: indexPath as NSIndexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 14)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       // self.destaqueItemSelectedAtIndex(indice: indexPath.row)
        delegates?.destaqueItemSelectedAtIndex(Int32(indexPath.row))
        
    }
    
    private class IconsCell: UICollectionViewCell {
        
        var imageView: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            
        
            // iv.layer.cornerRadius = 15
            return iv
        }()
        var lblUser: UILabel = {
            let iv = UILabel()
            
            return iv
        }()
        
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup(frame: frame)
            
        }
        
        func setup(frame: CGRect) {
            //setCellShadow()
         
         let media = (frame.width - 50) / 2
           
            let rect = CGRect(origin: CGPoint(x:media, y:2), size: CGSize(width:50, height:50))
           imageView = UIImageView(frame: rect)
               addSubview(imageView)
            lblUser =  UILabel(frame: CGRect(x: imageView.frame.origin.x, y:  imageView.frame.size.height , width: imageView.frame.size.width, height: frame.width))
               addSubview(lblUser)

        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
}

