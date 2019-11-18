//
//  ViewController.swift
//  NumberTheoryToTheMax
//
//  Created by Jonah Zukosky on 11/18/19.
//  Copyright © 2019 Zukosky, Jonah. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    @IBOutlet weak var crtButton: UIButton!
    @IBOutlet weak var eucButton: UIButton!
    @IBOutlet weak var canonButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return [.portrait, .portraitUpsideDown]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        crtButton.backgroundColor = UIColor.init(rgb: 0x003591).withAlphaComponent(0.85)
        eucButton.backgroundColor = UIColor.init(rgb: 0x714682).withAlphaComponent(0.85)
        canonButton.backgroundColor = UIColor.init(rgb: 0x36b500).withAlphaComponent(0.85)
        titleLabel.backgroundColor = UIColor.init(rgb: 0xCFBACE).withAlphaComponent(1.0)
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.cornerRadius = 8
        
        crtButton.titleLabel?.textAlignment = NSTextAlignment.center
        eucButton.titleLabel?.textAlignment = NSTextAlignment.center
        canonButton.titleLabel?.textAlignment = NSTextAlignment.center

    
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBAction func toBinkBalls(_ sender: Any) {
        guard let url = URL(string: "https://www.binkballs.art/") else {
          return
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
     
    
}




extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

