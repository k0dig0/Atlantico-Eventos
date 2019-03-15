//
//  IntroViewController.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 3/7/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var BtnLogin: UIButton!
    @IBOutlet weak var btnRegistro: UIButton!
    
    @IBOutlet weak var vwInferior: UIView!
    @IBOutlet weak var vwSuperior: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

      vwSuperior.layer.cornerRadius = 180  // Do any additional setup after loading the view.
        let bgimage = imageWithGradientView(startColor: Colors.nav1, endColor: Colors.nav2, size: CGSize(width: UIScreen.main.bounds.size.width, height: 1))
     self.view.backgroundColor = UIColor(patternImage: bgimage!)
        btnRegistro.layer.cornerRadius = 8
        BtnLogin.layer.cornerRadius = 8
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func imageWithGradientView(startColor:UIColor, endColor:UIColor, size:CGSize, horizontally:Bool = true) -> UIImage? {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        if horizontally {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        } else {
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        }
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
