//
//  EpisodeListViewController.swift
//  Westeros
//
//  Created by Monica Sanmartin on 27/06/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import UIKit

class EpisodeListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    let model: [Chapter]
    
    // MARK: - Initialization
    init(model: [Chapter]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Episodes of the Season"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        subscribeToNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       unsubscribeNotifications()
    }
}

// MARK: - Extensions
extension EpisodeListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Id de celda + episodio a mostrar
        let cellId = "EpisodeCell"
        let chapter = model[indexPath.row]
        
        // Crear la celda
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        
        // sincronizar model-view
        cell.textLabel?.text = chapter.title
        cell.detailTextLabel?.text = chapter.director
        
        // Devolver la celda
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar qué casa se ha pulsado
        let chapter = model[indexPath.row]
        
        //Crear VC del episode detail
        let episodeDetailViewController = EpisodeDetailViewController(model: chapter)
        
        //Mostrarlo
        navigationController?.pushViewController(episodeDetailViewController, animated: true)
        
    }
    
}

extension EpisodeListViewController {
    private func subscribeToNotifications() {
        let notificationCenter = NotificationCenter.default
   
        // Nos damos de alta en las notifications
        notificationCenter.addObserver(
            self,
            selector: #selector(seasonDidChange),
            name: .seasonDidNotificationName,
            object: nil) // Objecto que envia la notification
    }
    
    private func unsubscribeNotifications() {
        // Nos damos de baja de las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    @objc private func seasonDidChange(notification: Notification) {
        
        // Averiguar la temporada
        guard let dictionary = notification.userInfo else {
            return
        }
        
        guard let season = dictionary[SeasonListViewController.Constants.seasonKey] as? Season else {
            return
        }
        
        // Cuando se detecta que se ha pulsado una temporada diferente, se actualiza la lista de episodios mostrados
        let episodeListViewController = EpisodeListViewController(model: season.sortedEpisodes.sorted())
        //Mostrarlo
        navigationController?.pushViewController(episodeListViewController, animated: true)
        
    }
}


