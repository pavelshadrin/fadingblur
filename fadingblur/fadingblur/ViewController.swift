//
//  ViewController.swift
//  fadingblur
//
//  Created by Pavel Shadrin on 29.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Views
    
    private let backgroundImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "sunset"))
        
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private let mainStackView: UIStackView = {
        let mainStackView = UIStackView(frame: .zero)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.alignment = .fill
        mainStackView.spacing = 0.0
        mainStackView.backgroundColor = .clear
        
        return mainStackView
    }()
    
    private let opaqueOneColorView: FadingEdgesView = {
        let view = FadingEdgesView(edges: .horizontal(left: 0.3, right: 0.7))
        view.backgroundColor = .gray
        return view
    }()
    
    private let semiTransparentOneColorView: FadingEdgesView = {
        let view = FadingEdgesView(edges: .horizontal(left: 0.3, right: 0.7))
        view.backgroundColor = .gray.withAlphaComponent(0.4)
        return view
    }()
    
    private let blurredView: FadingEdgesView = {
        let view = FadingEdgesView(edges: .horizontal(left: 0.3, right: 0.7))
        
        view.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        view.insertSubview(blurView, at: 0)

        blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        blurView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        return view
    }()
    
    private let multiColorView: FadingEdgesView = {
        let view = FadingEdgesView(edges: .horizontal(left: 0.3, right: 0.7))
        if let image = UIImage(named: "background.png") {
            view.backgroundColor = UIColor(patternImage: image)
        }
        
        return view
    }()
    
    private let clearView: FadingEdgesView = {
        let view = FadingEdgesView(edges: .horizontal(left: 0.3, right: 0.7))
        view.backgroundColor = .clear
        return view
    }()
    
    private func makeScrollableDemoView() -> UIView {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView()
        scrollView.addSubview(stackView)
        
        stackView.spacing = 40
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for string in ["This", "is", "a", "test", "scrollable", "view"] {
            let label = UILabel(frame: .zero)
            label.font = .systemFont(ofSize: 24, weight: .bold)
            label.text = string
            stackView.addArrangedSubview(label)
        }
        
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        
        return scrollView
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backgroundImageView)
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(mainStackView)
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainStackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        mainStackView.addArrangedSubview(opaqueOneColorView)
        mainStackView.addArrangedSubview(semiTransparentOneColorView)
        mainStackView.addArrangedSubview(blurredView)
        mainStackView.addArrangedSubview(multiColorView)
        mainStackView.addArrangedSubview(clearView)
        
        mainStackView.arrangedSubviews.forEach { view in
            if let fadingView = view as? FadingEdgesView {
                let demoView = makeScrollableDemoView()
                fadingView.addSubviewToFade(demoView)
            }
        }
    }
}

