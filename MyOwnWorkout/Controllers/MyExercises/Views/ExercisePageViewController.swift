//
//  ExercisePageViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 22.10.2023.
//

import UIKit

//MARK: - Протоколы класса
protocol ExercisePageViewControllerDelegate: AnyObject {
    func reloadTableViewData()
}

//MARK: -
class ExercisePageViewController: GeneralViewController {
    
    var presenter: ExercisePagePresenter!
    var exercise: ExerciseModel!
    
    //MARK: - Переменные и константы класса
    private var exerciseImagesDataArray = [ExerciseImageDataModel]()
    weak var delegate: ExercisePageViewControllerDelegate?
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private let layout = UICollectionViewFlowLayout()
    
    private var exerciseTitle = UILabel("", UIFont(name: Fonts.main.rawValue, size: 20.0)!, .black)
    private var exerciseAbout = UILabel("", UIFont(name: Fonts.main.rawValue, size: 16.0)!, .black)
    
    //MARK: - Жизненный цикл класса
    override func viewDidLoad() {
        super.viewDidLoad()
        getExerciseImagesFromData()
        pageSettings()
    }
}

//MARK: - Настройки экрана
private extension ExercisePageViewController {
    
    func pageSettings() {
        setupNavigationBar()
        setupSubviews()
        setupMargins()
    }
    
    func setupNavigationBar() {
        title = "Упражнение"
        navigationItem.backButtonTitle = "Назад"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(setupBackButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(setupSetupExerciseButton))
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
    
    func setupExerciseTitleLabel() {
        exerciseTitle.text = exercise?.title
        exerciseTitle.textAlignment = .center
    }
    
    func getExerciseImagesFromData() {
        
        let imagesDataList = exercise.imagesDataList.compactMap{Data($0)}
        print(imagesDataList)
        for imageData in imagesDataList {
            let imagesData = ExerciseImageDataModel(image: imageData)
            RealmDataBase.shared.set(imagesData)
        }
        exerciseImagesDataArray = RealmDataBase.shared.get()
    }
    
    func setupCollectionView() {
        collectionView = .init(frame: .zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: Constants.leftDistanceToView, bottom: 0, right: Constants.rightDistanceToView)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ExerciseImagesCollectionViewCell.self, forCellWithReuseIdentifier: ExerciseImagesCollectionViewCell.cellID)
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Constants.minimumLineSpacing
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

//MARK: - Селекторы
private extension ExercisePageViewController {
    
    @objc func setupSetupExerciseButton() {
        let viewController = Assembler.controllers.setupExercisePageViewController(parent: self, exercise: exercise)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func setupBackButton() {
        RealmDataBase.shared.deleteTable(ExerciseImageDataModel.self)
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - SetupExercisePageViewControllerDelegate
extension ExercisePageViewController: SetupExercisePageViewControllerDelegate {
    func changeExerciseOnExercisePage(_ exercise: ExerciseModel) {
        RealmDataBase.shared.set(exercise)
        exerciseTitle.text = exercise.title
        exerciseAbout.text = exercise.about
        exerciseImagesDataArray = RealmDataBase.shared.get()
        pageSettings()
        delegate?.reloadTableViewData()
    }
}

//MARK: - ExerciseImageViewerViewControllerDelegate
extension ExercisePageViewController: ExerciseImageViewerViewControllerDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.exerciseImagesDataArray[indexPath.row]
        let data = item.image
        let viewController = Assembler.controllers.exerciseImageViewerViewController(parent: self, image: data)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: - UICollectionViewDataSource
extension ExercisePageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exerciseImagesDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseImagesCollectionViewCell.cellID, for: indexPath) as! ExerciseImagesCollectionViewCell
        let data = exerciseImagesDataArray[indexPath.row].image
        let image = UIImage(data: data)
        cell.exerciseImageView.image = image
        cell.layer.shadowRadius = 9
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ExercisePageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.itemWidth, height: collectionView.frame.height * 0.8)
    }
}

//MARK: - ExercisePagePresenterDelegate
extension ExercisePageViewController: ExercisePagePresenterDelegate {
    
}
