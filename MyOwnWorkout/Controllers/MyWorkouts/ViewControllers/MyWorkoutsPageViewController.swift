//
//  MyWorkoutsPageViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 13.08.2023.
//

import UIKit

class MyWorkoutsPageViewController: GeneralViewController {
    
    var presenter: MyWorkoutsPagePresenter!
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var workouts: [WorkoutModel] = RealmDataBase.shared.get()
    
    let dismissedWorkoutLabel = UILabel()
    let addWorkoutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = "Мои тренировки"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(setupAddWorkoutButtons))
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    private func registerCell() {
        tableView.register(ExerciseTableViewCell.self, forCellReuseIdentifier: ExerciseTableViewCell.cellID)
    }
    
    func setupAddWorkoutButton() {
        addWorkoutButton.addTarget(self, action: #selector(setupAddWorkoutButtons), for: .touchUpInside)
    }
    @objc func setupAddWorkoutButtons() {
//        let viewController = Assembler.controllers.addWorkoutPageViewController
//        viewController.delegate = self
//        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

//MARK: - Делегаты протокола MyExercisesTableViewDelegate

extension MyWorkoutsPageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workout = workouts[indexPath.row]
        let viewController = Assembler.controllers.workoutPageViewController
        viewController.workout = workout
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let workout = workouts[indexPath.row]
        
        if editingStyle == .delete {
            tableView.beginUpdates()
            workouts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
        RealmDataBase.shared.delete(workout)
        workouts = RealmDataBase.shared.get()
        tableView.reloadData()
        
//        setSubviews()
    }
}

//MARK: - Делегаты протокола MyExercisesTableViewDataSource

extension MyWorkoutsPageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutTableViewCell.cellID, for: indexPath) as? WorkoutTableViewCell else { return UITableViewCell() }
        let workout = workouts[indexPath.row]
        cell.configure(workout: workout)
        return cell
    }
}

extension MyWorkoutsPageViewController: WorkoutPageViewControllerDelegate {
    func reloadTableViewData() {
        tableView.reloadData()
    }
}

extension MyWorkoutsPageViewController: MyWorkoutsPagePresenterDelegate {
    
}
