//
//  HouseListViewController.swift
//  Westeros
//
//  Created by Alexandre Freire on 18/06/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import UIKit

// MARK: - Protocolo de delegado
protocol HouseListViewControllerDelegate: class {
    func houseListViewController( // dos parámetros: nombre del elemento que tiene el delegado y parámetro de tipo de acción
        _ viewController: HouseListViewController,
        didSelectHouse house: House
    )
}

// MARK: - Clase principal del controlador
class HouseListViewController: UITableViewController {
    
    enum Constants {
        //let HOUSE_KEY: String: "HouseKey"
        //let HOUSE_DID_CHANGE_NOTIFICATION_NAME : String = "HouseDidChangeNotificationName"
        //let LAST_HOUSE_KEY = "LastHouseKey"
        
        static let houseKey: String = "HouseKey"
        static let lastHouseKey = "LastHouseKey"
        static let houseDidChangeNotificationName = "HouseDidChangeNotificationName"
    }

    // MARK: - Properties
    private let model: [House]
    weak var delegate: HouseListViewControllerDelegate? //opcional porque no tiene por qué tener un delegate
    
    // MARK: - Initialization
    init(model: [House]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Westeros: List Of Houses"
    }
    
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Métodos del table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Id de celda + averiguar qué casa tenemos que mostrar
        let cellId = "HouseCell"
        let house = model[indexPath.row]
        
        // Crear una celda
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            ??
            UITableViewCell(style: .default, reuseIdentifier: cellId)
        
        // Sicronizar modelo(house)-vista(celda)
        cell.textLabel?.text = house.name
        cell.imageView?.image = house.sigil.image
        
        // Devolver la celda
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Averiguar qué casa se ha pulsado
        let house = model[indexPath.row]
    
        // Avisar al delegado: enviamos información de que se ha seleccionado una casa
        delegate?.houseListViewController(self, didSelectHouse: house)
     
      
        // Mandamos la misma información a través de las notificacions (en este caso para WikiListVC)
        let notificationCenter = NotificationCenter.default
        
        let dictionary = [Constants.houseKey: house]
        
        let notification = Notification(
            name: .houseDidNotificationName,
            object: self,
            userInfo: dictionary
        )
        
        notificationCenter.post(notification)
        
        // Guardar la última casa seleccionada (persistencia)
        saveLastSelectedHouse(at: indexPath.row)
    }
}

extension HouseListViewController {
    
    private func saveLastSelectedHouse(at index: Int) {
        // Escribimos en UserDefaults
        let userDefaults = UserDefaults.standard //singleton
        userDefaults.set(index, forKey: Constants.lastHouseKey)
        userDefaults.synchronize() // Por si acaso pero desde hace varias versiones de IOS no es necesario
    }
    
    func lastSelectedHouse() -> House {
        // Leer de User Defaults
        let userDefaults = UserDefaults.standard
        let lastIndex = userDefaults.integer(forKey: Constants.lastHouseKey) // 0 is the default
        
        // Devolvemos la casa
        return model[lastIndex]
    }
}
