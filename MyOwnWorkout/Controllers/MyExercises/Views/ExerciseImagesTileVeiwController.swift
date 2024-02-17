//
//  ExerciseImagesTileVeiwController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 30.12.2023.
//

import UIKit

//MARK: - Протоколы класса
protocol ExerciseImagesTileVeiwControllerDelegate: AnyObject {
    func updateExerciseImages(_ exerciseImagesArray: [UIImage])
}

//MARK: -
final class ExerciseImagesTileVeiwController: GeneralViewController {
    
    //MARK: - Инициализация класса
    private var exerciseImagesDataArray: [ExerciseImageDataModel]
    private weak var delegate: ExerciseImagesTileVeiwControllerDelegate?
    var presenter: ExerciseImagesTilePresenter!
    
    init(parent: ExerciseImagesTileVeiwControllerDelegate? = nil, exerciseImagesDataArray:  [ExerciseImageDataModel]) {
        self.delegate = parent
        self.exerciseImagesDataArray = exerciseImagesDataArray
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Переменные и константы класса
    private var collectionView: UICollectionView?
    private let layout = UICollectionViewFlowLayout()
    
    private lazy var imagePicker = UIImagePickerController()
    
    private enum Mode {
        case initial
        case multiselect
    }
    
    private var mode: Mode = .initial {
        didSet {
            switch mode {
            case .initial:
                setupInitialNavigationBar()
                collectionView?.allowsMultipleSelection = false
            case .multiselect:
                setupMultiselectNavigationBar()
                collectionView?.allowsMultipleSelection = true
            }
        }
    }
    
    //MARK: - Жизненный цикл класса
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSettings()
        getExercisePhotosFromData()
    }
    
    override func viewDidLayoutSubviews() {
        collectionView?.frame = view.bounds
    }
}

//MARK: - Настройки экрана
private extension ExerciseImagesTileVeiwController {
    
    func pageSettings() {
        setupInitialNavigationBar()
        setupSubviews()
    }
    
    func setupSubviews() {
        setupCollectionView()
    }
    
    func setupInitialNavigationBar() {
        title = "Галерея"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(setupBackButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(setupAddButton))
    }
    
    func setupMultiselectNavigationBar() {
        guard let selectedItemsCount = collectionView?.indexPathsForSelectedItems?.count else { return }
        title = "Выбрано элементов: \(selectedItemsCount)"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(setupBackButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteImages))
    }
    
    func getExercisePhotosFromData() {
        exerciseImagesDataArray = RealmDataBase.shared.get()
    }
    
    func setupCollectionView() {
        
        let imageSize = (UIScreen.main.bounds.width - 40) / 3
        collectionView = .init(frame: .zero, collectionViewLayout: layout)
        
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.register(ExerciseImagesCollectionViewCell.self, forCellWithReuseIdentifier: ExerciseImagesCollectionViewCell.cellID)
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
}

//MARK: - Селекторы
private extension ExerciseImagesTileVeiwController {
    
    @objc func setupBackButton() {
        let array = RealmDataBase.shared.set(exerciseImagesDataArray)
        let exerciseImagesArray = array.compactMap({UIImage(data: $0.image)})
        delegate?.updateExerciseImages(exerciseImagesArray)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func setupAddButton() {
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
    
    @objc func deleteImages() {
        guard let selectedItems = collectionView?.indexPathsForSelectedItems else { return }
        let items = selectedItems.map { $0.item }.sorted().reversed()
        let deleteArray = items.compactMap({exerciseImagesDataArray[$0]})
        for item in items {
            exerciseImagesDataArray.remove(at: item)
        }
        RealmDataBase.shared.delete(deleteArray)
        pageSettings()
        mode = .initial
    }
    
    @objc func cancelMultiselect() {
        mode = .initial
    }
    
    @objc func longPressGestureAction(_ gesture: UILongPressGestureRecognizer) {
        
        guard let collectionView = collectionView else { return }
        let gestureLocation = gesture.location(in: collectionView)
        guard let targetIndexPath = collectionView.indexPathForItem(at: gestureLocation) else { return }
        guard let selectedItems = collectionView.indexPathsForSelectedItems else { return }
        
        switch mode {
        case .initial:
            mode = .multiselect
        case .multiselect:
            break
        }
        
        switch gesture.state {
        case .began:
            collectionView.selectItem(at: targetIndexPath, animated: false, scrollPosition: [])
            collectionView.delegate?.collectionView?(collectionView, didSelectItemAt: targetIndexPath)
        
            collectionView.beginInteractiveMovementForItem(at: targetIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gestureLocation)
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
}

//MARK: - UICollectionViewDataSource
extension ExerciseImagesTileVeiwController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exerciseImagesDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseImagesCollectionViewCell.cellID, for: indexPath) as! ExerciseImagesCollectionViewCell
        let data = exerciseImagesDataArray[indexPath.row].image
        let image = UIImage(data: data)
        cell.exerciseImageView.image = image
        cell.layer.shadowRadius = 3
        cell.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch mode {
        case .initial:
            let data = self.exerciseImagesDataArray[indexPath.row].image
            let viewController = Assembler.controllers.exerciseImageViewerViewController(parent: self, image: data)
            navigationController?.pushViewController(viewController, animated: true)
        case .multiselect:
            guard let selectedItemsCount = collectionView.indexPathsForSelectedItems?.count else { return }
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteImages))
            
            if let selectedItem = collectionView.cellForItem(at: indexPath) {
                selectedItem.layer.cornerRadius = 12
                selectedItem.layer.borderWidth = 2
                selectedItem.layer.borderColor = UIColor.systemRed.cgColor
                title = "Выбрано элементов: \(selectedItemsCount)"
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch mode {
        case .initial:
            break
        case .multiselect:
            guard let selectedItemsCount = collectionView.indexPathsForSelectedItems?.count else { return }
            
            if let deselectedItem = collectionView.cellForItem(at: indexPath) {
                deselectedItem.layer.borderWidth = 0
                title = "Выбрано элементов: \(selectedItemsCount)"
            }
            if collectionView.indexPathsForSelectedItems?.count == 0 {
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(cancelMultiselect))
            }
        }
    }
}

//MARK: - UICollectionViewDelegate
extension ExerciseImagesTileVeiwController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print(exerciseImagesDataArray)
        
        let one = exerciseImagesDataArray[sourceIndexPath.row]
        let two = exerciseImagesDataArray[destinationIndexPath.row]
        
        let array = RealmDataBase.shared.replace(one, two)
        print(array)
        exerciseImagesDataArray = array
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ExerciseImagesTileVeiwController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.saveExerciseImage(pickedImage)
            dismiss(animated: true)
        }
    }
    
    func saveExerciseImage(_ image: UIImage) {
        pageSettings()
        let imageData = image.pngData()!
        let imagesData = ExerciseImageDataModel(image: imageData)
        RealmDataBase.shared.set(imagesData)
        exerciseImagesDataArray = RealmDataBase.shared.get()
        collectionView?.reloadData()
    }
}

//MARK: - ExerciseImageViewerViewControllerDelegate
extension ExerciseImagesTileVeiwController: ExerciseImageViewerViewControllerDelegate {
    
}

//MARK: - ExerciseImagesTilePresenterDelegate
extension ExerciseImagesTileVeiwController: ExerciseImagesTilePresenterDelegate {
    
}
