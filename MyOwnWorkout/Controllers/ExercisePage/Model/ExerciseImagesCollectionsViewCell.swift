//
//  ExercisePhotosCollectionsViewCell.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 22.12.2023.
//

import UIKit

class ExerciseImagesCollectionsViewCell: UICollectionViewCell {
    
    static let cellID = "cellID"
    
    let exerciseImageView = UIImageView()
    let liningImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(exerciseImageView, liningImageView)
        NSLayoutConstraint.activate([
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
        
        liningImageView.clipsToBounds = false        
        layer.shadowOpacity = 0.3
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
