//
//  AddWorkoutPageViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 17.02.2024.
//

import UIKit

//MARK: - Протоколы класса
protocol AddWorkoutPageViewControllerDelegate: AnyObject {
    func addWorkoutToTableView()
}

//MARK: -
class AddWorkoutPageViewController: GeneralViewController {
    
    var presenter: AddWorkoutPagePresenter!
    
    //MARK: - Переменные и константы класса
    private let workout = WorkoutModel()
    weak var delegate: AddWorkoutPageViewControllerDelegate?
    
    private let workoutTitleLabel = UILabel("Название", UIFont(name: Fonts.mainBold.rawValue, size: 14.0)!, .black)
    private let workoutTitle = UITextView()
    
    private let exercisesListLabel = UILabel("Упражнения", UIFont(name: Fonts.mainBold.rawValue, size: 14.0)!, .black)
    private let openExerciseListButton = UIButton()
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private let layout = UICollectionViewFlowLayout()
    
    private let workoutAboutLabel = UILabel("Описание тренировки", UIFont(name: Fonts.mainBold.rawValue, size: 14.0)!, .black)
    private let workoutAbout = UITextView()
    
    var workoutExercisesDataArray = [ExerciseImageDataModel]()
    var workoutExercisesDataList = ExerciseModel().exerciseImagesDataList
    
    private let saveWorkoutButton = UIButton()
    
    //MARK: - Жизненный цикл класса
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSettings()
    }
}

//MARK: - Настройки экрана
private extension AddWorkoutPageViewController {
    
    func pageSettings() {
        setupNavigationBar()
        setupSubviews()
        setupMargins()
    }
    
    func setupNavigationBar() {
        title = "Новая тренировка"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(setupBackButton))
    }
    
    func setupSubviews() {
        setupExerciseTitleTextView()
        setupOpenGalleryButton()
        setupCollectionView()
        setupExerciseAboutTextView()
        setupSaveExerciseButton()
        
        view.addSubviews(workoutTitleLabel,
                         workoutTitle,
                         exercisesListLabel,
                         workoutAboutLabel,
                         workoutAbout,
                         saveWorkoutButton)
    }
    
    func setupMargins() {
        let margins = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            workoutTitleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
            workoutTitleLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20),
            workoutTitleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20),
            
            workoutTitle.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            workoutTitle.topAnchor.constraint(equalTo: workoutTitleLabel.bottomAnchor, constant: 5),
            workoutTitle.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            workoutTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 36),
            
            exercisesListLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
            exercisesListLabel.topAnchor.constraint(equalTo: workoutTitle.bottomAnchor, constant: 20),
            exercisesListLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20),
            
            workoutAbout.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            workoutAbout.topAnchor.constraint(equalTo: workoutAboutLabel.bottomAnchor, constant: 5),
            workoutAbout.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            workoutAbout.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            saveWorkoutButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            saveWorkoutButton.topAnchor.constraint(equalTo: workoutAbout.bottomAnchor, constant: 30),
            saveWorkoutButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            saveWorkoutButton.heightAnchor.constraint(equalToConstant: 50),
            ])
    
        if workoutExercisesDataList.isEmpty {
            print(workoutExercisesDataList.count)
            view.addSubviews(openExerciseListButton)
            
            NSLayoutConstraint.activate([
                openExerciseListButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
                openExerciseListButton.topAnchor.constraint(equalTo: exercisesListLabel.bottomAnchor, constant: 10),
                openExerciseListButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
                openExerciseListButton.heightAnchor.constraint(equalToConstant: 60),
                
                workoutAboutLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
                workoutAboutLabel.topAnchor.constraint(equalTo: openExerciseListButton.bottomAnchor, constant: 20),
                workoutAboutLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
                ])
        } else {
            view.addSubviews(collectionView)
            print(workoutExercisesDataList.count)
            NSLayoutConstraint.activate([
                collectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
                collectionView.topAnchor.constraint(equalTo: exercisesListLabel.bottomAnchor, constant: 10),
                collectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
                collectionView.heightAnchor.constraint(equalToConstant: 60),
                
                workoutAboutLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
                workoutAboutLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
                workoutAboutLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20),
                ])
        }
    }
    
    func setupExerciseTitleTextView() {
        workoutTitle.isSelectable = true
        workoutTitle.isEditable = true
        workoutTitle.font = UIFont(name: Fonts.main.rawValue, size: 16.0)!
        workoutTitle.layer.borderWidth = 0.5
        workoutTitle.layer.borderColor = UIColor.lightGray.cgColor
        workoutTitle.layer.cornerRadius = 12
    }
    
    func setupOpenGalleryButton() {
        openExerciseListButton.setTitle("Открыть список упражнений", for: .normal)
        openExerciseListButton.setTitleColor(.systemRed, for: .normal)
//        openExercisesListPage(openExerciseListButton)
    }
    
    func setupCollectionView() {
        collectionView = .init(frame: .zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
//        collectionView.dataSource = self
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: Constants.leftDistanceToView, bottom: 0, right: Constants.rightDistanceToView)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ExerciseImagesCollectionViewCell.self, forCellWithReuseIdentifier: ExerciseImagesCollectionViewCell.cellID)
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Constants.minimumLineSpacing
        
