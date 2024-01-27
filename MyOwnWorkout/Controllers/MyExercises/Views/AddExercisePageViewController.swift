//
//  ExercisePageViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 21.10.2023.
//

import UIKit

//MARK: - Протоколы класса
protocol AddExercisePageViewControllerDelegate: AnyObject {
    func addExerciseToTableView()
}

//MARK: -
class AddExercisePageViewController: GeneralViewController {
    
    var presenter: AddExercisePagePresenter!
    
    //MARK: - Переменные и константы класса
    private let exercise = ExerciseModel()
    weak var delegate: AddExercisePageViewControllerDelegate?
    
    private let exerciseTitleLabel = UILabel("Название", UIFont(name: Fonts.mainBold.rawValue, size: 14.0)!, .black)
    private let exerciseTitle = UITextView()
    
    private let galleryLabel = UILabel("Галерея", UIFont(name: Fonts.mainBold.rawValue, size: 14.0)!, .black)
    private let openGalleryButton = UIButton()
    
    var exerciseImagesDataArray = [ExerciseImageDataModel]()
    var exerciseImagesDataList = ExerciseModel().exerciseImagesDataList
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private let layout = UICollectionViewFlowLayout()
    
    private let exerciseAboutLabel = UILabel("Порядок выполнения", UIFont(name: Fonts.mainBold.rawValue, size: 14.0)!, .black)
    private let exerciseAbout = UITextView()
    
    private let saveExerciseButton = UIButton()
    
    //MARK: - Жизненный цикл класса
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSettings()
    }
}

//MARK: - Настройки экрана
private extension AddExercisePageViewController {
    
    func pageSettings() {
        setupNavigationBar()
        setupSubviews()
        setupMargins()
    }
    
    func setupNavigationBar() {
        title = "Новое упражнение"
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
        exerciseTitle.isSelectable = true
        exerciseTitle.isEditable = true
        exerciseTitle.font = UIFont(name: Fonts.main.rawValue, size: 16.0)!
        exerciseTitle.layer.borderWidth = 0.5
        exerciseTitle.layer.borderColor = UIColor.lightGray.cgColor
        exerciseTitle.layer.cornerRadius = 12
    }
    
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
    
    func saveExerciseImage(_ image: UIImage) {
        pageSettings()
        let imageData = image.pngData()!
        let imagesData = ExerciseImageDataModel(image: imageData)
        RealmDataBase.shared.set(imagesData)
        exerciseImagesDataList.append(imageData)
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
}

//MARK: - Селекторы
private extension AddExercisePageViewController {
    @objc func setupBackButton() {
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
            ExerciseModel().saveExercise(exerciseTitle.text!,
                                         exerciseAbout.text!,
                                         exerciseImagesDataList)
            delegate?.addExerciseToTableView()
            navigationController?.popViewController(animated: true)
        }
    }
}

extension AddExercisePageViewController: UICollectionViewDataSource {
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

extension AddExercisePageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.itemWidth / 5, height: collectionView.frame.height * 0.8)
    }
}

extension AddExercisePageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.saveExerciseImage(pickedImage)
            dismiss(animated: true)
        }
    }
}

//MARK: - ExerciseImagesTileVeiwControllerDelegate
extension AddExercisePageViewController: ExerciseImagesTileVeiwControllerDelegate {
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

extension AddExercisePageViewController: AddExercisePagePresenterDelegate {
    
}
