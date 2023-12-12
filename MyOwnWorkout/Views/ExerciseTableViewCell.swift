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
    private let muscleGroup = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        ExerciseTableViewCellDesign()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func ExerciseTableViewCellDesign() {
        let exerciseCellHStackView = UIStackView.init([exerciseTitle, muscleGroup], .horizontal, 0, .fill, .equalCentering)
        self.addSubviews(exerciseCellHStackView)
    }
    
//    func configure(exerciseIDSet: String, exerciseTitleSet: String, exerciseAboutSet: String) {
//        exerciseID.text = exerciseIDSet
//        exerciseTitle.text = exerciseTitleSet
//        exerciseAbout.text = exerciseAboutSet
//    }
    
    func configure(exercise: ExerciseModel) {
        exerciseID.text = exercise.exerciseID
        exerciseTitle.text = exercise.title
        exerciseAbout.text = exercise.about
    }
}
