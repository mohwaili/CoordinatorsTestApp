//
//  SubSubViewController.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 21/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import UIKit

class FlowCViewController: UIViewController {

    weak var coordinator: FlowCCoordinator?
    
    private lazy var goToC2Button: UIButton = {
           let button = UIButton()
           button.translatesAutoresizingMaskIntoConstraints = false
           button.setTitle("Go To C2", for: .normal)
           button.setTitleColor(.black, for: .normal)
           button.addTarget(self, action: #selector(goToC2(_:)), for: .touchUpInside)
           view.addSubview(button)
           return button
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "C1"
        
        NSLayoutConstraint.activate([
            goToC2Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goToC2Button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        

        self.view.backgroundColor = .purple
    }
    
    @objc func goToC2(_ sender: Any) {
        coordinator?.goToC2()
    }
    
    deinit {
        print("deallocating: \(Self.self)")
    }

}
