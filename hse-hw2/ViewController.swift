//
//  ViewController.swift
//  hse-hw2
//
//  Created by Egor Fedyaev on 20.12.2021.
//

import UIKit
import CoreLocation

protocol SettingsDelegate: AnyObject {
    func updateColor(colorName: RGB, colorValue: Float)
    func shouldTrackLocation(_ sender: UISwitch)
}

class ViewController: UIViewController {
    
    private lazy var locationLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()
    
    var colorComponents: [RGB:Float] = [
        .red: 1,
        .green: 1,
        .blue: 1,
    ]
    
    var toggleValue = false
    
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        setupUI()
    }

    func setupUI() {
        view.addSubview(locationLabel)
        
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(onSettigsTapped))
        
        NSLayoutConstraint.activate([
            locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc
    func onSettigsTapped() {
        let controller = SettingsViewController()
        controller.delegate = self
        controller.toggleValue = toggleValue
        controller.colorComponents = colorComponents
        self.show(controller, sender: nil)
    }
}

extension ViewController: SettingsDelegate {
    func updateColor(colorName: RGB, colorValue: Float) {
        colorComponents[colorName] = colorValue
        view.backgroundColor = UIColor(red: CGFloat(colorComponents[.red] ?? 1),
                                       green: CGFloat(colorComponents[.green] ?? 1),
                                       blue: CGFloat(colorComponents[.blue] ?? 1),
                                       alpha: 1)
    }
    
    func shouldTrackLocation(_ sender: UISwitch) {
        if sender.isOn {
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            } else {
                sender.setOn(false, animated: true)
            }
        } else {
            locationManager.stopUpdatingLocation()
            locationLabel.text = ""
        }
        toggleValue = sender.isOn
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coord = manager.location?.coordinate else {
            return
        }
        
        locationLabel.text = "\(coord.latitude), \(coord.longitude)"
    }
}
