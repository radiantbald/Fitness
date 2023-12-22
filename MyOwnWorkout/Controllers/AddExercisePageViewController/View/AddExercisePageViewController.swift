//
//  ExercisePageViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 21.10.2023.
//

import UIKit

protocol AddExercisePageViewControllerDelegate: AnyObject {
    func addExerciseToTableView()
}

class AddExercisePageViewController: GeneralViewController {
    
    var presenter: AddExercisePagePresenter!
    
    weak var delegate: AddExercisePageViewControllerDelegate?
    
    private let pageTitleLabel = UILabel("Создание", UIFont(name: Fonts.main.rawValue, size: 20.0)!, .black)
    private let exerciseTitleLabel = UILabel("Название упражнения", UIFont(name: Fonts.mainBold.rawValue, size: 14.0)!, .black)
    private let exerciseTitle = UITextView()
    private let exerciseAboutLabel = UILabel("Порядок выполнения упражнения", UIFont(name: Fonts.mainBold.rawValue, size: 14.0)!, .black)
    private let exerciseAbout = UITextView()
    private let saveExerciseButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addExercisePageDesign()
        setupSaveExerciseButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
extension AddExercisePageViewController {
    
    func setupSaveExerciseButton() {
        saveExerciseButton.addTarget(self, action: #selector(setupSaveExerciseButtonAction), for: .touchUpInside)
    }
    
    @objc func setupSaveExerciseButtonAction() {
        saveExercise(exerciseTitle.text!,
                     exerciseAbout.text!,
                     "333") // сюда сохранять стрингу зашифрованного массива фоток
        
    }
    
    func saveExercise( _ title: String, _ about: String, _ photosArray: String) {
        
        if exerciseTitle.text?.count == 0 {
            showAlert(title: "Нет названия", message: "Назовите упражнение")
        } else {
            let exercise = ExerciseModel(title: title, about: about, photosArray: photosArray)
            RealmDataBase.shared.set(exercise)
            delegate?.addExerciseToTableView()
            self.dismiss(animated: true)
        }
    }
    
    func addExercisePageDesign() {
        
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
            exerciseTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 36),
            
            exerciseAboutLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
            exerciseAboutLabel.topAnchor.constraint(equalTo: exerciseTitle.bottomAnchor, constant: 20),
            exerciseAboutLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            
            exerciseAbout.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            exerciseAbout.topAnchor.constraint(equalTo: exerciseAboutLabel.bottomAnchor, constant: 5),
            exerciseAbout.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            exerciseAbout.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            saveExerciseButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            saveExerciseButton.topAnchor.constraint(equalTo: exerciseAbout.bottomAnchor, constant: 30),
            saveExerciseButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            saveExerciseButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        pageTitleLabel.textAlignment = .center
        
        setupExerciseTitleTextView()
        setupExerciseAboutTextView()
        
        saveExerciseButton.setTitle("Сохранить", for: .normal)
        saveExerciseButton.backgroundColor = .systemRed
        saveExerciseButton.layer.cornerRadius = 12
    }
    func setupExerciseTitleTextView() {
        exerciseTitle.isSelectable = true
        exerciseTitle.isEditable = true
        exerciseTitle.font = UIFont(name: Fonts.main.rawValue, size: 16.0)!
        exerciseTitle.layer.borderWidth = 0.5
        exerciseTitle.layer.borderColor = UIColor.lightGray.cgColor
        exerciseTitle.layer.cornerRadius = 12
    }
    func setupExerciseAboutTextView() {
        exerciseAbout.isSelectable = true
        exerciseAbout.isEditable = true
        exerciseAbout.font = UIFont(name: Fonts.main.rawValue, size: 16.0)!
        exerciseAbout.layer.borderWidth = 0.5
        exerciseAbout.layer.borderColor = UIColor.lightGray.cgColor
        exerciseAbout.layer.cornerRadius = 12
    }
}

extension AddExercisePageViewController: AddExercisePagePresenterDelegate {
    
}
