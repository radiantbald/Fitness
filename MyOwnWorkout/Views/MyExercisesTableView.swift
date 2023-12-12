//
//  MyExercisesTableView.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 15.10.2023.
//

import UIKit

protocol MyExercisesTableViewDataSource: AnyObject {
    func tableView(_ tableView: MyExercisesTableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: MyExercisesTableView, cellForRowAt indexPath: IndexPath) -> [Any?]
    
}
protocol MyExercisesTableViewDelegate: AnyObject {
    func tableView(_ tableView: MyExercisesTableView, didSelectRowAt indexPath: IndexPath)
}

class MyExercisesTableView: UITableView {
    
    weak var myExercisesDataSource: MyExercisesTableViewDataSource?
    weak var myExercisesDelegate: MyExercisesTableViewDelegate?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        registerCell()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerCell() {
        register(ExerciseTableViewCell.self, forCellReuseIdentifier: ExerciseTableViewCell.cellID)
    }
    
    private func configure() {
        delegate = self
        dataSource = self
    }
}

extension MyExercisesTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myExercisesDelegate?.tableView(self, didSelectRowAt: indexPath)
    }
}

extension MyExercisesTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myExercisesDataSource?.tableView(self, numberOfRowsInSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseTableViewCell.cellID, for: indexPath) as? ExerciseTableViewCell else { return UITableViewCell() }
        
//        let exerciseModel = myExercisesDataSource?.tableView(self, cellForRowAt: indexPath)
//        let id = exerciseModel?[0]
//        let title = exerciseModel?[1]
//        let about = exerciseModel?[2]
        
//        cell.configure(exerciseIDSet: id as! String,
//                       exerciseTitleSet: title as! String,
//                       exerciseAboutSet: about as! String)
        
        return cell
    }
}
