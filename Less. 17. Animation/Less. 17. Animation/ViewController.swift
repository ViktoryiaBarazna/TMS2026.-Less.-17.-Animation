//
//  ViewController.swift
//  Less. 17. Animation
//
//  Created by Виктория Дисбаланс on 22.02.26.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - Subviews
    private let circleView = UIView()
    private let stackView = UIStackView()
    
    // MARK: - Lyfecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        setupCircleViewInitialPosition()
        createButtons()
    }
    
    // MARK: - Layout
    private func setupViewProperties() {
        view.backgroundColor = .black
    }
    
    private func setupSubviews() {
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.backgroundColor = .clear
        circleView.layer.cornerRadius = 50
        circleView.layer.borderWidth = 5
        circleView.layer.borderColor = UIColor.systemRed.cgColor
        circleView.layer.masksToBounds = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        view.addSubview(circleView)
        view.addSubview(stackView)
    }
    
    private func createButtons() {
        for title in ["Up", "Down", "Left", "Right"] {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitleColor(.white, for: .normal)
            button.setTitle(title, for: .normal)
            button.backgroundColor = .systemRed
            button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
            button.layer.cornerRadius = 20
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 270),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupCircleViewInitialPosition() {
        circleView.bounds.size = CGSize(width: 100, height: 100)
        circleView.center = view.center
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        
        switch title {
        case "Up":
            moveUp()
        case "Down":
            moveDown()
        case "Left":
            moveLeft()
        case "Right":
            moveRight()
        default:
            break
        }
    }
    
    private func moveUp() {
        var newCentre = circleView.center
        newCentre.y -= 100
        if isValidCenter(newCentre) {
            animateMove(to: newCentre)
        }
    }
    
    private func moveDown() {
        var newCentre = circleView.center
        newCentre.y += 100
        if isValidCenter(newCentre) {
            animateMove(to: newCentre)
        }
    }
    
    private func moveLeft() {
        var newCentre = circleView.center
        newCentre.x -= 100
        if isValidCenter(newCentre) {
            animateMove(to: newCentre)
        }
    }
    
    private func moveRight() {
        var newCentre = circleView.center
        newCentre.x += 100
        if isValidCenter(newCentre) {
            animateMove(to: newCentre)
        }
    }
    
    private func animateMove(to center: CGPoint) {
        UIView.animate(withDuration: 0.3) {
            self.circleView.center = center
            self.circleView.layer.borderColor = UIColor.random().cgColor
        }
    }
    
    private func isValidCenter(_ center: CGPoint) -> Bool {
        let radius = circleView.bounds.width / 2
        
        // Проверка на выход за границы экрана
        let minX = radius
        let maxX = view.bounds.width - radius
        let minY = radius
        let maxY = view.bounds.height - radius
        
        // Проверка на выход за пределы экрана
        guard center.x >= minX, center.x <= maxX,
              center.y >= minY, center.y <= maxY else {
            return false
        }
        
        // Проверка на пересечение с кнопками (stackView)
        if center.y + radius >= stackView.frame.minY {
            return false
        }
        return true
    }
}


extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1
        )
    }
}



