//
//  ExerciseSetupPageViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 05.11.2023.
//

import UIKit

//MARK: - Протоколы класса
protocol SetupExercisePageViewControllerDelegate: AnyObject {
    func changeExerciseOnExercisePage(_ exercise: ExerciseModel)
}

//MARK: -
class SetupExercisePageViewController: GeneralViewController {
    
    //MARK: - Инициализация класса
    private let exercise: ExerciseModel
    private weak var delegate: SetupExercisePageViewControllerDelegate?
    var presenter: SetupExercisePagePresenter!
    
    init(parent: SetupExercisePageViewControllerDelegate? = nil, exercise: ExerciseModel) {
        self.exercise = exercise
        self.delegate = parent
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Переменные и константы класса
    private let exerciseTitleLabel = UILabel("Название", UIFont(name: Fonts.mainBold.rawValue, size: 14.0)!, .black)
    private let exerciseTitle = UITextView()
    
    private let galleryLabel = UILabel("Галерея", UIFont(name: Fonts.mainBold.rawValue, size: 14.0)!, .black)
    private let openGalleryButton = UIButton()
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private let layout = UICollectionViewFlowLayout()
    
    private var exerciseImagesDataArray = [ExerciseImageDataModel]()
    private var exerciseImagesDataList = ExerciseModel().exerciseImagesDataList

    private let exerciseAboutLabel = UILabel("Порядок выполнения", UIFont(name: Fonts.mainBold.rawValue, size: 14.0)!, .black)
    private let exerciseAbout = UITextView()
    
    private let saveExerciseButton = UIButton()
    
    //MARK: - Жизненный цикл класса
    override func viewDidLoad() {
        super.viewDidLoad()
        getExerciseImagesFromData()
        pageSettings()
    }
}

//MARK: - Настройки экрана
private extension SetupExercisePageViewController {
    
    func pageSettings() {
        setupNavigationBar()
        setupSubviews()
        setupMargins()
    }
    
    func setupNavigationBar() {
        title = "Редактировать"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(setupBackButton))
    }
    
    func setupSubviews() {
        setupExerciseTitleTextView()
        setupOpenGalleryButton()
        setupCollectionView()
        setupExerciseAboutTextView()
        setupSaveExerciseButton()
        
        view.addSubviews(exerciseTitleLabel,
                         exerciseTitle,
                         galleryLabel,
                         exerciseAboutLabel,
                         exerciseAbout,
                         saveExerciseButton)
    }
    
