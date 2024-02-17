//
//  WorkoutTableViewCell.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 27.01.2024.
//

import Foundation

import UIKit

class WorkoutTableViewCell: UITableViewCell {
    
    static let cellID = WorkoutTableViewCell.identifier
    
    private let workoutID = UILabel()
    private let workoutTitle = UILabel()
    private let workoutAbout = UILabel()
    private let workoutArea = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        ExerciseTableViewCellDesign()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func ExerciseTableViewCellDesign() {
        self.addSubviews(workoutTitle)
        let margins = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            workoutTitle.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
            workoutTitle.topAnchor.constraint(equalTo: margins.topAnchor, constant: 15),
            workoutTitle.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -10),
            workoutTitle.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -15)
        ])
    
        workoutTitle.numberOfLines = .max
        workoutTitle.textAlignment = .justified
    }
    
    func configure(workout: WorkoutModel) {
        workoutID.text = workout.id
        workoutTitle.text = workout.title
        workoutAbout.text = workout.about
    }
}
