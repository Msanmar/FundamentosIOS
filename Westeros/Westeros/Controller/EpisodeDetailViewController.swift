//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by Monica Sanmartin on 27/06/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var textLabelEpisodeTitle: UILabel!
    @IBOutlet weak var textLabelEpisodeDirector: UILabel!
    @IBOutlet weak var textTextEpisodeSummary: UITextView!
    
    // MARK: - Properties
    private let model: Chapter
    
    // MARK: - Initialization
    init(model: Chapter){
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Details of Episode:    \(model.title)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textLabelEpisodeTitle.text = model.title
        textLabelEpisodeDirector.text = model.director
        textTextEpisodeSummary.text = model.summary
    }


}
