//
//  MyExersisesPageViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 13.08.2023.
//

import UIKit
import RealmSwift

class MyExercisesPageViewController: GeneralViewController {
    
    
    
    var presenter: MyExercisesPagePresenter!
    
    private let tableView = MyExercisesTableView()
    private var exercises: Results<ExerciseModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exercises = RealmDataBase.shared.getExercisesData()
        
        MyExercisesPageDesign()
        tableView.myExercisesDataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension MyExercisesPageViewController {
    
    func MyExercisesPageDesign() {
        title = "Мои упражнения"
        navigationItem.backButtonTitle = "Отменить"
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
        
//        AddExerciseAlert.showAddExerciseAlert(viewController: self,
//                                              title: "Новое упражнение") { [weak self] exercise in
//            guard let self else { return }
//            self.addExercise(exercise)
//        }
    }
    
//    func addExercise(_ title: String) {
//        RealmDataBase.shared.setExercisesData(title)
//        self.tableView.reloadData()
//    }
    
}

extension MyExercisesPageViewController: MyExercisesTableViewDataSource {
    func tableView(_ tableView: MyExercisesTableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: MyExercisesTableView, cellForRowAt indexPath: IndexPath) -> String {
        let exercise = exercises[indexPath.row]
        return exercise.title
    }
}
extension MyExercisesPageViewController: ExerciseSetupPageViewControllerDelegate {
    func reloadTableView() {
        self.tableView.reloadData()
        print("делегат сработал")
    }
}
extension MyExercisesPageViewController: MyExercisesPagePresenterDelegate {
    
}