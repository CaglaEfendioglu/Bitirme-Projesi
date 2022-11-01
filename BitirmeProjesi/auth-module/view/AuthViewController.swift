//
//  UyeGirisi.swift
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 28.10.2022.
//

import UIKit
import Lottie
import FirebaseAuth

class AuthViewController: UIViewController {
    //MARK: Views
    
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var textfieldUserName: UITextField!
    @IBOutlet weak var textfieldPassword: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
    }
    
    //MARK: Private and @IBAction Func
    
    private func setupAnimation() {
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
    }
    
    private func configure() {
        navigationItem.title = "Auth"
        view.backgroundColor = .white
        createSegmentConntrol()
    }
    
    private func createSegmentConntrol() {
        segmentedControl.addTarget(self, action: #selector(click(_:)), for: .valueChanged)
    }
    
    @objc func click(_ segmentControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            buttonLogin.setTitle("Giris Yap", for: .normal)
        default:
            buttonLogin.setTitle("Uye Ol", for: .normal)
        }
    }
    
    @IBAction func buttonLogin(_ sender: Any) {
        guard let email = textfieldUserName.text, !email.isEmpty, let password = textfieldPassword.text, !password.isEmpty else {
            print("Hatali bilgi")
            return
        }

        singTransactions(email: email, password: password)
    }
    
    private func singTransactions(email: String, password: String) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            //MARK: SING IN
            
            FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
                guard let strongSelf = self else { return }
                
                if error != nil {
                    strongSelf.showWrongSignIn()
                    
                }else{
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "tabbar")
                    strongSelf.show(viewController, sender: nil)
                }
               
            }
        default:
            //MARK: SING UP
            FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self]result, error in
                guard let self = self else { return }
                guard error == nil else {
                    
                    self.showCreateAccount(email: email, password: password)
                    return
                }
                self.alreadyAccount()
            })
        }
    }
    
    func alreadyAccount() {
        let alert = UIAlertController(title: "Hatali Giris", message: "Bu Hesap Zaten Mevcut", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Giris Yap", style: .default, handler: { _ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "tabbar")
            self.show(viewController, sender: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
    
    func showCreateAccount(email: String, password: String) {
        let alert = UIAlertController(title: "", message: "Hesap olusturmak ister misin?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Hesap Olustur", style: .default, handler: { _ in
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in
                guard error == nil else {
                    print("Hesap oluşturulamadı")
                    return
                }
                
                print("Giriş yaptınız")
            })
        }))
        
        alert.addAction(UIAlertAction(title: "Kapat", style: .cancel, handler: { _ in
            
        }))
        
        present(alert, animated: true)
    }
    
    func showWrongSignIn() {
        let alert = UIAlertController(title: "Hatali Giris", message: "Kullanici adi veya sifre hatali", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
    
}
