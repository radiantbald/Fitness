//
//  ExerciseSetupPageViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 05.11.2023.
//

import UIKit

protocol SetupExercisePageViewControllerDelegate: AnyObject {
    func changeExerciseOnExercisePage(_ exercise: ExerciseModel)
}

class SetupExercisePageViewController: GeneralViewController {
    
    private let exercise: ExerciseModel
    var presenter: SetupExercisePagePresenter!
    private weak var delegate: SetupExercisePageViewControllerDelegate?
    
    init(parent: SetupExercisePageViewControllerDelegate? = nil, exercise: ExerciseModel) {
        self.exercise = exercise
        self.delegate = parent
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private let pageTitleLabel = UILabel("Редактирование", UIFont(name: Fonts.main.rawValue, size: 20.0)!, .black)
    private let exerciseTitleLabel = UILabel("Название упражнения", UIFont(name: Fonts.mainBold.rawValue, size: 14.0)!, .black)
    private let exerciseTitle = UITextField()
    private let exerciseAboutLabel = UILabel("Порядок выполнения упражнения", UIFont(name: Fonts.mainBold.rawValue, size: 14.0)!, .black)
    private let exerciseAbout = UITextField()
    private let saveExerciseButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exerciseSetupPageDesign()
        setupSaveExerciseButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension SetupExercisePageViewController {
    
    func setupSaveExerciseButton() {
        saveExerciseButton.addTarget(self, action: #selector(setupSaveExerciseButtonAction), for: .touchUpInside)
    }
    
    @objc func setupSaveExerciseButtonAction() {
        saveExercise(exerciseTitle.text ?? "Без названия", exerciseAbout.text ?? "Порядок выполнения")
        
    }
    
    func saveExercise(_ title: String, _ about: String) {
        if exerciseTitle.text?.count == 0 {
            showAlert(title: "Нет названия", message: "Назовите упражнение")
        } else {
            if exercise.title == title && exercise.about == about { return }
            
            let model = ExerciseModel()
            model.id = exercise.id
            model.title = title
            model.about = about
            
            delegate?.changeExerciseOnExercisePage(model)
            
            self.dismiss(animated: true)
        }
    }
    
    func exerciseSetupPageDesign() {
        
        view.addSubviews(pageTitleLabel, exerciseTitleLabel, exerciseAboutLabel, exerciseTitle, exerciseAbout, saveExerciseButton)
        
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            pageTitleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            pageTitleLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20),
            pageTitleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            
            exerciseTitleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
            exerciseTitleLabel.topAnchor.constraint(equalTo: pageTitleLabel.bottomAnchor, constant: 20),
            exerciseTitleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            
            exerciseTitle.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            exerciseTitle.topAnchor.constraint(equalTo: exerciseTitleLabel.bottomAnchor, constant: 5),
            exerciseTitle.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            
            exerciseAboutLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
            exerciseAboutLabel.topAnchor.constraint(equalTo: exerciseTitle.bottomAnchor, constant: 20),
            exerciseAboutLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            
            exerciseAbout.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            exerciseAbout.topAnchor.constraint(equalTo: exerciseAboutLabel.bottomAnchor, constant: 5),
            exerciseAbout.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            
            saveExerciseButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            saveExerciseButton.topAnchor.constraint(equalTo: exerciseAbout.bottomAnchor, constant: 30),
            saveExerciseButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            saveExerciseButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        pageTitleLabel.textAlignment = .center
        
        exerciseTitle.text = exercise.title
        exerciseTitle.placeholder = "Название упражнения"
        
        exerciseAbout.text = exercise.about
        exerciseAbout.placeholder = "Порядок выполнения упражнения"
        
        saveExerciseButton.setTitle("Сохранить", for: .normal)
        saveExerciseButton.backgroundColor = .systemRed
        saveExerciseButton.layer.cornerRadius = 12
    }
}

extension SetupExercisePageViewController: SetupExercisePagePresenterDelegate {
    
}
    
