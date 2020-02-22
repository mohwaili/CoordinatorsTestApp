//
//  SubSubViewController.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 21/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import UIKit

class FlowC2ViewController: UIViewController {

    var coordinator: FlowCCoordinator?
    
    private lazy var finishFlow: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Finish Flow", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(finishFlow(_:)), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "C2"
        
        NSLayoutConstraint.activate([
                   finishFlow.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   finishFlow.centerYAnchor.constraint(equalTo: view.centerYAnchor),
               ])

        self.view.backgroundColor = .purple
    }
    
    @objc func finishFlow(_ sender: Any) {
        coordinator?.finishFlow()
    }
    
    deinit {
        print("deallocating: \(Self.self)")
    }

}
