//
//  Slider.swift
//  hse-hw2
//
//  Created by Egor Fedyaev on 20.12.2021.
//

import UIKit

class Slider: UIView {
    private let title: String
    private let value: Float
    private let callback: (Float) -> ()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.textColor = .label
        return label
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = value
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(onSlide(sender: )), for: .valueChanged)
        return slider
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            slider,
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 16.0
        
        return stack
    }()
    
    init(frame: CGRect, title: String, value: Float, callback: @escaping (Float) -> ()) {
        self.title = title
        self.value = value
        self.callback = callback
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(stack)
        
        NSLayoutConstraint.activate([
            // self.heightAnchor.constraint(equalToConstant: 36),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            slider.widthAnchor.constraint(equalToConstant: 180),
        ])
    }
    
    @objc
    func onSlide(sender: UISlider) {
        callback(sender.value)
    }
}
