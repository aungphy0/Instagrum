//
//  LoginViewController.swift
//  Instagrum
//
//  Created by AUNG PHYO on 8/26/18.
//  Copyright © 2018 AUNG PHYO. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
   
    @IBAction func registerButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "registerSegue", sender: nil)
    }
    
    
   
    @IBAction func loginButton(_ sender: Any) {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) {
            (user: PFUser?, error: Error?) in
            
            if let error = error {
                print("User login failed: \(error.localizedDescription)")
            }else{
                print("User login successfully")
            }
            self.performSegue(withIdentifier: "homeSegue", sender: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
