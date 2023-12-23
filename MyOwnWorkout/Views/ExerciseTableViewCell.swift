//
//  ExerciseCell.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 15.10.2023.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {
    
    static let cellID = "cellID"
    
    private let exerciseID = UILabel()
    private let exerciseTitle = UILabel()
    private let exerciseAbout = UILabel()
    private let exerciseMuscleGroup = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        ExerciseTableViewCellDesign()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func ExerciseTableViewCellDesign() {
//        let exerciseCellVStackView = UIStackView.init([exerciseTitle], .vertical, 0, .leading, .fillEqually)
//        self.addSubviews(exerciseCellVStackView)
        self.addSubviews(exerciseTitle)
        let margins = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            exerciseTitle.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
            exerciseTitle.topAnchor.constraint(equalTo: margins.topAnchor, constant: 15),
            exerciseTitle.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -10),
            exerciseTitle.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -15)
        ])
    
        exerciseTitle.numberOfLines = .max
        exerciseTitle.textAlignment = .justified
    }
    
    func configure(exercise: ExerciseModel) {
        exerciseID.text = exercise.id
        exerciseTitle.text = exercise.title
        exerciseAbout.text = exercise.about
    }
}
