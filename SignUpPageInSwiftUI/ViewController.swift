//
//  ViewController.swift
//  SignUpPageInSwiftUI
//
//  Created by rento on 16/09/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let viewController = SignUpHostingViewController(rootView: SignUpView(emailId: "akash.pradhan@mail.com"))
        
        navigationController?.pushViewController(viewController, animated: true)
    }


}

