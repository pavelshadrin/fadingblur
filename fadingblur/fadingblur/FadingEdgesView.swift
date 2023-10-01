//
//  File.swift
//  fadingblur
//
//  Created by Pavel Shadrin on 01.10.2023.
//

import UIKit

class FadingEdgesView: UIView {
    enum FadingEdges {
        case vertical(top: Double, bottom: Double)
        case horizontal(left: Double, right: Double)
    }
    
    private let edges: FadingEdges
    
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    private lazy var gradientMask: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()

        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        switch self.edges {
        case .vertical(let top, let bottom):
            gradientLayer.locations = [0.0, top as NSNumber, bottom as NSNumber, 1.0]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        case .horizontal(let left, let right):
            gradientLayer.locations = [0.0, left as NSNumber, right as NSNumber, 1.0]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        }

        return gradientLayer
    }()
    
    init(edges: FadingEdges) {
        self.edges = edges
        
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(contentView)
        
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientMask.frame = contentView.bounds
        contentView.layer.mask = gradientMask//?
        
        bringSubviewToFront(contentView)
    }
    
    private var subviewToFade: UIView?
    func addSubviewToFade(_ subview: UIView) {
        subviewToFade?.removeFromSuperview()
        contentView.addSubview(subview)
        subviewToFade = subview
        
        subviewToFade?.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        subviewToFade?.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        subviewToFade?.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        subviewToFade?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        setNeedsLayout()
    }
}
