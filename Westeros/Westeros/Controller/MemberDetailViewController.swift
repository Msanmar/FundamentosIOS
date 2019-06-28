//
//  MemberDetailViewController.swift
//  Westeros
//
//  Created by Monica Sanmartin on 25/06/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var textLabelMemberDetail: UILabel!
    @IBOutlet weak var imageHouseMember: UIImageView!
    @IBOutlet weak var textLabelMemberAlias: UILabel!
    
    // MARK: - Properties
    private let model: Person
    
    // MARK: - Initialization
    init(model: Person){
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Details of Member:    \(model.name)"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textLabelMemberDetail.text! = model.name
        imageHouseMember.image = model.house.sigil.image
        textLabelMemberAlias.text = model.alias
    }
    
}
