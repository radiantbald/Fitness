//
//  CalendarCollectionViewCell.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 27.02.2024.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    private let numberOfDayLabel: UILabel = {
        let label = UILabel()
        label.text = "27"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.text = "Вт"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        layer.cornerRadius = 10
        backgroundColor = .systemRed
        
        addSubviews(numberOfDayLabel, dayOfWeekLabel)
    }
    
    public func configure(_ model: DateModel) {
        numberOfDayLabel.text = model.numberOfDay
        dayOfWeekLabel.text = model.dayOfWeek
    }
}

extension CalendarCollectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            numberOfDayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            numberOfDayLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            dayOfWeekLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            dayOfWeekLabel.centerXAnchor.constraint(equalTo: centerXAnchor)   
        ])
    }
}
