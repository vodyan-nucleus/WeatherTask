//
//  HourlyForecastTableViewCell.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 15.10.2021.
//

import UIKit

class HourlyForecastTableViewCell: UITableViewCell {
    
    static let identifier = "HourlyForcastTableViewCell"
    
    var forecastCollectionView: UICollectionView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpForecastCollectionView()
        backgroundColor = .clear
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func setUpForecastCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.scrollDirection = .horizontal

        forecastCollectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)

        forecastCollectionView.showsHorizontalScrollIndicator = false
        forecastCollectionView.translatesAutoresizingMaskIntoConstraints = false
        forecastCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        forecastCollectionView.backgroundColor = .clear
        forecastCollectionView.isScrollEnabled = true
        contentView.isUserInteractionEnabled = false
    }
    
    private func setLayout() {
        addSubview(forecastCollectionView)
        
        NSLayoutConstraint.activate([
            forecastCollectionView.topAnchor.constraint(equalTo: topAnchor),
            forecastCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            forecastCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            forecastCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate) {
        forecastCollectionView.delegate = dataSourceDelegate
        forecastCollectionView.dataSource = dataSourceDelegate
        forecastCollectionView.reloadData()
    }
}
