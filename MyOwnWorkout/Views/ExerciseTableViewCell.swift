//
//  ExerciseCell.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 15.10.2023.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {
    
    static let cellID = "cellID"
    
    let exerciseTitle = UILabel()
    let muscleGroup = UILabel()
    
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
        
        NSLayoutConstraint.activate([
//            exerciseCellHStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            exerciseCellHStackView.topAnchor.constraint(equalTo: self.topAnchor),
//            exerciseCellHStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            exerciseCellHStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
//            exerciseTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
    }
    
    func configure(titleOfExercise: String) {
        exerciseTitle.text = titleOfExercise
    }
}
