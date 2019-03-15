//
//  LoginViewController.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 3/1/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import UIKit
import MessageKit
import UserNotifications
class LoginViewController: UIViewController , UNUserNotificationCenterDelegate {
    
    
    enum CardState {
        case extended
        case colapsed
    }
 
    var cardview : FotoPopUPViewController!
    var visualEfect : UIVisualEffectView!
    var cardHeight : CGFloat = 600
    var handleCardArea : CGFloat = 65
    var cardVisible = false
    var nextState : CardState {
        return cardVisible ? .colapsed : .extended
    }
    var runningAnimation = [UIViewPropertyAnimator]()
    var animationProgressWhenStoped :CGFloat = 0

    
    
    
    @IBOutlet weak var btnLogin: UIButton!
    let center = UNUserNotificationCenter.current()
    @IBOutlet weak var txtChave: UITextField!
    @IBOutlet weak var txtUser: UITextField!
    var email = ""
    @IBOutlet weak var vwBack: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //requesting for authorization
       vwBack.layer.cornerRadius = 80
        // Do any additional setup after loading the view.
        notificacao()
        txtUser.text = email
        let bgimage = imageWithGradientView(startColor: Colors.nav1, endColor: Colors.nav2, size: CGSize(width: UIScreen.main.bounds.size.width, height: 1))
        self.view.backgroundColor = UIColor(patternImage: bgimage!)
       // btnLogin.backgroundColor  = UIColor(patternImage: bgimage!)
        let radius = btnLogin.frame.height/2
        btnLogin.layer.cornerRadius = radius
        btnLogin.layer.masksToBounds = true
        setupCard()
    }
    
    @IBAction func login(_ sender: Any) {
        
        
        
        
        let current = Sender(id: Utilizador.numero,displayName: Utilizador.nome, fotoUrl: Utilizador.fotoUrl, email: Utilizador.email, funcao: Utilizador.funcao, direcao: Utilizador.direcao, extencao: Utilizador.extencao   )
       envio = current
           performSegue(withIdentifier: "login", sender: nil)
       
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
    
    
}
extension LoginViewController  {
    
    func setupCard()  {
        visualEfect = UIVisualEffectView()
        visualEfect.frame = self.view.frame
        self.view.addSubview(visualEfect)
        self.cardview = FotoPopUPViewController(nibName: "FotoPopUPViewController", bundle : nil)
        cardview.view.tag = 100
        // Add the view controller as a child
        addChild(self.cardview)
        // Move the child view controller's view to the parent's view
        view.addSubview(self.cardview.view)
        // Notify the child that it was moved to a parent
        self.cardview.didMove(toParent: self)
        // self.addChild(cardview)
        // self.view.addSubview(cardview.view)
        self.cardview.view.frame = CGRect(x: 0, y: self.view.frame.height - handleCardArea, width: self.view.bounds.width, height: cardHeight)
        self.cardview.view.clipsToBounds = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleCardTap(recognizer:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handleCardPan(recognizer:)))
        cardview.handleArea.addGestureRecognizer(tapGestureRecognizer)
        cardview.handleArea.addGestureRecognizer(panGestureRecognizer)
        //cardview.btnFazer.addTarget(self, action:
          //  #selector(self.MostrarCamera(recognizer:)), for: .touchUpInside)
        // starTransition(state: nextState, duration: 0.9)
        animateifNeeded(state: nextState, duration: 0.9)
    }
    @objc
    func handleCardTap(recognizer: UITapGestureRecognizer)  {
        switch recognizer.state {
        case .ended:
            animateifNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    @objc
    func MostrarCamera(recognizer: UITapGestureRecognizer)  {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
        }
    }
    
    
    @objc
    func handleCardPan(recognizer: UIPanGestureRecognizer)  {
        switch recognizer.state {
        case .began:
            starTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: self.cardview.handleArea)
            var fractionComplete = translation.y / cardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueTransition()
            
        default:
            break
        }
    }
    func animateifNeeded(state : CardState , duration : TimeInterval)  {
        if runningAnimation.isEmpty{
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state{
                case .extended :
                    self.cardview.view.frame.origin.y = self.view.frame.height - self.cardHeight
                case .colapsed :
                    self.dismiss(animated: true, completion: nil)
                    
                }
            }
            
            let cornerRadius = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state{
                case .extended :
                    self.cardview.view.layer.cornerRadius = 12
                case .colapsed :
                    self.cardview.view.layer.cornerRadius = 0
                    
                }
            }
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state{
                case .extended :
                    self.visualEfect.effect = UIBlurEffect(style: .dark)
                case .colapsed :
                    self.visualEfect.effect = nil
                    
                }
            }
            
            frameAnimator.addCompletion {_ in
                self.cardVisible = !self.cardVisible
                self.runningAnimation.removeAll()
            }
            frameAnimator.startAnimation()
            runningAnimation.append(frameAnimator)
            blurAnimator.startAnimation()
            runningAnimation.append(blurAnimator)
            cornerRadius.startAnimation()
            runningAnimation.append(cornerRadius)
        }
    }
    func starTransition(state : CardState , duration : TimeInterval) {
        if runningAnimation.isEmpty{
            animateifNeeded(state: state, duration: duration)
        }
        for animator in runningAnimation{
            animator.pauseAnimation()
            animationProgressWhenStoped = animator.fractionComplete
        }
    }
    func updateTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimation{
            animator.fractionComplete = fractionCompleted +
            animationProgressWhenStoped
        }
    }
    func continueTransition() {
        for animator in runningAnimation{
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
}
