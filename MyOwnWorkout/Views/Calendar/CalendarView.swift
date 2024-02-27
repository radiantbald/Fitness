//
//  CalendarView.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 07.02.2024.
//

import UIKit

final class CalendarView: UIView {
    
    private lazy var monthCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.tag = 0
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MonthCollectionViewCell.self, forCellWithReuseIdentifier: MonthCollectionViewCell.identifier)
        return collectionView
    }()
    
    private var monthsArray: [String] = [Date().toString("LLLL yyyy"),
                                         Date().toString("LLLL yyyy"),
                                         Date().toString("LLLL yyyy")]
    
    private lazy var dayCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //        let minimumLineSpacing = layout.minimumLineSpacing
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.tag = 1
        collectionView.backgroundColor = .clear
        //        collectionView.contentInset.left = 5
        //        collectionView.isPagingEnabled = true
        collectionView.isPrefetchingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: DayCollectionViewCell.identifier)
        return collectionView
    }()
    
    private var month: String?
    private var monthFrame: CGFloat = .zero
    private var dayFrame: CGFloat = .zero
    private var daysArray: [Date] = CalendarManager.shared.createDaysArray(quantity: 14)
    
    
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
        print(daysArray.count)
    }
    
    func scrollToToday() {
        let format = "yyyyMMdd"
        let today = Date().toString(format)
        if let item = daysArray.firstIndex(where: { $0.toString(format) == today }) {
            dayCollectionView.scrollToItem(at: .init(item: item, section: 0), at: .centeredHorizontally, animated: false)
        }
        
        monthCollectionView.scrollToItem(at: .init(item: 1, section: 0), at: .centeredHorizontally, animated: false)
    }
}

extension CalendarView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case monthCollectionView: return monthsArray.count
        case dayCollectionView: return daysArray.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case monthCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthCollectionViewCell.identifier, for: indexPath) as? MonthCollectionViewCell else { return UICollectionViewCell() }
            
            cell.setup(text: monthsArray[indexPath.item])
            if indexPath.item == 1 {
                monthFrame = cell.frame.minX
            }
            
            return cell
            
        case dayCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCollectionViewCell.identifier, for: indexPath) as? DayCollectionViewCell else { return UICollectionViewCell() }
            
            let item = indexPath.item
            
            //создание
            let array = daysArray[item].toString("d-E").components(separatedBy: "-")
            let number = array.first ?? "--"
            let name = array.last ?? "--"
            cell.setup(number: number, name: name)
            
            if number == "1" {
                let visibleIndexPaths = collectionView.indexPathsForVisibleItems.sorted().map({ $0.item })
                print(visibleIndexPaths)
                let path = (visibleIndexPaths.count - 1) / 2
                print(path)
                let row = visibleIndexPaths[path]
                print(row)
                
                monthsArray[0] = daysArray[item].toString("LLLL yyyy")
                monthsArray[1] = daysArray[row].toString("LLLL yyyy")
                monthsArray[2] = daysArray[item].toString("LLLL yyyy")
                
                monthCollectionView.reloadData()
                monthCollectionView.scrollToItem(at: .init(item: 1, section: 0), at: .centeredHorizontally, animated: false)
                dayFrame = cell.frame.minX
            }
            
            //добавление ячеек
            let rightBorder = daysArray.count - 3
            if item == rightBorder, let last = daysArray.last {
                
                let newArray = CalendarManager.shared.addDays(quantity: 14, initialDate: last, to: .forward)
                daysArray.append(contentsOf: newArray)
                collectionView.reloadData()
                print(daysArray.count)
            }
            
//            let leftBorder = 3
//            if item == leftBorder, let first = daysArray.first {
//                print(daysArray)
//                let newArray = CalendarManager.shared.addDays(quantity: 14, initialDate: first, to: .back)
//                daysArray.insert(contentsOf: newArray, at: 0)
//                collectionView.reloadData()
//                
//            }
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == dayCollectionView {
            let width = scrollView.bounds.width
            let scrollViewX = scrollView.contentOffset.x
            if ((dayFrame - width)...dayFrame).contains(scrollViewX) {
                let x = dayFrame - scrollViewX
                monthCollectionView.contentOffset.x = monthFrame + width - x
            }
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
        label.backgroundColor = .systemGray
        label.textAlignment = .center
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
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
        stackView.backgroundColor = .systemGray2
        
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
    
    let content = CalendarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(content)
        view.backgroundColor = .systemGray5
        content.frame = .init(x: 0, y: 100, width: view.bounds.width, height: 100)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        content.scrollToToday()
    }
}

enum ToDate {
    case forward
    case back
}
class CalendarManager {
    private init() {}
    static let shared: CalendarManager = .init()
    
    func createDaysArray(quantity: Int) -> [Date] {
        //создание календаря
        let calendar = Calendar.current
        
        //получение текущей даты
        let currentDate = Date()
        
        //создание диапазона дат
        let half = quantity / 2
        if let start = calendar.date(byAdding: .day, value: -half, to: currentDate),
           let end = calendar.date(byAdding: .day, value: half, to: currentDate) {
            
            //создание массива для диапазона дат
            var daysArray: [Date] = []
            var date = start
            
            while date < end {
                date = calendar.date(byAdding: .day, value: 1, to: date)!
                daysArray.append(date)
            }
            return daysArray
        } else {
            return []
        }
    }
    
    func addDays(quantity: Int, initialDate: Date, to: ToDate) -> [Date] {
        //создание календаря
        let calendar = Calendar.current
        
        func addAction(start: Date, end: Date) -> [Date] {
            //создание массива для диапазона дат
            var daysArray: [Date] = []
            var date = start
            
            while date < end {
                date = calendar.date(byAdding: .day, value: 1, to: date)!
                daysArray.append(date)
            }
            
            return daysArray
        }
        
        switch to {
        case .forward:
            //создание диапазона дат
            if let start = calendar.date(byAdding: .day, value: 1, to: initialDate),
               let end = calendar.date(byAdding: .day, value: quantity, to: start) {
                return addAction(start: start, end: end)
            } else {
                return []
            }
        case .back:
            //создание диапазона дат
            if let end = calendar.date(byAdding: .day, value: -1, to: initialDate),
               let start = calendar.date(byAdding: .day, value: -quantity, to: end) {
                return addAction(start: start, end: end)
               } else {
                   return []
               }
            }
            
            
        }
    }
    
    //MARK: - SwiftUI
    //import SwiftUI
    //struct CalendarViewControllerProvider: PreviewProvider {
    //    static var previews: some View {
    //        ContainerView().edgesIgnoringSafeArea(.all)
    //    }
    //
    //    struct ContainerView: UIViewControllerRepresentable {
    //
    //        func makeUIViewController(context: Context) -> UIViewController {
    //            return CalendarViewController()
    //        }
    //
    //        typealias UIViewControllerType = UIViewController
    //
    //        let viewController = CalendarViewController()
    //        func makeUIViewController(context: UIViewControllerRepresentableContext<CalendarViewControllerProvider.ContainerView>) -> CalendarViewController {
    //            return viewController
    //        }
    //
    //        func updateUIViewController(_ uiViewController: CalendarViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<CalendarViewControllerProvider.ContainerView>) {
    //        }
    //    }
    //}
    //
