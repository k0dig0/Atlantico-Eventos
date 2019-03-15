//
//  Constants.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 1/21/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import Foundation
import UIKit
import MessageKit
import Firebase
public let BaseURL = ""
public var tokenAuth = ""
public let fontnegrito = "Montserrat-SemiBold"
public let fontPic = "Montserrat-Medium"
public let fontnormal = "GothamRounded-Light"
public let fontExtra = "Montserrat-ExtraBold"
public let fontsanBold = "Montserrat-ExtraBold"
public var db = Firestore.firestore()


public struct conversas {
    
    public let id: String
    
    /// The display name of a sender.
    public let displayName: String
    
    public let mensagem : String
    
    // MARK: - Intializers
    
    public init(id: String, displayName: String , mensagem: String) {
        self.id = id
        self.displayName = displayName
        self.mensagem = mensagem
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

struct Colors {
    
    static let brightOrange     = UIColor(red: 255.0/255.0, green: 69.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    static let red              = UIColor(red: 255.0/255.0, green: 20.0/255.0, blue: 54.0/255.0, alpha: 1.0)
    static let orange           = UIColor(red: 250.0/255.0, green: 154.0/255.0, blue: 21.0/255.0, alpha: 1.0)
    static let blue             = UIColor(red: 66.0/255.0, green: 134.0/255.0, blue: 244.0/255.0, alpha: 1.0)
    static let blue1             = UIColor(red: 72.0/255.0, green: 177.0/255.0, blue: 191.0/255.0, alpha: 1.0)
    static let blue2             = UIColor(red: 36.0/255.0, green: 160.0/255.0, blue: 199.0/255.0, alpha: 1.0)
    static let green            = UIColor(red: 220.0/255.0, green: 248.0/255.0, blue: 198.0/255.0, alpha: 1.0)
     static let green1            = UIColor(red: 6.0/255.0, green: 190.0/255.0, blue: 182.0/255.0, alpha: 1.0)
    static let darkGrey         = UIColor(red: 173.0/255.0, green: 174.0/255.0, blue: 178.0/255.0, alpha: 1.0)
    static let veryDarkGrey     = UIColor(red: 55.0/255.0, green: 59.0/255.0, blue: 68.0/255.0, alpha: 1.0)
    static let lightGrey        = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1.0)
    static let red2            = UIColor(red: 196.0/255.0, green: 0.0/255.0, blue: 122.0/255.0, alpha: 1.0)
    static let white            = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    static let yellow           = UIColor(red: 230.0/255.0, green: 142.0/255.0, blue: 24.0/255.0, alpha: 1.0)
    static let novacor          = UIColor(red: 8.0/255.0, green: 172.0/255.0, blue: 245.0/255.0, alpha: 1.0)
    static let novacorm          = UIColor(red: 245.0/255.0, green: 158.0/255.0, blue: 19.0/255.0, alpha: 1.0)
    static let novacormed          = UIColor(red: 215.0/255.0, green: 150.0/255.0, blue: 17.0/255.0, alpha: 1.0)
    
     static let nav1          = UIColor(red: 0.0/255.0, green: 153.0/255.0, blue: 181.0/255.0, alpha: 1.0)
    static let nav2          = UIColor(red: 0.0/255.0, green: 214.0/255.0, blue: 255.0/255.0, alpha: 1.0)
}
public var destino = Sender(id: "", displayName: "", fotoUrl: "", email: "", funcao: "", direcao: "", extencao: "")
public var envio = Sender(id: "", displayName: "", fotoUrl: "", email: "", funcao: "", direcao: "", extencao: "" )
var Utilizador : user!
extension UINavigationBar
{
    /// Applies a background gradient with the given colors
    func applyNavigationGradient( colors : [UIColor]) {
        var frameAndStatusBar: CGRect = self.bounds
        frameAndStatusBar.size.height += 20 // add 20 to account for the status bar
        
        setBackgroundImage(UINavigationBar.gradient(size: frameAndStatusBar.size, colors: colors), for: .default)
    }
    
    /// Creates a gradient image with the given settings
    static func gradient(size : CGSize, colors : [UIColor]) -> UIImage?
    {
        // Turn the colors into CGColors
        let cgcolors = colors.map { $0.cgColor }
        
        // Begin the graphics context
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        
        // If no context was retrieved, then it failed
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // From now on, the context gets ended if any return happens
        defer { UIGraphicsEndImageContext() }
        
        // Create the Coregraphics gradient
        var locations : [CGFloat] = [0.0, 1.0]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgcolors as NSArray as CFArray, locations: &locations) else { return nil }
        
        // Draw the gradient
        context.drawLinearGradient(gradient, start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: size.width, y: 0.0), options: [])
        
        // Generate the image (the defer takes care of closing the context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    
}

extension UIViewController {
    func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        activityIndicator.backgroundColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:1)
        activityIndicator.layer.cornerRadius = 6
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .whiteLarge
        activityIndicator.startAnimating()
        //UIApplication.shared.beginIgnoringInteractionEvents()
        
        activityIndicator.tag = 160 // 100 for example
        
        // before adding it, you need to check if it is already has been added:
        for subview in view.subviews {
            if subview.tag == 160 {
                print("already added")
                return
            }
        }
        
        view.addSubview(activityIndicator)
    }
    
    func hideActivityIndicator() {
        let activityIndicator = view.viewWithTag(160) as? UIActivityIndicatorView
        activityIndicator?.stopAnimating()
        
        // I think you forgot to remove it?
        activityIndicator?.removeFromSuperview()
        
        //UIApplication.shared.endIgnoringInteractionEvents()
    }
}

extension UIView {
    
    
    
    func setCellShadow() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 1.0
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        self.layer.cornerRadius = 15
    }
    
    func setAnchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?,
                   bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,
                   paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat,
                   paddingRight: CGFloat, width: CGFloat = 0, height: CGFloat = 0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        }
        return topAnchor
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.leftAnchor
        }
        return leftAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        }
        return bottomAnchor
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.rightAnchor
        }
        return rightAnchor
    }
    
}








