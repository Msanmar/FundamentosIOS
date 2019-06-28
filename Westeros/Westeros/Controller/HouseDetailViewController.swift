//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by Alexandre Freire on 13/06/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import UIKit

final class HouseDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var houseNameLabel: UILabel!
    @IBOutlet private weak var sigilImageView: UIImageView!
    @IBOutlet private weak var wordsLabel: UILabel!
    
    // MARK: - Properties
    private var model: House
    
    // MARK: - Initialization
    init(model: House) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        //title = "Detail of House: \(model.name)"
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
extension HouseDetailViewController {
    private func syncModelWithView() {
        houseNameLabel.text = "House \(model.name)"
        sigilImageView.image = model.sigil.image
        wordsLabel.text = model.words
        title = "Detail of House: \(model.name)"
    }
}

extension HouseDetailViewController {
    private func setupUI() {
        // Creo mi botón
        let wikiButton = UIBarButtonItem(
            title: "Go To Wiki",
            style: .plain,
            target: self,
            action: #selector(displayWiki)
        )
        
        let membersButton = UIBarButtonItem(
            title: "List Of Members",
            style: .plain,
            target: self,
            action: #selector(displayMembers)
        )
        
        // Lo añado a la navigation bar
        navigationItem.rightBarButtonItems = [membersButton, wikiButton]
    }
    
    @objc private func displayWiki() {
        // Crear el wikiVC
        let wikiViewController = WikiViewController(model: model)
        
        // Mostrarlo mediante un push navigation controller
        navigationController?.pushViewController(wikiViewController, animated: true)
    }
    
    @objc private func displayMembers() {
        
        
        // Creo el MemberListVC
        let memberListViewController = MemberListViewController(model: model.sortedMembers)
        
        // Hago push
        navigationController?.pushViewController(
            memberListViewController,
            animated: true
        )
    }
}

// MARK: - House List View COntroller delegate
extension HouseDetailViewController: HouseListViewControllerDelegate{
    func houseListViewController(_ viewController: HouseListViewController, didSelectHouse house: House) {
        model = house
        title = "Members of selected house: \(house.name)"
        syncModelWithView()
    }
    
   
}
