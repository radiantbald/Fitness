//
//  ExerciseImagesTileVeiwController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 30.12.2023.
//

import UIKit

protocol ExerciseImagesTileVeiwControllerDelegate: AnyObject {
    func updateExerciseImages(_ exerciseImagesArray: [ExerciseImagesCollectionModel])
}

class ExerciseImagesTileVeiwController: GeneralViewController {
    
    var presenter: ExerciseImagesTilePresenter!
    private var exerciseImagesDataArray: [ExerciseImageDataModel]
    private weak var delegate: ExerciseImagesTileVeiwControllerDelegate?
    
    init(parent: ExerciseImagesTileVeiwControllerDelegate? = nil, exerciseImagesDataArray:  [ExerciseImageDataModel]) {
        self.delegate = parent
        self.exerciseImagesDataArray = exerciseImagesDataArray
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var collectionView: UICollectionView?
    private let layout = UICollectionViewFlowLayout()
    
    var exerciseImagesArray: [ExerciseImagesCollectionModel] = []
    var exerciseImageData = ExerciseImageDataModel().image
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSettings()
        getExercisePhotosFromData()
    }
    
    override func viewDidLayoutSubviews() {
        collectionView?.frame = view.bounds
    }
    
    private func pageSettings() {
        setupNavigationBar()
        setupSubviews()
    }
    
    private func setupSubviews() {
        setupCollectionView()
    }
    
    private func setupNavigationBar() {
        title = "Галерея"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(setupBackButton))
    }
    
    @objc private func setupBackButton() {
        RealmDataBase.shared.deleteTable(ExerciseImageDataModel.self)
        
//        for image in exerciseImagesArray {
//            guard let imageData = image.image.pngData() else { return }
//            let imagesData = ExerciseImageDataModel(image: imageData)
//            RealmDataBase.shared.set(imagesData)
//        }
        delegate?.updateExerciseImages(exerciseImagesArray)
        navigationController?.popViewController(animated: true)
    }
    
    
    private func getExercisePhotosFromData() {
        exerciseImagesDataArray = RealmDataBase.shared.get()
        for exerciseImageData in exerciseImagesDataArray {
            let imageData = exerciseImageData.image
            guard let image = UIImage(data:imageData) else { continue }
            exerciseImagesArray.append(ExerciseImagesCollectionModel.init(image: image))
        }
        
    }
    
    private func setupCollectionView() {
        
        let imageSize = (UIScreen.main.bounds.width - 40) / 3
        collectionView = .init(frame: .zero, collectionViewLayout: layout)
        
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.register(ExerciseImagesCollectionsViewCell.self, forCellWithReuseIdentifier: ExerciseImagesCollectionsViewCell.cellID)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: imageSize, height: imageSize)
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        guard let collectionView = collectionView else { return }
        view.addSubviews(collectionView)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureAction))
        collectionView.addGestureRecognizer(longPressGesture)
    }
    
    @objc private func longPressGestureAction(_ gesture: UILongPressGestureRecognizer) {
        let gestureLocation = gesture.location(in: collectionView)
        switch gesture.state {
        case .began:
            guard let targetIndexPath = collectionView?.indexPathForItem(at: gestureLocation) else { return }
            collectionView?.beginInteractiveMovementForItem(at: targetIndexPath)
        case .changed:
            collectionView?.updateInteractiveMovementTargetPosition(gestureLocation)
        case .ended:
            collectionView?.endInteractiveMovement()
        default:
            collectionView?.cancelInteractiveMovement()
        }
    }
}

extension ExerciseImagesTileVeiwController: UICollectionViewDataSource {
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
extension ExerciseImagesTileVeiwController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let target = exerciseImagesArray.remove(at: sourceIndexPath.row)
        exerciseImagesArray.insert(target, at: destinationIndexPath.row)
    }
}
//extension ExerciseImagesTileVeiwController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: (UIScreen.main.bounds.width - (Constants.minimumLineSpacing * 4)) / 2, height: (UIScreen.main.bounds.width - (Constants.minimumLineSpacing * 4)) / 2)
//    }
//}

extension ExerciseImagesTileVeiwController: ExerciseImagesTilePresenterDelegate {
    
}