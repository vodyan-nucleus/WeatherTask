//
//  WeatherViewController.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 15.10.2021.
//

import UIKit

class WeatherViewController: UIViewController {
    var presenter: WeatherViewPresenterProtocol!
    
    private lazy var weatherInfoTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorColor = .lightText
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = .clear
        tableView.register(BasicInfoTableViewCell.self, forCellReuseIdentifier: BasicInfoTableViewCell.identifier)
        tableView.register(HourlyForecastTableViewCell.self, forCellReuseIdentifier: HourlyForecastTableViewCell.identifier)
        tableView.register(AdvancedInfoTableViewCell.self, forCellReuseIdentifier: AdvancedInfoTableViewCell.identifier)
        return tableView
    }()
    
    private func setLayout() {
        view.addSubview(weatherInfoTableView)
        NSLayoutConstraint.activate([
            weatherInfoTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            weatherInfoTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            weatherInfoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weatherInfoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        setLayout()
        navigationItem.title = "Today"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
}

//MARK: - WeatherViewProtocol
extension WeatherViewController: WeatherViewProtocol {
    func success() {
        weatherInfoTableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

//MARK: - TableView
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 9
        default:
            fatalError("Unexpected section \(section)")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = weatherInfoTableView.dequeueReusableCell(withIdentifier: BasicInfoTableViewCell.identifier, for: indexPath) as! BasicInfoTableViewCell
            return cell
        case 1:
            let cell = weatherInfoTableView.dequeueReusableCell(withIdentifier: HourlyForecastTableViewCell.identifier, for: indexPath) as! HourlyForecastTableViewCell
            cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self)
            return cell
        case 2:
            let cell = weatherInfoTableView.dequeueReusableCell(withIdentifier: AdvancedInfoTableViewCell.identifier, for: indexPath) as! AdvancedInfoTableViewCell
            return cell
        default:
            fatalError("Unexpected row \(indexPath.row) in section \(indexPath.section)")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 250
        case 1:
            return 130
        case 2:
            return 60
        default:
            fatalError("Unexpected row \(indexPath.row) in section \(indexPath.section)")
        }
        
    }
}

//MARK: - CollectionView
extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        return myCell
        
    }
}
