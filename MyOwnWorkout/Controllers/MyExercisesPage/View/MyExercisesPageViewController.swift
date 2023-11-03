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
    private var exercises: Results<Exercises>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exercises = DBManager.shared.getExercises()
        myExercisesPageDesign()
        tableView.myDataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension MyExercisesPageViewController {
    
    func myExercisesPageDesign() {
        title = "Мои упражнения"
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
        AddExerciseAlert.showAddExerciseAlert(viewController: self,
                                              title: "Новое упражнение") { [weak self] exercise in
            guard let self else { return }
            self.add(exercise)
        }
    }
    
    
    func add(_ text: String) {
        DBManager.shared.add(text)
        self.tableView.reloadData()
    }
}

extension MyExercisesPageViewController: MyExercisesPagePresenterDelegate {
    
}

extension MyExercisesPageViewController: MyExercisesTableViewDataSource {
    func tableView(_ tableView: MyExercisesTableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: MyExercisesTableView, cellForRowAt indexPath: IndexPath) -> String {
        let value = exercises[indexPath.row]
        return value.name
    }
}
