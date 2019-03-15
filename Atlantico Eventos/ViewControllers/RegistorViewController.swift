//
//  RegistorViewController.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 3/11/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import UIKit
import MessageKit
import UserNotifications
class RegistorViewController: UIViewController , UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var btnLogin: UIButton!
    let center = UNUserNotificationCenter.current()
    @IBOutlet weak var txtChave: UITextField!
    @IBOutlet weak var txtUser: UITextField!
    
    @IBOutlet weak var vwBack: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //requesting for authorization
        vwBack.layer.cornerRadius = 55
        // Do any additional setup after loading the view.
        notificacao()
        let bgimage = imageWithGradientView(startColor: Colors.nav1, endColor: Colors.nav2, size: CGSize(width: UIScreen.main.bounds.size.width, height: 1))
        self.view.backgroundColor = UIColor(patternImage: bgimage!)
        // btnLogin.backgroundColor  = UIColor(patternImage: bgimage!)
        let radius = btnLogin.frame.height/2
        btnLogin.layer.cornerRadius = radius
        btnLogin.layer.masksToBounds = true
    }
    
    @IBAction func login(_ sender: Any) {
     
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as? LoginViewController {
            viewController.email = txtUser.text ?? "email não informado"
            self.present(viewController, animated: true, completion: nil)
            
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
    func notificacao(){
        
        
        
        center.delegate = self
        //creating the notification content
        var content = UNMutableNotificationContent()
        
        //adding title, subtitle, body and badge
        content.title = "Hey this is Simplified iOS"
        content.subtitle = "iOS Development is fun"
        content.body = "We are learning about iOS Local Notification"
        content.sound = UNNotificationSound.default
        content.threadIdentifier = "local-notifications temp"
        
        let data = Date(timeIntervalSinceNow: 10)
        let datacomponents = Calendar.current.dateComponents([.year , .month, .hour , .minute , .second], from: data)
        
        //getting the notification trigger
        //it will be called after 5 seconds
        let trigger = UNCalendarNotificationTrigger(dateMatching: datacomponents, repeats: false)
        
        //getting the notification request
        let request = UNNotificationRequest(identifier: " content", content: content, trigger: trigger)
        
        //adding the notification to notification center
        
        center.add(request){(error) in
            if error != nil {
                print("Erro a chamar a notificação")
            }
        }
        
    }
    
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
