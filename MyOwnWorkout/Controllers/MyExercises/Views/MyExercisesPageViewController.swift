//
//  MyExersisesPageViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 13.08.2023.
//

import UIKit

//MARK: -
final class MyExercisesPageViewController: GeneralViewController {
    
    var presenter: MyExercisesPagePresenter!
    
    //MARK: - Переменные и константы класса
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var exercises: [ExerciseModel] = RealmDataBase.shared.get()
    
    private let dismissedExercisesLabel = UILabel()
    private let addExerciseButton = UIButton()
    
    //MARK: - Жизненный цикл класса
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
private extension MyExercisesPageViewController {
    
    func pageSettings() {
        setupNavigationBar()
        setupSubviews()
        setupMargins()
    }
    
    func setupNavigationBar() {
        title = "Мои упражнения"
        navigationItem.backButtonTitle = "Назад"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(setupAddExerciseButtons))
    }
    
    func setupSubviews() {
        setupTableView()
        setupDismissedExercisesLabel()
        setupAddExerciseButton()
    }
    
    func setupMargins() {
        let margins = view.safeAreaLayoutGuide
        
        if exercises.isEmpty {
            view.addSubviews(dismissedExercisesLabel, addExerciseButton)
            NSLayoutConstraint.activate([
                dismissedExercisesLabel.heightAnchor.constraint(equalToConstant: 50),
                dismissedExercisesLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 100),
                dismissedExercisesLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
                dismissedExercisesLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
                
                addExerciseButton.heightAnchor.constraint(equalToConstant: 50),
                addExerciseButton.topAnchor.constraint(equalTo: dismissedExercisesLabel.bottomAnchor, constant: 10),
                addExerciseButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
                addExerciseButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30)
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
            dismissedExercisesLabel.removeFromSuperview()
            addExerciseButton.removeFromSuperview()
        }
    }
    
    func setupTableView() {
        registerCell()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerCell() {
        tableView.register(ExerciseTableViewCell.self, forCellReuseIdentifier: ExerciseTableViewCell.cellID)
    }
    
    func setupDismissedExercisesLabel() {
        dismissedExercisesLabel.text = "Пока нет упражнений"
        dismissedExercisesLabel.textAlignment = .center
    }
    
    func setupAddExerciseButton() {
        addExerciseButton.setTitle("Добавить", for: .normal)
        addExerciseButton.backgroundColor = .systemRed
        addExerciseButton.layer.cornerRadius = 12
        
        addExerciseButton.addTarget(self, action: #selector(setupAddExerciseButtons), for: .touchUpInside)
    }
}

//MARK: - Селекторы
private extension MyExercisesPageViewController {
    @objc func setupAddExerciseButtons() {
        let viewController = Assembler.controllers.addExercisePageViewController
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: - Делегаты протокола MyExercisesTableViewDelegate

extension MyExercisesPageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let exercise = exercises[indexPath.row]
        let viewController = Assembler.controllers.exercisePageViewController
        viewController.exercise = exercise
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let exercise = exercises[indexPath.row]
        if editingStyle == .delete {
            tableView.beginUpdates()
            exercises.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
        RealmDataBase.shared.delete(exercise)
        exercises = RealmDataBase.shared.get()
        tableView.reloadData()
        
        pageSettings()
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

//MARK: - AddExercisePageViewControllerDelegate
extension MyExercisesPageViewController: AddExercisePageViewControllerDelegate {
    func addExerciseToTableView() {
        exercises = RealmDataBase.shared.get()
        tableView.reloadData()
        pageSettings()
    }
}

//MARK: - ExercisePageViewControllerDelegate
extension MyExercisesPageViewController: ExercisePageViewControllerDelegate {
    func reloadTableViewData() {
        tableView.reloadData()
    }
}

//MARK: - MyExercisesPagePresenterDelegate
extension MyExercisesPageViewController: MyExercisesPagePresenterDelegate {
    
}
