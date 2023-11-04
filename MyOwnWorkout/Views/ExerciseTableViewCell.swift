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
        let exerciseCellHStackView = UIStackView.init([exerciseTitle, exerciseMuscleGroup], .horizontal, 0, .fill, .equalCentering)
        self.addSubviews(exerciseCellHStackView)
    }
    
    func configure(exercise: ExerciseModel) {
        exerciseID.text = exercise.id
        exerciseTitle.text = exercise.title
        exerciseAbout.text = exercise.about
    }
}
