//
//  WelcomeViewController.swift
//  WelcomeApp
//
//  Created by Егор Чирков on 25.05.2021.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    
    @IBOutlet weak var btnLogout: UIButton!
    
    private let smile = ["😃", "😎", "🧐", "🤨", "😏"]
    var user = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = "Welcome, \(user)!"
        lblDetail.text = smile.randomElement()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setGradientBackground()
    }

    
    @IBAction func actionLogout(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        user = ""
    }
    
    private func setGradientBackground() {
        let colorTop =  UIColor(red: 143.0/255.0, green: 45.0/255.0, blue: 168.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 81.0/255.0, green: 45.0/255.0, blue: 168.0/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
}
