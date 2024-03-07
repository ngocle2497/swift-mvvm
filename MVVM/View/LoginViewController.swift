//
//  LoginViewController.swift
//  MVVM
//
//  Created by Ngoc H. Le on 07/03/2024.
//

import UIKit

class LoginViewController: UIViewController {


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
        
        btnTouch.layer.cornerRadius = 8
        
    }

}
