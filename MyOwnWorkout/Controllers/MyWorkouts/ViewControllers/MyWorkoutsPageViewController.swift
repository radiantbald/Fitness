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
        pageSettings()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

//MARK: - Настройки экрана
private extension MyWorkoutsPageViewController {
   
    func pageSettings() {
        setupNavigationBar()
        setupSubviews()
        setupMargins()
    }
    
    func setupNavigationBar() {
        title = "Мои тренировки"
        navigationItem.backButtonTitle = "Назад"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(setupAddWorkoutButtons))
    }
    
    func setupSubviews() {
        setupTableView()
        setupDismissedExercisesLabel()
        setupAddWorkoutButton()
    }
    
    func setupMargins() {
        let margins = view.safeAreaLayoutGuide
        
        if workouts.isEmpty {
            view.addSubviews(dismissedWorkoutLabel, addWorkoutButton)
            NSLayoutConstraint.activate([
                dismissedWorkoutLabel.heightAnchor.constraint(equalToConstant: 50),
                dismissedWorkoutLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 100),
                dismissedWorkoutLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
                dismissedWorkoutLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
                
                addWorkoutButton.heightAnchor.constraint(equalToConstant: 50),
                addWorkoutButton.topAnchor.constraint(equalTo: dismissedWorkoutLabel.bottomAnchor, constant: 10),
                addWorkoutButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
                addWorkoutButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30)
            ])
            tableView.removeFromSuperview()
        } else {
            view.addSubviews(tableView)
            NSLayoutConstraint.activate([
                tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
                tableView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0),
                tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
            ])
            dismissedWorkoutLabel.removeFromSuperview()
            addWorkoutButton.removeFromSuperview()
        }
    }
    
    func setupTableView() {
        registerCell()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerCell() {
        tableView.register(WorkoutTableViewCell.self, forCellReuseIdentifier: WorkoutTableViewCell.identifier)
    }
    
    func setupDismissedExercisesLabel() {
        dismissedWorkoutLabel.text = "Пока нет тренировок"
        dismissedWorkoutLabel.textAlignment = .center
    }
    
    func setupAddWorkoutButton() {
        addWorkoutButton.setTitle("Добавить", for: .normal)
        addWorkoutButton.backgroundColor = .systemRed
        addWorkoutButton.layer.cornerRadius = 12
        
        addWorkoutButton.addTarget(self, action: #selector(setupAddWorkoutButtons), for: .touchUpInside)
    }
}

//MARK: - Селекторы
private extension MyWorkoutsPageViewController {
    @objc func setupAddWorkoutButtons() {
        let viewController = Assembler.controllers.addWorkoutPageViewController
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
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

extension MyWorkoutsPageViewController: AddWorkoutPageViewControllerDelegate {
    func addWorkoutToTableView() {
        workouts = RealmDataBase.shared.get()
        tableView.reloadData()
        pageSettings()
    }
}

extension MyWorkoutsPageViewController: WorkoutPageViewControllerDelegate {
    func reloadTableViewData() {
        tableView.reloadData()
    }
}

extension MyWorkoutsPageViewController: MyWorkoutsPagePresenterDelegate {
    
}
