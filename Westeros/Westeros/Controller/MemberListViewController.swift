//
//  MemberListViewController.swift
//  Westeros
//
//  Created by Alexandre Freire on 18/06/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import UIKit

class MemberListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    let model: [Person]
    
    // MARK: - Initialization
    init(model: [Person]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Members of the House"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        subscribeToNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeNotifications()
    }
    
}

// MARK: Extensiones:
extension MemberListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Id de celda + descubrir qué personaje hay que mostrar
        let cellId = "PersonCell"
        let person = model[indexPath.row]
        
        // Crear la celda
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        
        // sincronizar model-view
        cell.textLabel?.text = person.fullName
        cell.detailTextLabel?.text = person.alias
        
        // Devolver la celda
        return cell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Averiguar qué casa se ha pulsado
        let person = model[indexPath.row]
        
         //Crear VC del member detail
         let memberDetailViewController = MemberDetailViewController(model: person)
        
        //Mostrarlo mediante push
        navigationController?.pushViewController(memberDetailViewController, animated: true)
    
    }

}

extension MemberListViewController {
    private func subscribeToNotifications() {
        let notificationCenter = NotificationCenter.default
        // Nos damos de alta en las notifications
        notificationCenter.addObserver(
            self,
            selector: #selector(houseDidChange),
            name: .houseDidNotificationName,
            object: nil) // Objecto que envia la notification
    }
    
    private func unsubscribeNotifications() {
        // Nos damos de baja de las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    @objc private func houseDidChange(notification: Notification) {
        // Averiguar la casa
        guard let dictionary = notification.userInfo else {
            return
        }
        
        guard let house = dictionary[HouseListViewController.Constants.houseKey] as? House else {
            return
        }
        
        // Cuando detectamos que se ha pulsado otra casa hay que actualizar la vista de la lista de personajes
        let memberListViewController = MemberListViewController(model: house.sortedMembers)
        
        // Mostrarlo mediante push
        navigationController?.pushViewController(memberListViewController, animated: true)

    }
}


