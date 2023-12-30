//
//  ExerciseImagesTileVeiwController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 30.12.2023.
//

import UIKit

protocol ExerciseImagesTileVeiwControllerDelegate: AnyObject {
    func updateExerciseImages(_ exercise: ExerciseModel)
}

class ExerciseImagesTileVeiwController: GeneralViewController {
    
    var presenter: ExerciseImagesTilePresenter!
    private let exercise: ExerciseModel
    private weak var delegate: ExerciseImagesTileVeiwControllerDelegate?
    
    init(parent: ExerciseImagesTileVeiwControllerDelegate? = nil, exercise: ExerciseModel) {
        self.exercise = exercise
        self.delegate = parent
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var collectionView: UICollectionView?
    private let layout = UICollectionViewFlowLayout()
    
    var exercisePhotos: [ExercisePhotosCollectionModel] = []
    var exercisePhotosDataModel = ExercisePhotoDataModel().photo
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSettings()
        getExercisePhotosFromData()
    }
    
    override func viewDidLayoutSubviews() {
        collectionView?.frame = view.bounds
    }
    
    private func pageSettings() {
        setupSubviews()
        setupMargins()
    }
    
    private func setupSubviews() {
        setupCollectionView()
        
//        view.addSubviews(collectionView)
    }
    
    private func setupMargins() {
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
//            collectionView.leadingAnchor.constraint(equalTo: margins.trailingAnchor),
//            collectionView.topAnchor.constraint(equalTo: margins.topAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
    private func getExercisePhotosFromData() {
        let photosList = exercise.photosArray.compactMap{Data($0)}
        print(photosList)
        for photoData in photosList {
            let photoDataModel = ExercisePhotoDataModel(photo: photoData)
            RealmDataBase.shared.set(photoDataModel)
            exercisePhotosDataModel.append(photoData)
            guard let image = UIImage(data: photoData) else { continue }
            exercisePhotos.append(ExercisePhotosCollectionModel.init(photo: image))
        }
    }
    
    private func setupCollectionView() {
        
        let imageSize = (UIScreen.main.bounds.width - 40) / 3
        collectionView = .init(frame: .zero, collectionViewLayout: layout)
        
        
        
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.register(ExercisePhotosCollectionsViewCell.self, forCellWithReuseIdentifier: ExercisePhotosCollectionsViewCell.cellID)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: imageSize, height: imageSize)
        
//        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        guard let collectionView = collectionView else { return }
        view.addSubviews(collectionView)
    }
}

extension ExerciseImagesTileVeiwController: UICollectionViewDataSource {
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

//extension ExerciseImagesTileVeiwController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: (UIScreen.main.bounds.width - (Constants.minimumLineSpacing * 4)) / 2, height: (UIScreen.main.bounds.width - (Constants.minimumLineSpacing * 4)) / 2)
//    }
//}

extension ExerciseImagesTileVeiwController: ExerciseImagesTilePresenterDelegate {
    
}
