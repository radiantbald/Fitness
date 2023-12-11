//
//  ExercisePageViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 22.10.2023.
//

import UIKit

protocol ExercisePageViewControllerDelegate: AnyObject {
    func changeExerciseInTableView(_ title: String, _ about: String)
}

class ExercisePageViewController: GeneralViewController {
    
    var presenter: ExercisePagePresenter!
    
    weak var delegate: ExercisePageViewControllerDelegate?
    
    var exercise: ExerciseModel!
    
    private var exerciseTitle = UILabel()
    private var exerciseAbout = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exercisePageDesign()
//        exerciseTitle.text = exercise?.title
//        exerciseAbout.text = exercise?.about

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
        navigationItem.backButtonTitle = "Назад"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(setupSetupExerciseButton))
        
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
        
        exerciseTitle.text = exercise?.title
        exerciseAbout.text = exercise?.about
        
    }
    
    @objc func setupSetupExerciseButton() {
        let viewController = Assembler.controllers.setupExercisePageViewController
        viewController.delegate = self
        viewController.exerciseTitle.placeholder = exercise?.title
        viewController.exerciseAbout.placeholder = exercise?.about
        navigationController?.present(viewController, animated: true)
    }
    
}

extension ExercisePageViewController: SetupExercisePageViewControllerDelegate {
    func changeExerciseOnExercisePage(_ title: String, _ about: String) {
        exerciseTitle.text = title
        exerciseAbout.text = about
        delegate?.changeExerciseInTableView(title, about)
    }
}

extension ExercisePageViewController: ExercisePagePresenterDelegate {
    
}
