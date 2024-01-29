//
//  CalendarView.swift
//  MyOwnWorkout
//
//  Created by Алмаз Рахматуллин on 29.01.2024.
//

import UIKit

enum CalendarCase: Int {
    case month = 0
    case day = 1
}

final class CalendarView: UIView {
    
    private lazy var monthCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.tag = 0
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MonthCollectionViewCell.self, forCellWithReuseIdentifier: MonthCollectionViewCell.identifier)

        return collectionView
    }()
    
    private lazy var dayCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.tag = 1
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: DayCollectionViewCell.identifier)

        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setup() {
        backgroundColor = .white
        let stackView = UIStackView([monthCollectionView, dayCollectionView], .vertical, 0, .fill, .fill)
        self.addSubviews(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            monthCollectionView.heightAnchor.constraint(equalTo: dayCollectionView.heightAnchor, multiplier: 50 / 130)
        ])
    }
}

extension CalendarView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let model = CalendarCase(rawValue: section)
        switch collectionView {
        case monthCollectionView: return 3
        case dayCollectionView: return 21
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        let model = CalendarCase(rawValue: indexPath.section)
        switch collectionView {
        case monthCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthCollectionViewCell.identifier, for: indexPath) as? MonthCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = .orange
            
            return cell
        case dayCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCollectionViewCell.identifier, for: indexPath) as? DayCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.setup(number: String(indexPath.row), name: "ПН")
            return cell
        default:
            
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case monthCollectionView: return .init(width: collectionView.bounds.width, height: collectionView.bounds.height)
        case dayCollectionView:
            let countCell = 7.0
            let spacingCells = 5.0 * (countCell - 1)
            let widthCV = collectionView.bounds.width
            let widthCells = widthCV - spacingCells
            let width = widthCells / countCell
            return .init(width: width, height: collectionView.bounds.height)
        default: return .zero
        }
    }
}


final class MonthCollectionViewCell: UICollectionViewCell {
    private let label: UILabel = .init("", .systemFont(ofSize: 15, weight: .regular), .black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        label.textAlignment = .center
        
        contentView.addSubviews(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func setup(text: String) {
        label.text = text
    }
}


final class DayCollectionViewCell: UICollectionViewCell {
    private let numberLabel: UILabel = .init("", .systemFont(ofSize: 18, weight: .medium), .black)
    private let nameLabel: UILabel = .init("", .systemFont(ofSize: 18, weight: .medium), .systemGray4)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        let stackView = UIStackView([numberLabel, nameLabel], .vertical, 2, .fill, .fillEqually)
        numberLabel.textAlignment = .center
        nameLabel.textAlignment = .center
        
        contentView.addSubviews(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func setup(number: String, name: String) {
        numberLabel.text = number
        nameLabel.text = name
    }
}


class TestVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let formater = DateFormatter()
        formater.dateFormat = "EE -  MMM d, yyyy Z"
        formater.locale = Locale(identifier: "ru")
        formater.defaultDate = Date()
        let text = formater.string(from: Date())
        
        let label = UILabel(text, .systemFont(ofSize: 18), .blue)
        view.addSubview(label)
        label.frame = .init(x: 0, y: view.bounds.midY, width: view.bounds.width, height: 40)
        label.textAlignment = .center
        
        
        let content = CalendarView()
        view.addSubview(content)
        view.backgroundColor = .systemGray5
        content.frame = .init(x: 0, y: 100, width: view.bounds.width, height: 100)
    }
}

//MARK: - SwiftUI
import SwiftUI
struct ProviderTextVC : PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return TestVC()
        }
        
        typealias UIViewControllerType = UIViewController
        
        
        let viewController = TestVC()
        func makeUIViewController(context: UIViewControllerRepresentableContext<ProviderTextVC.ContainterView>) -> TestVC {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: ProviderTextVC.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProviderTextVC.ContainterView>) {
            
        }
    }
    
}
