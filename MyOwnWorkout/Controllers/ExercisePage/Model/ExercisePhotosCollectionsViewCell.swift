//
//  ExercisePhotosCollectionsViewCell.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 22.12.2023.
//

import UIKit

class ExercisePhotosCollectionsViewCell: UICollectionViewCell {
    
    static let cellID = "cellID"
    
    let exercisePhotoImageView = UIImageView()
    let liningImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(exercisePhotoImageView, liningImageView)
        NSLayoutConstraint.activate([
            exercisePhotoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            exercisePhotoImageView.topAnchor.constraint(equalTo: topAnchor),
            exercisePhotoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            exercisePhotoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            liningImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            liningImageView.topAnchor.constraint(equalTo: topAnchor),
            liningImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            liningImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        exercisePhotoImageView.clipsToBounds = true
        exercisePhotoImageView.layer.cornerRadius = 12
        exercisePhotoImageView.contentMode = .scaleAspectFill
        
        liningImageView.clipsToBounds = false        
        layer.shadowOpacity = 0.3
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
