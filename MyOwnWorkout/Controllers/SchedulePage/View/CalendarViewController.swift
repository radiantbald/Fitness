//
//  CalendarViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 27.02.2024.
//

import UIKit

class CalendarViewController: GeneralViewController {
    
    private let monthLabel = UILabel("Февраль 2024", .boldSystemFont(ofSize: 18), .black)
    private let calendarCollectionView = CalendarCollectionView()
    private let calendarModel = CalendarModel()
    private var centerDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calendarCollectionView.scrollToItem(at: [0, 10], at: .centeredHorizontally, animated: false)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        updateDate(day: 0)
        
        calendarCollectionView.calendarDelegate = self
        
        view.addSubviews(monthLabel, calendarCollectionView)
        monthLabel.textAlignment = .center
    }
    private func updateDate(day offset: Int) {
        centerDate = centerDate.getDateWithOffset(with: offset)
        let daysArray = calendarModel.getWeekForCalendar(date: centerDate)
        
        calendarCollectionView.setDaysArray(daysArray)
        calendarCollectionView.reloadData()
        calendarCollectionView.scrollToItem(at: [0, 10], at: .centeredHorizontally, animated: false)
        
        if daysArray[7].monthName == daysArray[13].monthName {
            monthLabel.text = daysArray[7].monthName
        } else {
            monthLabel.text = "\(daysArray[7].monthName) - \(daysArray[13].monthName)"
        }
    }
}

extension CalendarViewController: CalendarProtocol {
    func maxOffsetLeft() {
        updateDate(day: -7)
    }
    
    func maxOffsetRight() {
        updateDate(day: 7)
    }
}

extension CalendarViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            monthLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            monthLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            monthLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            monthLabel.heightAnchor.constraint(equalToConstant: 30),
            
            calendarCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            calendarCollectionView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 5),
            calendarCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            calendarCollectionView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
