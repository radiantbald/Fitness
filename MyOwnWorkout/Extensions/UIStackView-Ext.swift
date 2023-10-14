//
//  UIStackView-Ext.swift
//  MyOwnWorkout
//
//  Created by Алмаз Рахматуллин on 14.10.2023.
//

import UIKit

extension UIStackView {
    
    convenience init(_ views: [UIView],
                     _ axis: NSLayoutConstraint.Axis,
                     _ spacing: CGFloat,
                     _ alignment: UIStackView.Alignment,
                     _ distribution: UIStackView.Distribution)
    {
        self.init(arrangedSubviews: views)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
        self.backgroundColor = .clear
    }
}
