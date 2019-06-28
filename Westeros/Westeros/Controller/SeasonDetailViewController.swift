//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by Monica Sanmartin on 25/06/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import UIKit

final class SeasonDetailViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var textLabelName: UILabel!
  
    @IBOutlet weak var textLabelNumEpisodes: UILabel!
    
    @IBOutlet weak var textLabelSummary: UITextView!
    
    // MARK:  - Properties
    private var model: Season
    
    // MARK: Initialization
    init(model: Season) {
        self.model = model
        super.init(nibName: nil, bundle: nil) // Bundle(for: type(of: self))
        //title = model.name
        title = "Detail of Seasons"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        syncModelWithView()
    }
    
}

// MARK: - Extensions
extension SeasonDetailViewController {
    private func setupUI() {
        // Creamos el botón para mostrar la lista de episodios
        let episodesButton = UIBarButtonItem(
            title: "List Of Episodes",
            style: .plain,
            target: self,
            action: #selector(displayEpisodes)
        )
        // Añadimos el botón a la navigation bar
        navigationItem.rightBarButtonItems = [episodesButton]
    }
    
    
    @objc private func displayEpisodes() {
        
        // Creo el episodeListVC
       let episodeListViewController = EpisodeListViewController(model: model.sortedEpisodes.sorted())
        
        // Hago push para mostrarlo
        navigationController?.pushViewController(
            episodeListViewController,
          animated: true
        )
    }
}


extension SeasonDetailViewController {
    private func syncModelWithView() {
      
        textLabelName.text = model.name
        textLabelSummary.text = model.summary
        textLabelNumEpisodes.text = "Total episodios: \(model.totalEpisodes)"
    
    }

}


extension SeasonDetailViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason season: Season) {
        model = season
        syncModelWithView()
    }
    
}
