//
//  LocationToggle.swift
//  hse-hw2
//
//  Created by Egor Fedyaev on 20.12.2021.
//

import UIKit

class Toggle: UIView {
    
    private let title: String
    private let value: Bool
    private let callback: (UISwitch) -> ()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.textColor = .label
        return label
    }()
    
    lazy var switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = value
        switcher.translatesAutoresizingMaskIntoConstraints = true
        switcher.addTarget(self, action: #selector(onSwitcherToggle), for: .valueChanged)
        return switcher
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            switcher,
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.alignment = .leading
        stack.spacing = 8.0
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()
    
    init(frame: CGRect, title: String, value: Bool, callback: @escaping (UISwitch) -> ()) {
        self.title = title
        self.callback = callback
        self.value = value
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        self.addSubview(stack)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 64),
            self.widthAnchor.constraint(equalToConstant: 128)
        ])
    }
    
    @objc
    func onSwitcherToggle() {
        callback(switcher)
    }
}

