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
    var exercisePhotos: [ExercisePhotosCollectionModel] = []
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private let layout = UICollectionViewFlowLayout()
    
    private var exerciseTitle = UILabel("", UIFont(name: Fonts.main.rawValue, size: 20.0)!, .black)
    private var exerciseAbout = UILabel("", UIFont(name: Fonts.main.rawValue, size: 16.0)!, .black)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()        
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
    
    func exercisePageDesign() {
        title = "Упражнение"
        navigationItem.backButtonTitle = "Назад"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(setupSetupExerciseButton))
        
        view.addSubviews(exerciseTitle, collectionView, exerciseAbout)
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            exerciseTitle.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            exerciseTitle.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10),
            exerciseTitle.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            exerciseTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            collectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: exerciseTitle.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            collectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 275),
            
            exerciseAbout.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            exerciseAbout.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
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
        navigationController?.pushViewController(viewController, animated: true)
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

extension ExercisePageViewController {
    func setupCollectionView() {
        collectionView = .init(frame: .zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: Constants.leftDistanceToView, bottom: 0, right: Constants.rightDistanceToView)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ExercisePhotosCollectionsViewCell.self, forCellWithReuseIdentifier: ExercisePhotosCollectionsViewCell.cellID)
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Constants.minimumLineSpacing
        
//        setExercisePhotos(photos: ExercisePhotosCollectionModel.fetchPhoto())
    }
    
//    func setExercisePhotos(photos: [ExercisePhotosCollectionModel]) {
//        self.exercisePhotos = photos
//    }
}

extension ExercisePageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exercisePhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExercisePhotosCollectionsViewCell.cellID, for: indexPath) as! ExercisePhotosCollectionsViewCell
        cell.exercisePhotoImageView.image = exercisePhotos[indexPath.row].photo
        cell.layer.shadowRadius = 9
        return cell
    }
}

extension ExercisePageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.itemWidth, height: collectionView.frame.height * 0.8)
    }
}

extension ExercisePageViewController: ExercisePagePresenterDelegate {
    
}
