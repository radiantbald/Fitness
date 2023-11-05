//
//  ExercisePageViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 22.10.2023.
//

import UIKit

class ExercisePageViewController: GeneralViewController {
    
    var presenter: ExercisePagePresenter!
    
    var exercise: ExerciseModel!
    
    private var exerciseTitle = UILabel()
    private var exerciseAbout = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exercisePageDesign()
        
        exerciseTitle.text = exercise?.title
        exerciseAbout.text = exercise?.about

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
extension ExercisePageViewController {
    
    func exercisePageDesign() {
        title = "Упражнение"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(setupExerciseSetupButton))
        
        view.addSubviews(exerciseTitle, exerciseAbout)
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            exerciseTitle.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            exerciseTitle.topAnchor.constraint(equalTo: margins.topAnchor, constant: 50),
            exerciseTitle.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            exerciseTitle.heightAnchor.constraint(equalToConstant: 50),
            
            exerciseAbout.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            exerciseAbout.topAnchor.constraint(equalTo: exerciseTitle.bottomAnchor, constant: 10),
            exerciseAbout.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            exerciseAbout.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    @objc func setupExerciseSetupButton() {
        let viewController = Assembler.controllers.exerciseSetupPageViewController
//        viewController.delegate = self
        navigationController?.present(viewController, animated: true)
    }
    
}

extension ExercisePageViewController: ExercisePagePresenterDelegate {
    
}