//        openExercisesListPage(collectionView)
    }
    
    func saveExerciseImage(_ image: UIImage) {
        pageSettings()
        let imageData = image.pngData()!
        let imagesData = ExerciseImageDataModel(image: imageData)
        RealmDataBase.shared.set(imagesData)
        workoutExercisesDataList.append(imageData)
    }
    
//    func openExercisesListPage(_ tapAreas: UIView...) {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openExercisesListAction))
//        tapGesture.delegate = self
//        tapAreas.forEach({ tapArea in
//            tapArea.isUserInteractionEnabled = true
//            tapArea.addGestureRecognizer(tapGesture)
//        })
//    }
    
    func setupExerciseAboutTextView() {
        workoutAbout.isSelectable = true
        workoutAbout.isEditable = true
        workoutAbout.font = UIFont(name: Fonts.main.rawValue, size: 16.0)!
        workoutAbout.layer.borderWidth = 0.5
        workoutAbout.layer.borderColor = UIColor.lightGray.cgColor
        workoutAbout.layer.cornerRadius = 12
    }
    
    func setupSaveExerciseButton() {
        saveWorkoutButton.setTitle("Сохранить", for: .normal)
        saveWorkoutButton.backgroundColor = .systemRed
        saveWorkoutButton.layer.cornerRadius = 12
        saveWorkoutButton.addTarget(self, action: #selector(setupSaveWorkoutButtonAction), for: .touchUpInside)
    }
}

//MARK: - Селекторы
private extension AddWorkoutPageViewController {
    @objc func setupBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
//    @objc func openExercisesListAction() {
//        let viewController = Assembler.controllers.exercisesListViewController(parent: self, workoutExercisesDataArray: workoutExercisesDataArray)
//        viewController.modalPresentationStyle = .overFullScreen
//        navigationController?.pushViewController(viewController, animated: true)
//    }
    
    @objc func setupSaveWorkoutButtonAction() {
        if workoutTitle.text?.count == 0 {
            showAlert(title: "Нет названия", message: "Назовите упражнение")
        } else {
            WorkoutModel().saveWorkout(workoutTitle.text!,
                                       workoutAbout.text!,
                                       workoutExercisesDataList)
            delegate?.addWorkoutToTableView()
            navigationController?.popViewController(animated: true)
        }
    }
}

//extension AddWorkoutPageViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return workoutExercisesDataArray.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExercisesListCollectionsViewCell.identifier, for: indexPath) as! ExercisesListCollectionsViewCell
//        let data = workoutExercisesDataArray[indexPath.row].image
//        let image = UIImage(data: data)
//        cell.exerciseImageView.image = image
//        cell.layer.shadowRadius = 3
//        cell.layer.shadowOffset = CGSize(width: 2, height: 2)
//        return cell
//    }
//}

extension AddWorkoutPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.itemWidth / 5, height: collectionView.frame.height * 0.8)
    }
}

extension AddWorkoutPageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.saveExerciseImage(pickedImage)
            dismiss(animated: true)
        }
    }
}

//MARK: - ExercisesListVeiwControllerDelegate
//extension AddWorkoutPageViewController: ExercisesListVeiwControllerDelegate {
//
//}

extension AddWorkoutPageViewController: AddWorkoutPagePresenterDelegate {
    
}

