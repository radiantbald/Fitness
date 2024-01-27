//
//  ExerciseImageViewerViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 04.01.2024.
//

import UIKit

//MARK: - Протоколы класса
protocol ExerciseImageViewerViewControllerDelegate: AnyObject {
    
}

//MARK: -
final class ExerciseImageViewerViewController: GeneralViewController {
    
    //MARK: - Инициализация класса
    private var image: UIImage?
    private weak var delegate: ExerciseImageViewerViewControllerDelegate?
    var presenter: ExerciseImageViewerPresenter!
    
    init(parent: ExerciseImageViewerViewControllerDelegate? = nil, image: Data) {
        self.image = UIImage(data: image)
        self.delegate = parent
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Переменные и константы класса
    private let imageView = UIImageView()
    private let shownImage = UIImage()
    
    //MARK: - Жизненный цикл класса
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSettings()
    }
    
}

//MARK: - Настройки экрана
private extension ExerciseImageViewerViewController {
    
    func pageSettings() {
        setupSubviews()
        setupMargins()
    }
    
    func setupSubviews() {
        setupImageView()
        view.addSubviews(imageView)
    }
    
    func setupMargins() {
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: margins.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
    
    func setupImageView() {
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
    }
}

//MARK: - ExerciseImageViewerPresenterDelegate
extension ExerciseImageViewerViewController: ExerciseImageViewerPresenterDelegate {
    
}
