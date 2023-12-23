//
//  ExercisePageViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 22.10.2023.
//

import UIKit

protocol ExercisePageViewControllerDelegate: AnyObject {
    func reloadTableViewData()
}

class ExercisePageViewController: GeneralViewController {
    
    var presenter: ExercisePagePresenter!
    
    weak var delegate: ExercisePageViewControllerDelegate?
    
    var exercise: ExerciseModel!
    
    private var exercisePhotosCollectionView = ExercisePhotosCollectionView()
    
    private var exerciseTitle = UILabel("", UIFont(name: Fonts.main.rawValue, size: 20.0)!, .black)
    private var exerciseAbout = UILabel("", UIFont(name: Fonts.main.rawValue, size: 16.0)!, .black)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exercisePageDesign()
        
//        let imageURL = URL(string: "https://icdn.lenta.ru/images/2021/09/15/18/20210915183555038/square_1280_125ceca6620766b9a6467fa3159615c9.jpg")!
//        let data = try! Data(contentsOf: imageURL)
//        let image = UIImage(data: data)!
//        
//        let logo = UIImage(named: "CabinetLogo")
//        
//        var array = [image, logo]
        exercisePhotosCollectionView.set(cells: ExercisePhotosCollectionModel.fetchPhoto())

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
        
        view.addSubviews(exerciseTitle, exercisePhotosCollectionView, exerciseAbout)
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            exerciseTitle.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            exerciseTitle.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10),
            exerciseTitle.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            exerciseTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            exercisePhotosCollectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            exercisePhotosCollectionView.topAnchor.constraint(equalTo: exerciseTitle.bottomAnchor),
            exercisePhotosCollectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            exercisePhotosCollectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 275),
            
            exerciseAbout.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            exerciseAbout.topAnchor.constraint(equalTo: exercisePhotosCollectionView.bottomAnchor),
            exerciseAbout.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            exerciseAbout.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
        exerciseTitle.text = exercise?.title
        exerciseTitle.textAlignment = .center
        
        exerciseAboutFormatter()
        
    }
    
    func exerciseAboutFormatter() {
        if exercise?.about.count == 0 {
            exerciseAbout.text = "Нет описания выполнения упражнения"
            exerciseAbout.textColor = .gray
            exerciseAbout.numberOfLines = .max
            exerciseAbout.textAlignment = .justified
        } else {
            exerciseAbout.text = exercise?.about
            exerciseAbout.textColor = .black
            exerciseAbout.numberOfLines = .max
            exerciseAbout.textAlignment = .justified
        }
    }
    
    @objc func setupSetupExerciseButton() {
        let viewController = Assembler.controllers.setupExercisePageViewController(parent: self, exercise: exercise)
        navigationController?.present(viewController, animated: true)
    }
    
}

extension ExercisePageViewController: SetupExercisePageViewControllerDelegate {
    func changeExerciseOnExercisePage(_ exercise: ExerciseModel) {
        RealmDataBase.shared.set(exercise)
        exerciseTitle.text = exercise.title
        exerciseAbout.text = exercise.about
        exerciseAboutFormatter()
        delegate?.reloadTableViewData()
    }
}

extension ExercisePageViewController: ExercisePagePresenterDelegate {
    
}