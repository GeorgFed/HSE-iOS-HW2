//
//  SettingsViewController.swift
//  hse-hw2
//
//  Created by Egor Fedyaev on 20.12.2021.
//

import UIKit

enum RGB {
    case red, green, blue
    
    var rawValue: String {
        switch self {
            case .red: return "Red"
            case .green: return "Green"
            case .blue: return "Blue"
        }
    }
}

class SettingsViewController: UIViewController {
    
    weak var delegate: SettingsDelegate?
    
    var colorComponents: [RGB:Float]?
    var toggleValue: Bool?
    
    lazy var toggle: Toggle = {
        let toggle = Toggle(frame: .zero, title: "Location", value: toggleValue ?? false) { [weak self] sender in
            self?.delegate?.shouldTrackLocation(sender)
        }
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .leading
        stack.distribution = .fillEqually
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        stack.addArrangedSubview(toggle)
        [RGB.red, RGB.green, RGB.blue].forEach { color in
            stack.addArrangedSubview(Slider(frame: .zero, title: color.rawValue, value: colorComponents?[color] ?? 1, callback: { [weak self] value in
                self?.delegate?.updateColor(colorName: color, colorValue: value)
            }))
        }
        
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 96),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
