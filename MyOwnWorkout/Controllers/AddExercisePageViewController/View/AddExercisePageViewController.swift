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
    
    //Заголовок страницы
    private let pageTitleLabel = UILabel("Создание", UIFont(name: Fonts.main.rawValue, size: 20.0)!, .black)
    
    //Название упражнения
    private let exerciseTitleLabel = UILabel("Название упражнения", UIFont(name: Fonts.mainBold.rawValue, size: 16.0)!, .black)
    private let exerciseTitle = UITextView()
    
    //Кнопка "Добавить фото"
    private lazy var imagePicker = UIImagePickerController()
    private let addExercisePhotoButton = UIButton()
    
    //Фотографии упражнения
    var exercisePhotos = [ExercisePhotosCollectionModel]()
    var exercisePhotosData = ExerciseModel().exercisePhotosData
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private let layout = UICollectionViewFlowLayout()
    
    //Об упражнении
    private let exerciseAboutLabel = UILabel("Порядок выполнения упражнения", UIFont(name: Fonts.mainBold.rawValue, size: 16.0)!, .black)
    private let exerciseAbout = UITextView()
    
    //Кнопка "Сохранить упражнение"
    private let saveExerciseButton = UIButton()
    
    //MARK: - Жизненный цикл контроллера
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSettings()
    }
}

extension AddExercisePageViewController {
    
    private func pageSettings() {
        title = "Новое упражнение"
        setupSubviews()
        setupMargins()
    }
    
    private func setupSubviews() {
        setupExerciseTitleTextView()
        setupAddExercisePhotoButton()
        setupCollectionView()
        setupExerciseAboutTextView()
        setupSaveExerciseButton()
        
        view.addSubviews(pageTitleLabel,
                         exerciseTitleLabel,
                         exerciseTitle,
                         addExercisePhotoButton,
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
            
            addExercisePhotoButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            addExercisePhotoButton.topAnchor.constraint(equalTo: exerciseTitle.bottomAnchor, constant: 20),
            addExercisePhotoButton.widthAnchor.constraint(equalToConstant: 40),
            addExercisePhotoButton.heightAnchor.constraint(equalToConstant: 60),
            
            collectionView.leadingAnchor.constraint(equalTo: addExercisePhotoButton.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: exerciseTitle.bottomAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            collectionView.heightAnchor.constraint(equalToConstant: 60),
            
            exerciseAboutLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
            exerciseAboutLabel.topAnchor.constraint(equalTo: addExercisePhotoButton.bottomAnchor, constant: 20),
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
        exerciseTitle.isSelectable = true
        exerciseTitle.isEditable = true
        exerciseTitle.font = UIFont(name: Fonts.main.rawValue, size: 16.0)!
        exerciseTitle.layer.borderWidth = 0.5
        exerciseTitle.layer.borderColor = UIColor.lightGray.cgColor
        exerciseTitle.layer.cornerRadius = 12
    }
    
    //MARK: - Кнопка добавления картинок упражнений
    private func setupAddExercisePhotoButton() {
        addExercisePhotoButton.setTitle("+", for: .normal)
        addExercisePhotoButton.backgroundColor = .systemRed
        addExercisePhotoButton.layer.cornerRadius = 12
        
        imagePicker.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(setupAddExercisePhotoButtonAction))
        tapGesture.delegate = self
        addExercisePhotoButton.isUserInteractionEnabled = true
        addExercisePhotoButton.addGestureRecognizer(tapGesture)
    }
    
    @objc private func setupAddExercisePhotoButtonAction() {
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
        collectionView.register(ExercisePhotosCollectionsViewCell.self, forCellWithReuseIdentifier: ExercisePhotosCollectionsViewCell.cellID)
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Constants.minimumLineSpacing
    }
    
    //MARK: - Сохранение картинок упражнения
    private func saveExercisePhoto(_ image: UIImage) {
        exercisePhotos.append(ExercisePhotosCollectionModel.init(photo: image))
        pageSettings()
        let photoData = image.pngData()!
        let photoDataModel = ExercisePhotoDataModel(photo: photoData)
        RealmDataBase.shared.set(photoDataModel)
        exercisePhotosData.append(photoData)
    }
    
    //MARK: - Поле ввода порядка выполнения упражнения
    private func setupExerciseAboutTextView() {
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
            ExerciseModel().saveExercise(exerciseTitle.text!,
                                         exerciseAbout.text!,
                                         exercisePhotosData)
            delegate?.addExerciseToTableView()
            navigationController?.popViewController(animated: true)
        }
    }
}

extension AddExercisePageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exercisePhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExercisePhotosCollectionsViewCell.cellID, for: indexPath) as! ExercisePhotosCollectionsViewCell
        cell.exercisePhotoImageView.image = exercisePhotos[indexPath.row].photo
        cell.layer.shadowRadius = 3
        cell.layer.shadowOffset = CGSize(width: 2, height: 2)
        return cell
    }
}

extension AddExercisePageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.itemWidth / 4, height: collectionView.frame.height * 0.8)
    }
}

extension AddExercisePageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.saveExercisePhoto(pickedImage)
            dismiss(animated: true)
        }
    }
}

extension AddExercisePageViewController: AddExercisePagePresenterDelegate {
    
}
