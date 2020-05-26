//
//  ViewController.swift
//  Trade-My-Tesla
//
//  Created by Lasse Silkoset on 26/05/2020.
//  Copyright © 2020 Lasse Silkoset. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let imageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "logo"))
        iv.constrainHeight(constant: 422)
        return iv
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .white
        label.text = "This App is not endorsed by Tesla. And any price is entirely fictional"
        return label
    }()
    
    lazy var continueBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Proceed", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(handleProceedTapped), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .themeColorRed()
        
        let stack = UIStackView(arrangedSubviews: [imageView, label, continueBtn])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.setCustomSpacing(40, after: imageView)
        
        view.addSubview(stack)
        stack.fillSuperview(padding: .init(top: 82, left: 16, bottom: 42, right: 16))
        
    }
    
    @objc fileprivate func handleProceedTapped() {
        
        let controller = CalculateViewController()
        present(controller, animated: true, completion: nil)
    }
}




