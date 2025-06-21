//
//  ViewController.swift
//  nutrify
//
//  Created by Ruslan Spirkin on 6/19/25.
//

import UIKit


class MainViewController: UIViewController {
    
    // some of our elements
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemOrange
        style()
        layout()
    }
    
    
    // sets elements for our ui
    func style() {
        topView.backgroundColor = .systemBlue
        topLabel.text = "Nutrify"
        
        topView.addSubview(topLabel)
        
        view.addSubview(topView)
    }
    
    
    // sets layout for our ui
    func layout() {
        NSLayoutConstraint.activate([
            //topView
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            //topLabel
            topLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 10),
            topLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20),
            topLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -20),
            topLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }


}

