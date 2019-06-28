//
//  SeasonListTableViewController.swift
//  Westeros
//
//  Created by Monica Sanmartin on 25/06/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import UIKit

// MARK: - Protocolo de delegado
protocol SeasonListViewControllerDelegate: class {
    func seasonListViewController( // dos parámetros: nombre del elemento que tiene el delegado, parámetro de tipo de acción
        _ viewController: SeasonListViewController,
        didSelectSeason season: Season
    )
}


class SeasonListViewController: UITableViewController {
    
    enum Constants {
        static let seasonKey: String = "SeasonKey"
        static let seasonDidChangeNotificationName = "SeasonDidChangeNotificationName"
    }
    
    // MARK: - Properties
    private let model: [Season]
    weak var delegate: SeasonListViewControllerDelegate?
    
    // MARK: - Initialization
    init(model: [Season]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Westeros: List Of Seasons"
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
        // Id de celda + celda a representar
        let cellId = "SeasonCell"
        let season = model[indexPath.row]
        
        // Crear una celda
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            ??
            UITableViewCell(style: .default, reuseIdentifier: cellId)
        
        // Sicronizar modelo(house)-vista(celda)
        cell.textLabel?.text = season.name
        
      
        // Devolver la celda
        return cell
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Averiguar qué casa se ha pulsado
        let season = model[indexPath.row]
        
        // Avisar al delegado: enviamos la información de que se ha seleccionado una casa
        delegate?.seasonListViewController(self, didSelectSeason: season)

        // Mandamos la misma información a través de las notificacions
        let notificationCenter = NotificationCenter.default
        
        let dictionary = [Constants.seasonKey: season]
        
        let notification = Notification(
            name: .seasonDidNotificationName,
            object: self,
            userInfo: dictionary
        )
        
        notificationCenter.post(notification)
    }
}
