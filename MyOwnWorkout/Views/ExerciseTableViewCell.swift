//
//  ExerciseCell.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 15.10.2023.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {
    
    static let cellID = "cellID"
    
    let exerciseName = UILabel()
    let muscleGroupName = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        ExerciseTableViewCellDesign()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func ExerciseTableViewCellDesign() {
        
        let exerciseCellHStackView = UIStackView.init([exerciseName, muscleGroupName], .horizontal, 0, .fill, .equalCentering)
        
        self.addSubviews(exerciseCellHStackView)
        
        let margins = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            exerciseCellHStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            exerciseCellHStackView.topAnchor.constraint(equalTo: self.topAnchor),
            exerciseCellHStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            exerciseCellHStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            exerciseName.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30)
        ])
    }
    
    func configureName(nameOfExercise: String) {
        exerciseName.text = nameOfExercise
    }
}
