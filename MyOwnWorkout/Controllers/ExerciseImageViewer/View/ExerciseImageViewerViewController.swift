//
//  ExerciseImageViewerViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 04.01.2024.
//

import UIKit

protocol ExerciseImageViewerViewControllerDelegate: AnyObject {
}

final class ExerciseImageViewerViewController: GeneralViewController {
    
    var presenter: ExerciseImageViewerPresenter!
    var image: ExerciseImagesCollectionModel
    private weak var delegate: ExerciseImageViewerViewControllerDelegate?
    
    init(parent: ExerciseImageViewerViewControllerDelegate? = nil, image: ExerciseImagesCollectionModel) {
        self.image = image
        self.delegate = parent
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView = UIImageView()
    let shownImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(imageView)
        
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: margins.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
        imageView.image = image.image
        imageView.contentMode = .scaleAspectFit
    }
    
}

extension ExerciseImageViewerViewController: ExerciseImageViewerPresenterDelegate {
    
}
