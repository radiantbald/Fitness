//
//  CalendarCollectionView.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 27.02.2024.
//

import UIKit

protocol CalendarProtocol: AnyObject {
    func maxOffsetLeft()
    func maxOffsetRight()
}

class CalendarCollectionView: UICollectionView {
    
    weak var calendarDelegate: CalendarProtocol?
    
    private var daysArray = [DateModel]()
    
    private let collectionLayout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: collectionLayout)
        setupLayout()
        configure()
        setDelegates()
        register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        collectionLayout.minimumLineSpacing = 3
        collectionLayout.scrollDirection = .horizontal
    }
    
    private func configure() {
        backgroundColor = .none
        bounces = false
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setDelegates() {
        delegate = self
        dataSource = self
    }
    
    public func setDaysArray(_ array: [DateModel]) {
        daysArray = array
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x < 5 {
            calendarDelegate?.maxOffsetLeft()
        }
        let offset = (self.frame.width / 7 - 11) * 14
        if scrollView.contentOffset.x > offset {
//            print(scrollView.contentOffset.x, self.bounds.width * 2)
            calendarDelegate?.maxOffsetRight()
        }
        print(scrollView.contentOffset.x, offset)
    }
}

extension CalendarCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else {
            return UICollectionViewCell()
        }
        let dateModel = daysArray[indexPath.row]
        cell.configure(dateModel)
        return cell
    }
}

extension CalendarCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tapCell")
    }
}

extension CalendarCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 7.5,
               height: collectionView.frame.height)
    }
}
