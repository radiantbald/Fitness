//
//  EyeButton.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 18.06.2023.
//

import UIKit

final class EyeButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupEyeButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupEyeButton() {
        setImage(UIImage(systemName: "eye"), for: .normal)
        tintColor = .systemRed
        widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
