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
    
    var presenter: SetupExercisePagePresenter!
    private let exercise: ExerciseModel
    private weak var delegate: SetupExercisePageViewControllerDelegate?
    
    init(parent: SetupExercisePageViewControllerDelegate? = nil, exercise: ExerciseModel) {
        self.exercise = exercise
        self.delegate = parent
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private let exerciseTitleLabel = UILabel("Название упражнения", UIFont(name: Fonts.mainBold.rawValue, size: 14.0)!, .black)
    private let exerciseTitle = UITextView()
    
    private lazy var imagePicker = UIImagePickerController()
    private let addExerciseImageButton = UIButton()
    
    private let exerciseAboutLabel = UILabel("Порядок выполнения упражнения", UIFont(name: Fonts.mainBold.rawValue, size: 14.0)!, .black)
    
    var exerciseImagesArray = [ExerciseImagesCollectionModel]()
    var exerciseImagesDataArray = [ExerciseImageDataModel]()
    var exerciseImagesDataList = ExerciseModel().exerciseImagesData // List<Data>
    var exerciseImageData = ExerciseImageDataModel().image //Data
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private let layout = UICollectionViewFlowLayout()
    
    private let exerciseAbout = UITextView()
    private let saveExerciseButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSettings()
        getExerciseImagesFromData()
    }
}

extension SetupExercisePageViewController {
    
    private func pageSettings() {
        setupNavigationBar()
        setupSubviews()
        setupMargins()
    }
    
