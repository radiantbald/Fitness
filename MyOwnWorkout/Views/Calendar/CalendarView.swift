//
//  CalendarView.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 07.02.2024.
//

import UIKit

//enum calenderCases: Int {
//    case month = 0
//    case day = 1
//}

final class CalendarView: UIView {
    
    private lazy var monthCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.tag = 0
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MonthCollectionViewCell.self, forCellWithReuseIdentifier: MonthCollectionViewCell.identifier)
        return collectionView
    }()
    
    private lazy var dayCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
//        let minimumLineSpacing = layout.minimumLineSpacing
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.tag = 1
        collectionView.backgroundColor = .clear
//        collectionView.isPagingEnabled = true
        collectionView.isPrefetchingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: DayCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupView() {
        backgroundColor = .white
        let stackView = UIStackView([monthCollectionView, dayCollectionView], .vertical, 0, .fill, .fill)
        self.addSubviews(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            monthCollectionView.heightAnchor.constraint(equalTo: dayCollectionView.heightAnchor, multiplier: 75 / 150)
        ])
    }
}

extension CalendarView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case monthCollectionView: return 3
        case dayCollectionView: return 42
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case monthCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthCollectionViewCell.identifier, for: indexPath) as? MonthCollectionViewCell else { return UICollectionViewCell() }
           
            cell.backgroundColor = .systemGray
            cell.setup(text: "Февраль 2024")
            return cell
            
        case dayCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCollectionViewCell.identifier, for: indexPath) as? DayCollectionViewCell else { return UICollectionViewCell() }
            
            cell.backgroundColor = .systemGray2
            cell.setup(number: String(indexPath.row), name: "ПН")
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewWidth = collectionView.bounds.width
        let collectionViewHeight = collectionView.bounds.height
        
        switch collectionView {
        case monthCollectionView: return .init(width: collectionViewWidth, height: collectionViewHeight)
            
        case dayCollectionView:
            let cellsQuantity = 7.0
            let spacingWidth = 5.0
            let spacingsWidth = (cellsQuantity - 1.0) * spacingWidth + 10
            let cellsWidth = collectionViewWidth - spacingsWidth
            let cellWidth = cellsWidth / cellsQuantity
            
            return .init(width: cellWidth, height: collectionView.bounds.height)
            
        default: return .zero
        }
    }
}

final class MonthCollectionViewCell: UICollectionViewCell {
    
    private let label: UILabel = .init("", .systemFont(ofSize: 15, weight: .medium), .black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setup() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubviews(label)
        label.textAlignment = .center
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    public func setup(text: String) {
        label.text = text
    }
}

final class DayCollectionViewCell: UICollectionViewCell {
    
    private let numberLabel: UILabel = .init("", .systemFont(ofSize: 15, weight: .medium), .black)
    private let nameLabel: UILabel = .init("", .systemFont(ofSize: 15, weight: .medium), .systemGray5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setup() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        let stackView = UIStackView([numberLabel, nameLabel], .vertical, 3, .fill, .fill)
        
        numberLabel.textAlignment = .center
        nameLabel.textAlignment = .center
        
        contentView.addSubviews(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    public func setup(number: String, name: String) {
        numberLabel.text = number
        nameLabel.text = name
    }
}

class CalendarViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let content = CalendarView()
        view.addSubview(content)
        view.backgroundColor = .systemGray5
        content.frame = .init(x: 0, y: 100, width: view.bounds.width, height: 100)
    }
}

//MARK: - SwiftUI
import SwiftUI
struct CalendarViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        func makeUIViewController(context: Context) -> UIViewController {
            return CalendarViewController()
        }
        
        typealias UIViewControllerType = UIViewController
        
        let viewController = CalendarViewController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<CalendarViewControllerProvider.ContainerView>) -> CalendarViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: CalendarViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<CalendarViewControllerProvider.ContainerView>) {
        }
    }
}

