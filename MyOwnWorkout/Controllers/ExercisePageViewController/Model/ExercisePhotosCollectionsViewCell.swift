//
//  ExercisePhotosCollectionsViewCell.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 22.12.2023.
//

import UIKit

class ExercisePhotosCollectionsViewCell: UICollectionViewCell {
    
    static let cellID = "cellID"
    
    let exercisePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .systemRed
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(exercisePhotoImageView)
        NSLayoutConstraint.activate([
            exercisePhotoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            exercisePhotoImageView.topAnchor.constraint(equalTo: topAnchor),
            exercisePhotoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            exercisePhotoImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 12
        self.layer.shadowRadius = 7
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 8)
        self.clipsToBounds = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
