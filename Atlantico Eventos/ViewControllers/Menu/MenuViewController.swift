//
//  MenuViewController.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 3/7/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import Foundation
import UIKit

import UIKit

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    /**
     *  Array to display menu options
     */
    @IBOutlet var tblMenuOptions : UITableView!
    
    /**
     *  Transparent button to hide menu
     */
    @IBOutlet var btnCloseMenuOverlay : UIButton!
    
    /**
     *  Array containing menu options
     */
    var arrayMenuOptions = [Dictionary<String,String>]()
    
    /**
     *  Menu button which was tapped to display the menu
     */
    var btnMenu : UIButton!
    
    /**
     *  Delegate of the MenuVC
     */
    var delegate : SlideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblMenuOptions.tableFooterView = UIView()
        tblMenuOptions.delegate = self
        tblMenuOptions.dataSource = self
        tblMenuOptions.rowHeight = 44.0
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateArrayMenuOptions()
    }
    
    func updateArrayMenuOptions(){
        arrayMenuOptions.append(["title":"Feed", "icon":"Feed_Menu_Lateral"])
        arrayMenuOptions.append(["title":"Eventos", "icon":"Eventos_Menu_Lateral"])
        arrayMenuOptions.append(["title":"Chat", "icon":"Chat_Menu_Lateral"])
        arrayMenuOptions.append(["title":"Notícias", "icon":"Noticias_Menu_Lateral"])
        arrayMenuOptions.append(["title":"Benificios", "icon":"Benefícios_Menu_Lateral"])
       // arrayMenuOptions.append(["title":"Informações do Usuário", "icon":"PlayIcon"])
        arrayMenuOptions.append(["title":"Geração de Ideias", "icon":"Geração_Ideias_Menu_Lateral"])
        tblMenuOptions.reloadData()
    }
    
    @IBAction func onCloseMenuClick(_ button:UIButton!){
        btnMenu.tag = 0
        
        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if(button == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParent()
        })
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cellMenu") as! GenericTableViewCell
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        
        let view : UIView = cell.contentView.viewWithTag(102) as! UIView
        let lblTitle : UILabel = cell.contentView.viewWithTag(101) as! UILabel
         let imgIcon : UIImageView = cell.contentView.viewWithTag(100) as! UIImageView
        //view.layer.cornerRadius = 8
        imgIcon.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)
       // lblTitle.text = arrayMenuOptions[indexPath.row]["title"]!
        let radius = cell.vwContorno.frame.height/2
        cell.vwContorno.layer.cornerRadius = radius
        cell.vwContorno.layer.masksToBounds = true
        //cell.vwContorno.layer.cornerRadius = 2
        cell.imgInfo.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)
        cell.lblinfo.text = arrayMenuOptions[indexPath.row]["title"]!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.tag = indexPath.row
        self.onCloseMenuClick(btn)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenuOptions.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
}
