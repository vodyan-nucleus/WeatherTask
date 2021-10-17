//
//  DailyForecastViewController.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 17.10.2021.
//

import UIKit

class DailyForecastViewController: UIViewController {
    
    var presenter: DailyForecastPresenterProtocol!
    
    private lazy var dailyForecastTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorColor = .lightText
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
        tableView.register(DailyForecastTableViewCell.self, forCellReuseIdentifier: DailyForecastTableViewCell.identifier)
        tableView.register(HourlyForecastTableViewCell.self, forCellReuseIdentifier: HourlyForecastTableViewCell.identifier)
        return tableView
    }()
    
    private func setLayout() {
        view.addSubview(dailyForecastTableView)
        NSLayoutConstraint.activate([
            dailyForecastTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            dailyForecastTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            dailyForecastTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dailyForecastTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        view.backgroundColor = .systemCyan
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startSpinner()
        presenter.viewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopSpinner()
        presenter.viewWillDisappear()
    }
}
//MARK: - DailyForecastViewProtocol
extension DailyForecastViewController: DailyForecastViewProtocol{
    func success() {
        dailyForecastTableView.reloadData()
        stopSpinner()
    }
    
    func failure(error: Errors) {
        showAlert(title: error.title, message: error.body) { action in
            self.presenter.retryPressed()
        }
    }
}

//MARK: - TableView
extension DailyForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dailyForecastTableView.dequeueReusableCell(withIdentifier: DailyForecastTableViewCell.identifier, for: indexPath) as! DailyForecastTableViewCell
        if let dailyForecastModel = presenter.dailyForecastModel {
            cell.timeLabel.text = dailyForecastModel[indexPath.row].time
            cell.iconImage.image = UIImage(named: "\(dailyForecastModel[indexPath.row].weatherIcon)")
            cell.tempLabel.text = dailyForecastModel[indexPath.row].temperatureString
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
