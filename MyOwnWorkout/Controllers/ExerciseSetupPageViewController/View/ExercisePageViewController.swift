//
//  ExercisePageViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 22.10.2023.
//

import UIKit

protocol ExercisePageViewControllerDelegate: AnyObject {
    func reloadTableView()
}

class ExercisePageViewController: GeneralViewController {
    
    var presenter: ExercisePagePresenter!
    
    weak var delegate: ExercisePageViewControllerDelegate?
    
    var exerciseTitle = UILabel()
//    let exerciseMuscleGroup = UISwitch()
//    let exerciseNeededEquipment = UISwitch()
    var exerciseAbout = UILabel()
//    let saveExerciseButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exercisePageDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
extension ExercisePageViewController {
    
    func addExercise(_ title: String, _ about: String) {
        RealmDataBase.shared.setExercisesData(title, about)
        delegate?.reloadTableView()
        }
    
    func exercisePageDesign() {
  
        
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
}

extension ExercisePageViewController: ExercisePagePresenterDelegate {
    
}

