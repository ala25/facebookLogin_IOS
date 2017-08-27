//
//  ViewController.swift
//  login
//
//  Created by Andy Altamirano on 8/26/17.
//  Copyright © 2017 ala. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class ViewController: UIViewController {

    @IBOutlet weak var grantedPermissionLabel: UILabel!
    @IBOutlet weak var accessTokenLabel: UILabel!
    @IBOutlet weak var deniedPermissionLabel: UILabel!
    @IBAction func loginPressed(_ sender: UIButton) {
        
        let loginManager = LoginManager()
        
        loginManager.logIn([.publicProfile, .email, .userFriends], viewController: self){
            result in
            
            switch result{
            case .failed(let error):
                print(error.localizedDescription)
            case .cancelled:
                print("canceled")
            case .success(let grantedPermissions, let declinedPermissions, let userInfo):
                let connection = GraphRequestConnection()
                connection.add(GraphRequest(graphPath: "/me/likes")) { httpResponse, result in
                    switch result {
                    case .success(let response):
                        print("Graph Request Succeeded: \(response)")
                    case .failed(let error):
                        print("Graph Request Failed: \(error)")
                    }
                }
                connection.start()
                

                
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

