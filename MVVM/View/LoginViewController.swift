//
//  LoginViewController.swift
//  MVVM
//
//  Created by Ngoc H. Le on 07/03/2024.
//

import UIKit

class LoginViewController: UIViewController {


    @IBOutlet weak var buttonTouch: UIButton!
    @IBOutlet weak var btnTouch: UIView!
    @IBOutlet weak var labelAgreement: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    func setupView(){
        let string1 = "By signing in you are agreeing our "
        let string2 = "Term and privacy policy"
        
        let attr1 = [NSAttributedString.Key.foregroundColor: UIColor(107, 94, 94, 1)]
        let attr2 = [NSAttributedString.Key.foregroundColor: UIColor(3, 134, 208, 1)]
        
        let attributedText = NSMutableAttributedString(string: string1, attributes: attr1);
        
        attributedText.append(NSMutableAttributedString(string: string2, attributes: attr2))
        
        labelAgreement.attributedText = attributedText
        
        buttonTouch.layer.bounds.size.width = 30;
        buttonTouch.layer.bounds.size.height = 30
        buttonTouch.clipsToBounds = true
        buttonTouch.layer.backgroundColor = CGColor(red: 0, green: 0, blue: 1, alpha: 1)
        buttonTouch.layer.cornerRadius = 10
        buttonTouch.layer.borderWidth = 1
        buttonTouch.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        let imageFigerprint = UIImage(named: "fingerprint")
        buttonTouch.addTarget(self, action: #selector(onTouchPressed), for: .touchUpInside)
        var configuration = UIButton.Configuration.filled()
        configuration.image = imageFigerprint;
        configuration.imagePadding = 4
        
        
        buttonTouch.configuration = configuration
    }
    
    @objc func onTouchPressed() {
        print("Sometime")
    }

}
