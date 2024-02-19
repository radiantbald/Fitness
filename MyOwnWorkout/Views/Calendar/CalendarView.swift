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
        layout.minimumLineSpacing = 0
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
    private var arrayMonth: [String] = [Date().toString("MMMM yyyy"), Date().toString("MMMM yyyy"), Date().toString("MMMM yyyy")]
    ///1 - создать ячейки по дням 21
    ///date now
    //2 - последний день
    //21 ячейку 15 января
    //метод проверки и создания нов ячеек
    //обратиться в массив и узнать какая дата последняя и добавить от этой даты
    
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
    private var mounth: String?
    private var monthFrame: CGFloat = .zero
    private var dayFrame: CGFloat = .zero
    private var arrayDays: [Date] = CalendarManager.shared.createArrayDays(countOfDays: 30)
    
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
    
    func scrollToNowDate() {
        let format = "yyyyMMdd"
        let now = Date().toString(format)
        if let item = arrayDays.firstIndex(where: {$0.toString(format) == now }) {
            dayCollectionView.scrollToItem(at: .init(item: item, section: 0), at: .centeredHorizontally, animated: false)
        }
        
        monthCollectionView.scrollToItem(at: .init(item: 1, section: 0), at: .centeredHorizontally, animated: false)
    }
}


extension CalendarView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case monthCollectionView: return arrayMonth.count
        case dayCollectionView: return arrayDays.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case monthCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthCollectionViewCell.identifier, for: indexPath) as? MonthCollectionViewCell else { return UICollectionViewCell() }
           
            cell.setup(text: arrayMonth[indexPath.item])
            if indexPath.item == 1 {
                monthFrame = cell.frame.minX
            }
            return cell
            
        case dayCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCollectionViewCell.identifier, for: indexPath) as? DayCollectionViewCell else { return UICollectionViewCell() }
            
            cell.backgroundColor = .systemGray2
            let item = indexPath.item
            let array = arrayDays[item].toString("d-E").components(separatedBy: "-")
            let number = array.first ?? "--"
            let name = array.last ?? "--"
            
            cell.setup(number: number, name: name)
         
            //add
            //26
            let now = arrayDays.count - 4
            if item == now, let last = arrayDays.last {
                let newArray = CalendarManager.shared.addDate(countOfDays: 13, initialDate: last, to: .forward)
                arrayDays += newArray
                collectionView.reloadData() //???
            }
            
            //visible center
            if number == "1" {
                let visibleIndexPaths = collectionView.indexPathsForVisibleItems.map({$0.item})
                let path = (visibleIndexPaths.count - 1) / 2
                let row = visibleIndexPaths[path]
                
                arrayMonth[0] = arrayDays[item].toString("MMMM yyyy")
                arrayMonth[1] = arrayDays[row].toString("MMMM yyyy")
                arrayMonth[2] = arrayDays[item].toString("MMMM yyyy")
                
                monthCollectionView.reloadData()
                monthCollectionView.scrollToItem(at: .init(item: 1, section: 0), at: .centeredHorizontally, animated: false)
                dayFrame = cell.frame.minX
                print(cell.frame, monthFrame)
            }
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    
    // one------two------three
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView == dayCollectionView {
//            let width = scrollView.bounds.width
//            
//            if ((dayFrame - width)...dayFrame).contains(scrollView.contentOffset.x) {
//                let x = dayFrame - scrollView.contentOffset.x
////                print("ячейку видно на экране -> ", x)
//                print(x, monthCollectionView.contentOffset.x)
//            }
//            
////            print(scrollView.contentOffset.x, mounthFrame)
//        }
        
        let width = scrollView.bounds.width
        
        if ((dayFrame - width)...dayFrame).contains(scrollView.contentOffset.x) {
            let x = dayFrame - scrollView.contentOffset.x
//                print("ячейку видно на экране -> ", x)
            print(x, monthCollectionView.contentOffset.x)
            monthCollectionView.contentOffset.x = monthFrame + width - x
        }
//            print(scrollView.contentOffset.x, mounthFrame)
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
        label.backgroundColor = .systemGray
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
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
        
        content.scrollToNowDate()
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

enum ToDate {
    case forward
    case back
}

class CalendarManager {
    private init() { }
    static let shared: CalendarManager = .init()
    
    func createArrayDays(countOfDays: Int) -> [Date] {
        // Создаем календарь
        let calendar = Calendar.current

        // Получаем текущую дату
        let currentDate = Date()

        // Создаем диапазон дат от текущей даты -15 дней до +15 дней
        let number = countOfDays / 2
        if let startDate = calendar.date(byAdding: .day, value: -number, to: currentDate),
           let endDate = calendar.date(byAdding: .day, value: number, to: currentDate) {

            // Создаем массив дат в этом диапазоне
            var arrayDays: [Date] = []
            var date = startDate

            while date <= endDate {
                arrayDays.append(date)
                date = calendar.date(byAdding: .day, value: 1, to: date)!
            }

            // Выводим массив дат
           return arrayDays
        } else {
            print("Ошибка при создании диапазона дат")
            return []
        }
    }
    
    
    
    
    func addDate(countOfDays: Int, initialDate: Date, to: ToDate) -> [Date] {
        // Создаем календарь
        let calendar = Calendar.current
        
        func startAction(start: Date, end: Date) -> [Date] {
            var arrayDays: [Date] = []
            var date = start
            
            while date <= end {
                arrayDays.append(date)
                date = calendar.date(byAdding: .day, value: 1, to: date)!
            }
            return arrayDays
        }
        
        switch to {
        case .forward:
            if let start = calendar.date(byAdding: .day, value: 1, to: initialDate),
               let end = calendar.date(byAdding: .day, value: countOfDays, to: start) {
                return startAction(start: start, end: end)
            } else {
                return []
            }
            
        case .back:
            if let end = calendar.date(byAdding: .day, value: -1, to: initialDate),
               let start = calendar.date(byAdding: .day, value: -countOfDays, to: end) {
                return startAction(start: start, end: end)
            } else {
                return []
            }
        }
    }
}


