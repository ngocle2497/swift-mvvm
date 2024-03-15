import UIKit
import MMKV
class LoginViewController: UIViewController, UITextViewDelegate, GlobalUpdating {
    
    @Global var appSetting: AppSettings
    

    
    @IBOutlet weak var remoteImage: BRemoteImage!
    @IBOutlet weak var lbterm: UITextView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerUpdates()
    }
    
    func globalUpdate() {
        print("Login View Updating: \(appSetting.language)")
        lbterm.text = S10n.Bananas.owner(12, "Ngọc Lê")
        lbterm.textColor = .primary
        lbterm.font = .title1Bold
    }
    func setupView(){
        loginButton.layer.cornerRadius = 20
        
        remoteImage.placeholderHash = .blurhash("LKN]Rv%2Tw=w]~RBVZRi};RPxuwH")
        
        
        remoteImage.source = "https://images.unsplash.com/photo-1682685797703-2bb22dbb885b?q=80&w=3174&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    }
    
    @IBAction func onLoginPressed(_ sender: Any) {
        UIView.animate(withDuration: 1) { [weak self] in
            self?.remoteImage.layer.cornerRadius = self?.remoteImage.layer.cornerRadius == 0 ? 50 : 0
        }
        pushController(HomeViewController())
                appSetting.theme = appSetting.theme ==  .light ? .dark : .light
                appSetting.fontSize = appSetting.fontSize ==  .default ? .large : .default
                appSetting.language = appSetting.language == .english ? .vietnam : .english
//        print("ABC: \("9OutPkdUaQyRTeKppfgZurs5+DIcqiITl/lRz0hTfI9N98jF0dDdvKIodtez4BVlBm8a2Rzt/5zy0kxpU7pnuMLDH7onbLCrVkc71LMXPuNqODTAJiBXW5FZqiwR4kfayJrAEEWpOAZGq04ZEP4rESlfsQwn8CYgLjBYQpRiWOPBfHcpo8NV3g1ommyDfeSlDUPRdafqSmRIInZVMEv7KnOz9wIZAq/y37ahzaSeVm8GbxrZHO3/nPLSTGlTume4+pYVeLRtaskkqgQgSDTlyR9CsyrtvyKPMiszlYnHMRX8jDyLgwgUlhMYYKs3NRf5UdEGL5oUAW6X4OaSlZNDaG0Scl8ATn0YhGevEPL99aD9g4f9ngwGmxOgfUFL/3LCrlhxx7MhMKLctXa7UswTxugOm0X+2KGToSA8b85TOO5vUlX3MhEqc8qIhAC7tc5Tc9/MoEZzz1nrbFsvz8yRdGCocf8srVE/opvRJ/twAqTawDjC4qxlg+EkoPphJPBhvedQ7cWDVkhGcOesASDvo9zRCqJdv8EPglgg1xaKeCPJ8hpC88OqnQChOkESQC1ww8H4HNIc2ldAcUMTwKfJc31kutwegFAoUJO74XCPpGuHrQD+sIyDlY/c6Xwl6vP6I81vi5fZFxWNNFJfoRyXxQ==".aesDecrypt(password: "SecretPassphrase")?.toDic()?["bundle_id"] ?? "NO")")
    }
}
