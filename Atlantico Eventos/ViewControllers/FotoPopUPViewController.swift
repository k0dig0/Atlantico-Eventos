//
//  FotoPopUPViewController.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 3/15/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseUI
class FotoPopUPViewController: UIViewController {
  @IBOutlet weak var handleArea: UIView!
    
    @IBOutlet weak var imgProfilepic: UIImageView!
    @IBOutlet weak var btnFazer: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Reference to an image file in Firebase Storage
        let reference = Storage.storage().reference().child("perfil")
        
        // UIImageView in your ViewController
        let imageView: UIImageView = self.imgProfilepic
        
        // Placeholder image
        let placeholderImage = UIImage(named: "avatar")
        
        // Load the image using SDWebImage
        imageView.sd_setImage(with: reference, placeholderImage: placeholderImage)

        // Do any additional setup after loading the view.
    }

    @IBAction func AddFoto(_ sender: Any) {
    
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            
            self.imgProfilepic.image = image
        }
    
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
