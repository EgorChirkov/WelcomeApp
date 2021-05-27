//
//  LoginViewController.swift
//  WelcomeApp
//
//  Created by Егор Чирков on 25.05.2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnForgotName: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        textFieldName.enablesReturnKeyAutomatically = true
        textFieldPassword.enablesReturnKeyAutomatically = true
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        
        view.endEditing(true)
        
        guard let userName = textFieldName.text, let password = textFieldPassword.text else {
            return
        }
        
        guard !userName.isEmpty, !password.isEmpty else {
            showAlertWithTitle(title: "Ooops!", message: "Fields cannot be empty")
            return
        }
        
        guard userName == "User", password == "Password" else {
            showAlertWithTitle(title: "Ooops!", message: "Wrong username or password")
            return
        }
        
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        guard let welcomeVC = storyboard.instantiateViewController(withIdentifier: "welcomeID") as? WelcomeViewController else {
//            return
//        }
//        self.present(welcomeVC, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let welcomeVC = segue.destination as? WelcomeViewController else {
            return
        }
        
        welcomeVC.user = self.textFieldName.text ?? "Username"
        
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        
        guard let welcomeVC = segue.source as? WelcomeViewController else {
            return
        }
        
        textFieldPassword.text = welcomeVC.user
        textFieldName.text = welcomeVC.user
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction func actionForgotName(_ sender: Any) {
        showAlertWithTitle(title: "Ooops!", message: "Your name is User")
    }
    
    @IBAction func actionForgotPassword(_ sender: Any) {
        showAlertWithTitle(title: "Ooops!", message: "Your password is Password")
    }
    
}



extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        if textField == textFieldName {
            //перекинем фокус на новое поле
            textFieldPassword.becomeFirstResponder()
        }
        if textField == textFieldPassword {
            btnLogin.sendActions(for: .touchUpInside)
        }
        return true
    }
}


extension LoginViewController {
    private func showAlertWithTitle(title: String, message: String){
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertVC, animated: true, completion: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        //событие когда клавиатура покажется на экране
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            //поднимем view на размер клавиатуры
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyboardSize.height/2
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        //событие когда клавиатура спрячется
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
}
