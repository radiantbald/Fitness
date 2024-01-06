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
    
    private lazy var imagePicker = UIImagePickerController()
    
    lazy var deleteBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(cancelMultiselect))
        return barButtonItem
    }()
    
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
    
    
    
    enum Mode {
        case view
        case multiselect
    }
    
    var mMode: Mode = .view {
        didSet {
            switch mMode {
            case .view:
                title = "Галерея"
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(setupAddButton))
                collectionView?.allowsMultipleSelection = false
            case .multiselect:
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteImages))
                collectionView?.allowsMultipleSelection = true
            }
        }
    }
    
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(setupAddButton))
    }
    
    @objc private func setupBackButton() {
        RealmDataBase.shared.deleteTable(ExerciseImageDataModel.self)
        delegate?.updateExerciseImages(exerciseImagesArray)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func setupAddButton() {
        imagePicker.delegate = self
        
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
    
    private func saveExerciseImage(_ image: UIImage) {
        exerciseImagesArray.append(ExerciseImagesCollectionModel.init(image: image))
        pageSettings()
        let imageData = image.pngData()!
        let imagesData = ExerciseImageDataModel(image: imageData)
        RealmDataBase.shared.set(imagesData)
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
        
        guard let collectionView = collectionView else { return }
        let gestureLocation = gesture.location(in: collectionView)
        guard let targetIndexPath = collectionView.indexPathForItem(at: gestureLocation) else { return }
        
        
        switch mMode {
        case .view:
            mMode = .multiselect
            collectionView.selectItem(at: targetIndexPath, animated: false, scrollPosition: [])
            collectionView.delegate?.collectionView?(collectionView, didSelectItemAt: targetIndexPath)

        case .multiselect:
            break
        }
        
        switch gesture.state {
        case .began:
            title = "Выбрано элементов: \(collectionView.indexPathsForSelectedItems!.count)"
            
            collectionView.beginInteractiveMovementForItem(at: targetIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gestureLocation)
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }

    
    @objc private func cancelMultiselect() {
        mMode = .view
    }
    
    @objc private func deleteImages() {
        guard let selectedItems = collectionView?.indexPathsForSelectedItems else { return }
        let items = selectedItems.map { $0.item }.sorted().reversed()
        for item in items {
            exerciseImagesArray.remove(at: item)
        }
        pageSettings()
        mMode = .view
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch mMode {
        case .view:
            let item = self.exerciseImagesArray[indexPath.row]
            let viewController = Assembler.controllers.exerciseImageViewerViewController(parent: self, image: item)
            navigationController?.pushViewController(viewController, animated: true)
        case .multiselect:
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteImages))
            
            if let selectedItem = collectionView.cellForItem(at: indexPath) {
                selectedItem.layer.cornerRadius = 12
                selectedItem.layer.borderWidth = 2
                selectedItem.layer.borderColor = UIColor.systemRed.cgColor
                print("selected")
                title = "Выбрано элементов: \(collectionView.indexPathsForSelectedItems!.count)"
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch mMode {
        case .view:
            break
        case .multiselect:
            if let deselectedItem = collectionView.cellForItem(at: indexPath) {
                deselectedItem.layer.cornerRadius = 12
                deselectedItem.layer.borderWidth = 0
                deselectedItem.layer.borderColor = UIColor.systemRed.cgColor
                print("deselected")
                title = "Выбрано элементов: \(collectionView.indexPathsForSelectedItems!.count)"
            }
            if collectionView.indexPathsForSelectedItems?.count == 0 {
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(deleteImages))
            }
        }
        
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

extension ExerciseImagesTileVeiwController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.saveExerciseImage(pickedImage)
            dismiss(animated: true)
        }
    }
}

extension ExerciseImagesTileVeiwController: ExerciseImageViewerViewControllerDelegate {
    
}

extension ExerciseImagesTileVeiwController: ExerciseImagesTilePresenterDelegate {
    
}
