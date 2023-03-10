//
//  ViewController.swift
//  CustomAlert
//
//  Created by Admin on 21/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    var button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 50)))

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = .yellow
        view.addSubview(button)
        button.setTitle("Show Alert With Images", for: .normal)
        button.backgroundColor = .red
        button.center = view.center
        button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func buttonClicked(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            presentAlert1()
        } else {
            presentAlert2()
        }
        let message = sender.isSelected ? "Show Normal Alert" : "Show Alert With Images"
        button.setTitle(message, for: .normal)
    }

    func presentAlert1() {
        let alert = GSAlert()
        let image = UIImageView(image: UIImage(systemName: "star"))
        image.tintColor = .green
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 50).isActive = true
        image.heightAnchor.constraint(equalToConstant: 40).isActive = true
        let airplane = UIImageView(image: UIImage(systemName: "pc"))
        airplane.tintColor = .red
        airplane.translatesAutoresizingMaskIntoConstraints = false
        airplane.widthAnchor.constraint(equalToConstant: 224).isActive = true
        airplane.heightAnchor.constraint(equalToConstant: 200).isActive = true
        alert.set(
            title: nil,
            messages: [
                (airplane, nil),
                (image, "this is look".attributed.font(UIFont.systemFont(ofSize: 15)).make()),
                (nil, "this is a sample message to show how alert is lok".attributed.font(.systemFont(ofSize: 16)).alignment(.center).strikeThroughStyle(.thick).make())
            ],
            alertButtons: [
                ("OKAY".attributed.make(), {
                    print("OKAY Taped")
                }),
                ("No".attributed.font(.systemFont(ofSize: 17)).foreground(color: .gray).make(), {
                    print("Cqncelled")
                }),
                ("EWRW".attributed.font(.systemFont(ofSize: 19)).foreground(color: .magenta).make(), {
                    print("EWRW taped")
                }),
                ("Cancel".attributed.font(.systemFont(ofSize: 22)).foreground(color: .red).make(), nil),
        ])
        present(alert, animated: true, completion: nil)
    }
    
    func presentAlert2() {
        let alert = GSAlert()
        alert.set(
            title: nil,
            messages: [
                (nil, "this is look".attributed.font(.systemFont(ofSize: 22, weight: .heavy)).make()),
                (nil, "this is a sample message to show how alert is lok".attributed.font(.systemFont(ofSize: 16)).alignment(.center).strikeThroughStyle(.thick).make())
            ],
            alertButtons: [
                ("OKAY".attributed.make(), {
                    print("OKAY Taped")
                }),
                ("Cancel".attributed.font(.systemFont(ofSize: 22)).foreground(color: .red).make(), nil),
        ])
        present(alert, animated: true, completion: nil)
    }
}
