//
//  MyExersisesPageViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 13.08.2023.
//

import UIKit

class MyExercisesPageViewController: GeneralViewController {
    
    var presenter: MyExercisesPagePresenter!
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var exercises: [ExerciseModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        tableView.delegate = self
        tableView.dataSource = self
        exercises = RealmDataBase.shared.getExercisesData()
        MyExercisesPageDesign()
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
}

extension MyExercisesPageViewController {
    
    func MyExercisesPageDesign() {
        title = "Мои упражнения"
        navigationItem.backButtonTitle = "Назад"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(setupAddExerciseButton))
        
        view.addSubviews(tableView)
        
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
    
    @objc func setupAddExerciseButton() {
        let viewController = Assembler.controllers.exerciseSetupPageViewController
        viewController.delegate = self
        navigationController?.present(viewController, animated: true)
    }
    
}

//MARK: - Делегаты протокола MyExercisesTableViewDelegate

extension MyExercisesPageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let exercise = exercises[indexPath.row]
        let viewController = Assembler.controllers.exercisePageViewController
        viewController.exercise = exercise
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: - Делегаты протокола MyExercisesTableViewDataSource

extension MyExercisesPageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseTableViewCell.cellID, for: indexPath) as? ExerciseTableViewCell else { return UITableViewCell() }
        let exercise = exercises[indexPath.row]
        cell.configure(exercise: exercise)
        return cell
    }
}

//MARK: - Делегаты ExerciseSetupPageViewControllerDelegate

extension MyExercisesPageViewController: ExerciseSetupPageViewControllerDelegate {
    func reloadTableView() {
        exercises = RealmDataBase.shared.getExercisesData()
        tableView.reloadData()
    }
}

//MARK: - Делегаты Презентера
extension MyExercisesPageViewController: MyExercisesPagePresenterDelegate {
    
}
