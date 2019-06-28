//
//  AppDelegate.swift
//  Westeros
//
//  Created by Alexandre Freire on 10/06/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

// should - will - did
import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    // MARK: - Properties
    var window: UIWindow?
    weak var delegate: UITabBarControllerDelegate?
    var splitViewController: UISplitViewController?
    var houseListViewController: HouseListViewController?
    var houseListNavigation: UINavigationController?
    var seasonListViewController: SeasonListViewController?
    var seasonListNavigation: UINavigationController?
    var houseDetailViewController: HouseDetailViewController?
    var houseDetailNavigation :UINavigationController?
    var seasonDetailViewController: SeasonDetailViewController?
    var seasonDetailNavigation: UINavigationController?
    var tabBarHouseAndSeason: UITabBarController?

    
   var deviceType: Bool = true
  
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        // Lanzar la app
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        // Crear el modelo
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        
        // Inicialización de los controladores
        houseListViewController = HouseListViewController(model: houses)
        seasonListViewController = SeasonListViewController(model: seasons)
        seasonDetailViewController = SeasonDetailViewController(model: (seasons.first)!)
        
        // Datos de persistencia
        let lastSelectedHouse = houseListViewController!.lastSelectedHouse()
        houseDetailViewController = HouseDetailViewController(model: lastSelectedHouse)
        
        // Asignación de delegados
        houseListViewController!.delegate = houseDetailViewController
        seasonListViewController!.delegate = seasonDetailViewController
        
    
        // Wrap de los controladores en UINavigation
        houseListNavigation = houseListViewController!.wrappedInNavigation()
        houseDetailNavigation = houseDetailViewController!.wrappedInNavigation()
        seasonListNavigation = seasonListViewController!.wrappedInNavigation()
        seasonDetailNavigation = seasonDetailViewController!.wrappedInNavigation()
        
        
        // Creación de un UITabBarController
       tabBarHouseAndSeason = UITabBarController(nibName: nil, bundle: nil)
        
       
      // Asignación de los controladores de las vistas del TabBar
        tabBarHouseAndSeason!.setViewControllers([houseListNavigation!,seasonListNavigation!], animated: true)
        
        // Asignación del delegado
        tabBarHouseAndSeason!.delegate = self
        
        
        // Creación el split view controller
        splitViewController = UISplitViewController()
        
        // Asignación del master & detail del split
        splitViewController?.viewControllers = [tabBarHouseAndSeason!, houseDetailNavigation!]
        
        
 
 // Asignamos el rootViewController
 window?.rootViewController = splitViewController
        
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        
    if viewController == houseListNavigation {
            
            switch (deviceType) {
                
            case true: // es un ipad
              splitViewController?.viewControllers = [tabBarController, houseDetailNavigation!]
                
            case false: // es un iphone
                 print("Seleccionado tab House en iphone")
                
            }
        } else if viewController == seasonListNavigation{
            
            switch (deviceType) {
                
            case true: // es un ipad
                splitViewController?.viewControllers = [tabBarController, seasonDetailNavigation!]
                
            case false: // es un iphone
                 print("Seleccionado tab season en iphone")
               
            }
            
        }
    }
    
}
    


