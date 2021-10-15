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
        let appearance = UITabBarAppearance()
        tabBar.scrollEdgeAppearance = appearance
    }
    
    private func setupTabBar() {
        let todayWeatherVC = ModuleBuilder.createTodayWeatherModule()
        
        todayWeatherVC.tabBarItem.title = "Today"
        todayWeatherVC.tabBarItem.image = UIImage(systemName: "sun.max")

        self.setViewControllers([todayWeatherVC], animated: false)

}
}
