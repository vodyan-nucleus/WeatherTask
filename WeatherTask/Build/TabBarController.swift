//
//  TabBarController.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 15.10.2021.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupTabBarAppearance()
    }
    
    private func setupTabBar() {
        let todayWeatherVC = ModuleBuilder.createTodayWeatherModule()
        let dailyForecastVC = ModuleBuilder.createDailyForecastModule()
        
        todayWeatherVC.tabBarItem.title = "Сегодня"
        todayWeatherVC.tabBarItem.image = UIImage(systemName: "sun.max")
        dailyForecastVC.title = "Прогноз"
        dailyForecastVC.tabBarItem.image = UIImage(systemName: "cloud.moon")

        self.setViewControllers([todayWeatherVC, dailyForecastVC], animated: false)
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        tabBar.scrollEdgeAppearance = appearance
        tabBar.layer.cornerRadius = 20
        tabBar.layer.masksToBounds = true
    }
}
