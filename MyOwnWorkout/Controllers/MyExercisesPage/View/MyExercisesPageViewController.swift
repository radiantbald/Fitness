//
//  MyExersisesPageViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 13.08.2023.
//

import UIKit

class MyExercisesPageViewController: GeneralViewController {
    
    var presenter: MyExercisesPagePresenter!
    
    private var exercisesList: [UIView] = []
    
    private let exercisesTableView: UITableView = {
        let exercisesTableView = UITableView()
        exercisesTableView.backgroundColor = .systemBackground
        exercisesTableView.allowsSelection = true
        exercisesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return exercisesTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyExercisesPageDesign()
        
        exercisesTableView.delegate = self
        exercisesTableView.dataSource = self
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
        navigationItem.title = "Мои упражнения"
        
        view.addSubviews(exercisesTableView)
        
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            exercisesTableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            exercisesTableView.topAnchor.constraint(equalTo: margins.topAnchor),
            exercisesTableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            exercisesTableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
}

extension MyExercisesPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercisesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = indexPath.row.description
        
        return cell
    }
}

extension MyExercisesPageViewController: MyExercisesPagePresenterDelegate {
    
}
