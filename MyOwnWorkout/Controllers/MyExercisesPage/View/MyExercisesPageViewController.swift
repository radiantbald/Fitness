//
//  MyExersisesPageViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 13.08.2023.
//

import UIKit

class MyExercisesPageViewController: GeneralViewController {
    
    var presenter: MyExercisesPagePresenter!
    
    private let myExercisesTableView = MyExercisesTableView()
    
    private var exercises: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyExercisesPageDesign()

        
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(setupAddExerciseButton))
        
        view.addSubviews(myExercisesTableView)
        
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            myExercisesTableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            myExercisesTableView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10),
            myExercisesTableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            myExercisesTableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
    
    @objc func setupAddExerciseButton() {
        AddExerciseAlert.showAddExerciseAlert(viewController: self,
                                              title: "Новое упражнение") { [weak self] exercise in
            guard let self else { return }
            
            self.exercises.append(exercise)
            self.myExercisesTableView.addExercise(exercises)

            self.myExercisesTableView.reloadData()
        }
    }
    
}

extension MyExercisesPageViewController: MyExercisesPagePresenterDelegate {
    
}
