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
    private var exercisePhotoDataArray: [ExercisePhotoDataModel]
    private weak var delegate: ExerciseImagesTileVeiwControllerDelegate?
    
    init(parent: ExerciseImagesTileVeiwControllerDelegate? = nil, exercisePhotoDataArray: [ExercisePhotoDataModel]) {
        self.delegate = parent
        self.exercisePhotoDataArray = exercisePhotoDataArray
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
    }
    
    private func setupSubviews() {
        setupCollectionView()
    }
    
    
    private func getExercisePhotosFromData() {
        exercisePhotoDataArray = RealmDataBase.shared.get()
        for exercisePhotoData in exercisePhotoDataArray {
            let photoData = exercisePhotoData.photo
            guard let photo = UIImage(data:photoData) else { continue }
            exercisePhotos.append(ExercisePhotosCollectionModel.init(photo: photo))
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