    private func setupNavigationBar() {
        title = "Новое упражнение"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(setupBackButton))
    }
    
    @objc private func setupBackButton() {
        RealmDataBase.shared.deleteTable(ExerciseImageDataModel.self)
        navigationController?.popViewController(animated: true)
    }
    
    private func setupSubviews() {
        setupExerciseTitleTextView()
//        setupAddExerciseImageButton()
        setupCollectionView()
        setupExerciseAboutTextView()
        setupSaveExerciseButton()
        
        view.addSubviews(exerciseTitleLabel,
                         exerciseTitle,
                         collectionView,
                         exerciseAboutLabel,
                         exerciseAbout,
                         saveExerciseButton)
    }
    
    private func setupMargins() {
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            exerciseTitleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
            exerciseTitleLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20),
            exerciseTitleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            
            exerciseTitle.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            exerciseTitle.topAnchor.constraint(equalTo: exerciseTitleLabel.bottomAnchor, constant: 5),
            exerciseTitle.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            exerciseTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 36),
            
            collectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: exerciseTitle.bottomAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 60),
            
            exerciseAboutLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
            exerciseAboutLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
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
    }
    
    //MARK: - Поле ввода для названия упражнения
    private func setupExerciseTitleTextView() {
        exerciseTitle.text = exercise.title
        exerciseTitle.isSelectable = true
        exerciseTitle.isEditable = true
        exerciseTitle.font = UIFont(name: Fonts.main.rawValue, size: 16.0)!
        exerciseTitle.layer.borderWidth = 0.5
        exerciseTitle.layer.borderColor = UIColor.lightGray.cgColor
        exerciseTitle.layer.cornerRadius = 12
    }
    
    private func getExerciseImagesFromData() {
        let imagesList = exercise.imagesDataList.compactMap{Data($0)}
        print(imagesList)
        for imageData in imagesList {
            let imagesData = ExerciseImageDataModel(image: imageData)
            exerciseImagesDataList.append(imageData)
            RealmDataBase.shared.set(imagesData)
            exerciseImageData.append(imageData)
            guard let image = UIImage(data: imageData) else { continue }
            exerciseImagesArray.append(ExerciseImagesCollectionModel.init(image: image))
        }
    }
    //MARK: - Кнопка добавления картинок упражнений
    private func setupAddExerciseImageButton() {
        addExerciseImageButton.setTitle("+", for: .normal)
        addExerciseImageButton.backgroundColor = .systemRed
        addExerciseImageButton.layer.cornerRadius = 12
        
        imagePicker.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(setupAddExerciseImageButtonAction))
        tapGesture.delegate = self
        addExerciseImageButton.isUserInteractionEnabled = true
        addExerciseImageButton.addGestureRecognizer(tapGesture)
    }
    
    @objc private func setupAddExerciseImageButtonAction() {
        let actionImage = UIAlertController(title: "Добавить фото", message: nil, preferredStyle: .actionSheet)
        
        let photoLibrary = UIAlertAction(title: "Фотоальбом", style: .default) { _ in
            self.imagePicker.sourceType = .savedPhotosAlbum
            self.imagePicker.allowsEditing = true
            self.navigationController?.present(self.imagePicker, animated:true)
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        actionImage.addAction(photoLibrary)
        actionImage.addAction(cancel)
        
        if let popover = actionImage.popoverPresentationController {
            popover.sourceView = self.view
            let frame = view.frame
            popover.sourceRect = CGRect(x: frame.midX, y: frame.maxY, width: 1.0, height: 1.0)
        }
        self.present(actionImage, animated: true)
    }
    
    //MARK: - Картинки упражнения
    private func setupCollectionView() {
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
    
    //MARK: - Сохранение картинок упражнения
    private func saveExerciseImage(_ image: UIImage) {
//        exerciseImagesArray.append(ExerciseImagesCollectionModel.init(image: image))
//        pageSettings()
//        let imageData = image.pngData()!
//        let imagesData = ExerciseImageDataModel(image: imageData)
//        RealmDataBase.shared.set(imagesData)
//        exerciseImagesDataList.append(imageData)
    }
    
    func openExerciseImagesTile(_ tapAreas: UIView...) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openExerciseImagesTileAction))
        tapGesture.delegate = self
        tapAreas.forEach({ tapArea in
            tapArea.isUserInteractionEnabled = true
            tapArea.addGestureRecognizer(tapGesture)
        })
    }
    
    @objc func openExerciseImagesTileAction() {
        let viewController = Assembler.controllers.exerciseImagesTileViewController(parent: self, exerciseImagesDataArray: exerciseImagesDataArray)
        viewController.modalPresentationStyle = .overFullScreen
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    //MARK: - Поле ввода порядка выполнения упражнения
    private func setupExerciseAboutTextView() {
        exerciseAbout.text = exercise.about
        exerciseAbout.isSelectable = true
        exerciseAbout.isEditable = true
        exerciseAbout.font = UIFont(name: Fonts.main.rawValue, size: 16.0)!
        exerciseAbout.layer.borderWidth = 0.5
        exerciseAbout.layer.borderColor = UIColor.lightGray.cgColor
        exerciseAbout.layer.cornerRadius = 12
    }
    
    //MARK: - Кнопка сохранения упражнения
    func setupSaveExerciseButton() {
        saveExerciseButton.setTitle("Сохранить", for: .normal)
        saveExerciseButton.backgroundColor = .systemRed
        saveExerciseButton.layer.cornerRadius = 12
        saveExerciseButton.addTarget(self, action: #selector(setupSaveExerciseButtonAction), for: .touchUpInside)
    }
    
    @objc func setupSaveExerciseButtonAction() {
        if exerciseTitle.text?.count == 0 {
            showAlert(title: "Нет названия", message: "Назовите упражнение")
        } else {
            saveExercise(exerciseTitle.text, exerciseAbout.text)
            let imageData = ExerciseImageDataModel.self
            RealmDataBase.shared.deleteTable(imageData)
            self.navigationController?.popViewController(animated: true)
        }
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

extension SetupExercisePageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exerciseImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseImagesCollectionsViewCell.cellID, for: indexPath) as! ExerciseImagesCollectionsViewCell
        cell.exerciseImageView.image = exerciseImagesArray[indexPath.row].image
        cell.layer.shadowRadius = 3
        cell.layer.shadowOffset = CGSize(width: 2, height: 2)
        return cell
    }
}

extension SetupExercisePageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.itemWidth / 4, height: collectionView.frame.height * 0.8)
    }
}

extension SetupExercisePageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.saveExerciseImage(pickedImage)
            dismiss(animated: true)
        }
    }
}

extension SetupExercisePageViewController: ExerciseImagesTileVeiwControllerDelegate {
    func updateExerciseImages(_ exerciseImagesArray: [ExerciseImagesCollectionModel]) {
        self.exerciseImagesArray.removeAll()
        self.exerciseImagesDataList.removeAll()
        for imageDataModel in exerciseImagesArray {
            guard let imageData = imageDataModel.image.pngData() else { continue }
            guard let image = UIImage(data: imageData) else { continue }
            self.exerciseImagesArray.append(ExerciseImagesCollectionModel.init(image: image))
            exerciseImagesDataList.append(imageData)
            
            let imagesData = ExerciseImageDataModel(image: imageData)
            RealmDataBase.shared.set(imagesData)
        }
        pageSettings()
    }
}

extension SetupExercisePageViewController: SetupExercisePagePresenterDelegate {
    
}

