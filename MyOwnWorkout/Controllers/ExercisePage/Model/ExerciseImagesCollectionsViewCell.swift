//
//  ExercisePhotosCollectionsViewCell.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 22.12.2023.
//

import UIKit

class ExerciseImagesCollectionsViewCell: UICollectionViewCell {
    
    static let cellID = "cellID"
    
    let highlightIndicator = UIView()
    let exerciseImageView = UIImageView()
    let liningImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(exerciseImageView, highlightIndicator, liningImageView)
        NSLayoutConstraint.activate([
            highlightIndicator.leadingAnchor.constraint(equalTo: leadingAnchor),
            highlightIndicator.topAnchor.constraint(equalTo: topAnchor),
            highlightIndicator.trailingAnchor.constraint(equalTo: trailingAnchor),
            highlightIndicator.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            exerciseImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            exerciseImageView.topAnchor.constraint(equalTo: topAnchor),
            exerciseImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            exerciseImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            liningImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            liningImageView.topAnchor.constraint(equalTo: topAnchor),
            liningImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            liningImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        exerciseImageView.clipsToBounds = true
        exerciseImageView.layer.cornerRadius = 12
        exerciseImageView.contentMode = .scaleAspectFill
        
        highlightIndicator.clipsToBounds = true
        highlightIndicator.isHidden = true
        highlightIndicator.layer.cornerRadius = 12
        highlightIndicator.backgroundColor = .white
        highlightIndicator.layer.opacity = 0.4
        
        liningImageView.clipsToBounds = false        
        layer.shadowOpacity = 0.3
    }
    
    override var isHighlighted: Bool {
        didSet {
            highlightIndicator.isHidden = !isHighlighted
        }
    }
    
    override var isSelected: Bool {
        didSet {
            highlightIndicator.isHidden = !isSelected
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