    func setupMargins() {
        let margins = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            exerciseTitleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
            exerciseTitleLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20),
            exerciseTitleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20),
            
            exerciseTitle.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            exerciseTitle.topAnchor.constraint(equalTo: exerciseTitleLabel.bottomAnchor, constant: 5),
            exerciseTitle.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            exerciseTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 36),
            
            galleryLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
            galleryLabel.topAnchor.constraint(equalTo: exerciseTitle.bottomAnchor, constant: 20),
            galleryLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20),
            
            exerciseAbout.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            exerciseAbout.topAnchor.constraint(equalTo: exerciseAboutLabel.bottomAnchor, constant: 5),
            exerciseAbout.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            exerciseAbout.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            saveExerciseButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            saveExerciseButton.topAnchor.constraint(equalTo: exerciseAbout.bottomAnchor, constant: 30),
            saveExerciseButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            saveExerciseButton.heightAnchor.constraint(equalToConstant: 50),
            ])
        
        if exerciseImagesDataList.isEmpty {
            print(exerciseImagesDataList.count)
            view.addSubviews(openGalleryButton)
            
            NSLayoutConstraint.activate([
                openGalleryButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
                openGalleryButton.topAnchor.constraint(equalTo: galleryLabel.bottomAnchor, constant: 10),
                openGalleryButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
                openGalleryButton.heightAnchor.constraint(equalToConstant: 60),
                
                exerciseAboutLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
                exerciseAboutLabel.topAnchor.constraint(equalTo: openGalleryButton.bottomAnchor, constant: 20),
                exerciseAboutLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
                ])
        } else {
            view.addSubviews(collectionView)
            print(exerciseImagesDataList.count)
            NSLayoutConstraint.activate([
                collectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
                collectionView.topAnchor.constraint(equalTo: galleryLabel.bottomAnchor, constant: 10),
                collectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
                collectionView.heightAnchor.constraint(equalToConstant: 60),
                
                exerciseAboutLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
                exerciseAboutLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
                exerciseAboutLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20),
                ])
        }
    }
    
    func setupExerciseTitleTextView() {
        exerciseTitle.text = exercise.title
        exerciseTitle.isSelectable = true
        exerciseTitle.isEditable = true
        exerciseTitle.font = UIFont(name: Fonts.main.rawValue, size: 16.0)!
        exerciseTitle.layer.borderWidth = 0.5
        exerciseTitle.layer.borderColor = UIColor.lightGray.cgColor
        exerciseTitle.layer.cornerRadius = 12
    }
    
    func getExerciseImagesFromData() {
        let imagesDataList = exercise.imagesDataList.compactMap{Data($0)}
        print(imagesDataList)
        for imageData in imagesDataList {
            exerciseImagesDataList.append(imageData)
        }
        exerciseImagesDataArray = RealmDataBase.shared.get()
    }
    
    //MARK: - Картинки упражнения
    func setupOpenGalleryButton() {
        openGalleryButton.setTitle("Открыть галерею", for: .normal)
        openGalleryButton.setTitleColor(.systemRed, for: .normal)
        openExerciseImagesTile(openGalleryButton)
    }
    
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
        
        openExerciseImagesTile(collectionView)
    }
    
    func openExerciseImagesTile(_ tapAreas: UIView...) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openExerciseImagesTileAction))
        tapGesture.delegate = self
        tapAreas.forEach({ tapArea in
            tapArea.isUserInteractionEnabled = true
            tapArea.addGestureRecognizer(tapGesture)
        })
    }
    
    func setupExerciseAboutTextView() {
        exerciseAbout.text = exercise.about
        exerciseAbout.isSelectable = true
        exerciseAbout.isEditable = true
        exerciseAbout.font = UIFont(name: Fonts.main.rawValue, size: 16.0)!
        exerciseAbout.layer.borderWidth = 0.5
        exerciseAbout.layer.borderColor = UIColor.lightGray.cgColor
        exerciseAbout.layer.cornerRadius = 12
    }
    
    func setupSaveExerciseButton() {
        saveExerciseButton.setTitle("Сохранить", for: .normal)
        saveExerciseButton.backgroundColor = .systemRed
        saveExerciseButton.layer.cornerRadius = 12
        saveExerciseButton.addTarget(self, action: #selector(setupSaveExerciseButtonAction), for: .touchUpInside)
    }
    
    func saveExercise(_ title: String, _ about: String) {
        
        let model = ExerciseModel()
        model.id = exercise.id
        model.title = title
        model.about = about
        model.imagesDataList = exerciseImagesDataList
        
        delegate?.changeExerciseOnExercisePage(model)
    }
    
}

//MARK: - Селекторы
private extension SetupExercisePageViewController {
    
    @objc func setupBackButton() {
//        RealmDataBase.shared.deleteTable(ExerciseImageDataModel.self)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func openExerciseImagesTileAction() {
        let viewController = Assembler.controllers.exerciseImagesTileViewController(parent: self, exerciseImagesDataArray: exerciseImagesDataArray)
        viewController.modalPresentationStyle = .overFullScreen
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func setupSaveExerciseButtonAction() {
        if exerciseTitle.text?.count == 0 {
            showAlert(title: "Нет названия", message: "Назовите упражнение")
        } else {
            saveExercise(exerciseTitle.text, exerciseAbout.text)
//            let imageData = ExerciseImageDataModel.self
//            RealmDataBase.shared.deleteTable(imageData)
            self.navigationController?.popViewController(animated: true)
        }
    }
}

//MARK: - ExerciseImagesTileVeiwControllerDelegate
extension SetupExercisePageViewController: ExerciseImagesTileVeiwControllerDelegate {
    func updateExerciseImages(_ exerciseImagesArray: [UIImage]) {
        self.exerciseImagesDataList.removeAll()
        for image in exerciseImagesArray {
            let imageData = image.pngData()!
            exerciseImagesDataList.append(imageData)
        }
        
        exerciseImagesDataArray = RealmDataBase.shared.get()
        
        if exerciseImagesDataList.isEmpty {
            collectionView.removeFromSuperview()
        } else {
            openGalleryButton.removeFromSuperview()
        }
        
        pageSettings()
    }
}

//MARK: - UICollectionViewDataSource
extension SetupExercisePageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exerciseImagesDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseImagesCollectionsViewCell.cellID, for: indexPath) as! ExerciseImagesCollectionsViewCell
        let data = exerciseImagesDataArray[indexPath.row].image
        let image = UIImage(data: data)
        cell.exerciseImageView.image = image
        cell.layer.shadowRadius = 3
        cell.layer.shadowOffset = CGSize(width: 2, height: 2)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SetupExercisePageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.itemWidth / 5, height: collectionView.frame.height * 0.8)
    }
}

//MARK: - SetupExercisePagePresenterDelegate
extension SetupExercisePageViewController: SetupExercisePagePresenterDelegate {
    
}

