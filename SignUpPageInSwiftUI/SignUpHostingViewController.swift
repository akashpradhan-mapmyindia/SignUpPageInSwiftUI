//
//  SignUpHostingViewController.swift
//  SignUpPageInSwiftUI
//
//  Created by rento on 16/09/24.
//

import UIKit
import SwiftUI

class SignUpHostingViewController: UIHostingController<SignUpView> {
    override init(rootView: SignUpView) {
        super.init(rootView: rootView)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
