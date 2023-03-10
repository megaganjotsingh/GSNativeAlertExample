//
//  EFAlert.swift
//  CustomAlert
//
//  Created by Admin on 21/10/22.
//

import Foundation
import UIKit

class GSAlert: UIViewController {
    typealias AlertAction = (() -> ())?
    typealias AlertButton = (NSAttributedString, AlertAction)
    
    public var backgroundColor: UIColor = .secondarySystemBackground
    
    private var descriptions: [UIImage: String]?
    
    private var container = UIView()
    private var titleLabel = UILabel()
    private var messageStack = UIStackView()
    private var buttonsStack = UIStackView()
    private var buttonContainer = UIView()
    private var separatorLine = UIView()
        
    init() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        super.init(nibName: nil, bundle: nil)
        transitioningDelegate = self
        setupMessageStack()
        setUpbuttonsStack()
        setupSeparatorLine()
        setupContainer()
        alignViews()
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(title: NSAttributedString?, messages: [(UIImageView?, NSAttributedString?)]?, alertButtons: [AlertButton]) {
        titleLabel.attributedText = title
        // messages setup
        messages?.forEach({ msg in
            let stack = UIStackView()
            stack.alignment = .fill
            stack.distribution = .fill
            stack.axis = .horizontal
            stack.spacing = 8
            if let imageView = msg.0 {
                stack.addArrangedSubview(imageView)
            }
            if let str = msg.1 {
                let label = UILabel()
                label.setContentCompressionResistancePriority(.required, for: .horizontal)

                label.attributedText = str
                label.numberOfLines = 0
                stack.addArrangedSubview(label)
            }
            messageStack.addArrangedSubview(stack)
        })
        
        // buttons setup
        alertButtons.forEach { btn in
            let newButton = AlertBtn()
            newButton.backgroundColor = backgroundColor
            newButton.setAttributedTitle(btn.0, for: .normal)
            newButton.addAction(for: .touchUpInside, closure: { [weak self] _ in
                if let closure = btn.1 {
                    closure()
                } else {
                    self?.dismiss(animated: true, completion: nil)
                }
            })
            newButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
            buttonsStack.addArrangedSubview(newButton)
        }
        
        if alertButtons.count > 2 {
            buttonsStack.axis = .vertical
        }
    }
}

private extension GSAlert {
    func setupContainer() {
        container.backgroundColor = backgroundColor
        container.layer.cornerRadius = 16
        container.addSubview(titleLabel)
        container.addSubview(messageStack)
        container.addSubview(buttonContainer)
        container.addSubview(separatorLine)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.clipsToBounds = true
        view.addSubview(container)
    }
    
    func setupMessageStack() {
        messageStack.axis = .vertical
        messageStack.distribution = .fill
        messageStack.alignment = .center
        messageStack.spacing = 8
        messageStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setUpbuttonsStack() {
        buttonsStack.axis = .horizontal
        buttonsStack.spacing = 8
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        buttonsStack.distribution = .fillEqually
        buttonsStack.spacing = 0.4
        buttonsStack.backgroundColor = .clear
        buttonsStack.clipsToBounds = true
        buttonContainer.addSubview(buttonsStack)
        
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.backgroundColor = .gray
    }
    
    func setupSeparatorLine() {
        separatorLine.backgroundColor = .gray
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func alignViews() {
        NSLayoutConstraint.activate([
            container.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            container.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            titleLabel.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 24),
            titleLabel.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -24),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),

            messageStack.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 24),
            messageStack.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -24),
            messageStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            
            separatorLine.leftAnchor.constraint(equalTo: container.leftAnchor),
            separatorLine.rightAnchor.constraint(equalTo: container.rightAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 0.5),
            separatorLine.topAnchor.constraint(equalTo: messageStack.bottomAnchor, constant: 16),

            separatorLine.bottomAnchor.constraint(equalTo: buttonContainer.topAnchor, constant: 0),
            buttonContainer.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 0),
            buttonContainer.rightAnchor.constraint(equalTo: container.rightAnchor, constant: 0),
            buttonContainer.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0),
            
            buttonsStack.topAnchor.constraint(equalTo: buttonContainer.topAnchor, constant: 0),
            buttonsStack.leftAnchor.constraint(equalTo: buttonContainer.leftAnchor, constant: 0),
            buttonsStack.rightAnchor.constraint(equalTo: buttonContainer.rightAnchor, constant: 0),
            buttonsStack.bottomAnchor.constraint(equalTo: buttonContainer.bottomAnchor, constant: 0),
        ])
    }
}

extension GSAlert: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return GSAlertPresentTransitioning()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return GSAlertDismissTransitioning()
    }
}

extension UIControl {
    /// Typealias for UIControl closure.
    public typealias UIControlTargetClosure = (UIControl) -> ()
    
    private class UIControlClosureWrapper: NSObject {
        let closure: UIControlTargetClosure
        init(_ closure: @escaping UIControlTargetClosure) {
            self.closure = closure
        }
    }
    
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    private var targetClosure: UIControlTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UIControlClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, UIControlClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }
    
    public func addAction(for event: UIControl.Event, closure: @escaping UIControlTargetClosure) {
        targetClosure = closure
        addTarget(self, action: #selector(UIControl.closureAction), for: event)
    }
}

class AlertBtn: UIButton {
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.secondarySystemBackground.withAlphaComponent(0.8) : UIColor.secondarySystemBackground
        }
    }
}
