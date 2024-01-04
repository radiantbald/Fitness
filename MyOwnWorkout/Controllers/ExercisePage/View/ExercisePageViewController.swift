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
    var exerciseImagesArray: [ExerciseImagesCollectionModel] = []
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private let layout = UICollectionViewFlowLayout()
    
    private var exerciseTitle = UILabel("", UIFont(name: Fonts.main.rawValue, size: 20.0)!, .black)
    private var exerciseAbout = UILabel("", UIFont(name: Fonts.main.rawValue, size: 16.0)!, .black)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSettings()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
extension ExercisePageViewController {
    
    func pageSettings() {
        setupNavigationBar()
        setupSubviews()
        setupMargins()
        getExerciseImagesFromData()
    }
    
    func setupNavigationBar() {
        title = "Упражнение"
        navigationItem.backButtonTitle = "Назад"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(setupSetupExerciseButton))
    }
    
    @objc func setupSetupExerciseButton() {
        let viewController = Assembler.controllers.setupExercisePageViewController(parent: self, exercise: exercise)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setupSubviews() {
        setupExerciseTitleLabel()
        setupCollectionView()
        setupExerciseAboutLabel()
        
        view.addSubviews(exerciseTitle,
                         collectionView,
                         exerciseAbout)
    }
    func setupMargins() {
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
    }
    
    private func setupExerciseTitleLabel() {
        exerciseTitle.text = exercise?.title
        exerciseTitle.textAlignment = .center
    }
    
    private func getExerciseImagesFromData() {
        let imagesDataList = exercise.imagesDataList.compactMap{Data($0)}
        print(imagesDataList)
        for imageData in imagesDataList {
            guard let image = UIImage(data: imageData) else { continue }
            exerciseImagesArray.append(ExerciseImagesCollectionModel.init(image: image))
        }
    }
    
    func setupExerciseAboutLabel() {
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
    
}

extension ExercisePageViewController: SetupExercisePageViewControllerDelegate {
    func changeExerciseOnExercisePage(_ exercise: ExerciseModel) {
        exerciseImagesArray.removeAll()
        RealmDataBase.shared.set(exercise)
        exerciseTitle.text = exercise.title
        exerciseAbout.text = exercise.about
        pageSettings()
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
        collectionView.register(ExerciseImagesCollectionsViewCell.self, forCellWithReuseIdentifier: ExerciseImagesCollectionsViewCell.cellID)
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Constants.minimumLineSpacing
        
    }
    
}

extension ExercisePageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exerciseImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseImagesCollectionsViewCell.cellID, for: indexPath) as! ExerciseImagesCollectionsViewCell
        cell.exerciseImageView.image = exerciseImagesArray[indexPath.row].image
        cell.layer.shadowRadius = 9
        return cell
    }
}

extension ExercisePageViewController: ExerciseImageViewerViewControllerDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.exerciseImagesArray[indexPath.row]
        let viewController = Assembler.controllers.exerciseImageViewerViewController(parent: self, image: item)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ExercisePageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.itemWidth, height: collectionView.frame.height * 0.8)
    }
}

extension ExercisePageViewController: ExercisePagePresenterDelegate {
    
}
